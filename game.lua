local Object = require("lib.classic")
local Gamestate = require("lib.hump.gamestate")
local BaseState = require("base_state")
local Registry = require("lib.hump.signal")
local bump = require("lib.bump")
local anim8 = require("lib.anim8")
local gamestate = require("lib.hump.gamestate")
local vector = require("lib.hump.vector")
local TileMap = require("framework.tilemap")
local Camera = require("framework.camera")
local BackgroundLayer = require("framework.background")
local Button = require("framework.button")
local Player = require("game.entities.player")
local KillZone = require("game.entities.kill_zone")

local drawFilter = tiny.requireAll('isDrawSystem')
drawFilter = function(world, system)
    if (Gamestate.current() ~= game) then
        return system.isDrawSystem and system.drawWhenPaused
    end
    return system.isDrawSystem 
end
local updateFilter = tiny.rejectAny('isDrawSystem')

COLLISION_SOLID = 1
COLLISION_PICKUP = 2
COLLISION_ACTORS = 4


eventBus = Registry()

local tilePrefabs = {}
tilePrefabs.normal_block = {
    ["solid"] = true
}
tilePrefabs.one_way_block = {
    ["solid"] = true,
    ["one_way"] = true
}

local entityFactories = {
    --  trigger = require("game.entities_old.trigger"),
    trap_spikes = require("game.entities.trap_spikes"),
    stone = require("game.entities.stone"),
    button = require("game.entities.switch"),
    mushroom = require("game.entities.mushroom"),

    --  strange_door = require("game.entities_old.strange_door"),
    --  push_ability_pickup = require("game.entities_old.base_pickup"),
    --  attack_ability_pickup = require("game.entities_old.base_pickup")
}

local Game = BaseState:extend()

function Game:new()
    self.super.new(self)
    self.timestep = 1 / 60
    self.dtAcc = 0
    self.simulationSteps = 0
    self.camera = Camera(DRAW_WIDTH+16, DRAW_HEIGHT+16)

    self.super.registerPressEventHandler(self,"ui_cancel", self.pause)
end

function Game:pause()
    Gamestate.push(pause)
end

function Game:__tostring()
    return "Game"
  end

function Game:onPlayerDied()
    self.player:spawn(self.playerSpawnX, self.playerSpawnY)
    self.camera:setPosition(self.player.x, self.player.y)
end


function Game:loadLevel(level)


    self.world = bump.newWorld()
    self.registry = tiny.world(
        require("game.systems.player_death_system")(),
        require("game.systems.bump_system")(),
        require("game.systems.platforming_system")(),
        require("game.systems.controller_system")(),
        require("game.systems.damage_system")(),
        require("game.systems.physics_system")(),
        
        require("game.systems.platforming_animation")(),
        require("game.systems.trigger_system")(),
        require("game.systems.health_system")(),
        require("game.systems.camera_system")(),

        require("game.systems.custom_draw_system")(),
        require("game.systems.animation_system")(),
        require("game.systems.sprite_system")()
    )
    
    self.tilemap = TileMap(tilePrefabs)
    self.tilemap.onTileAdded = registerTileMapCollisions(self.world) 

    
    self.tilemap.onObject = function(layer, obj) 
        if (obj.type == "player_spawn") then
            self.playerSpawnX = obj.x
            self.playerSpawnY = obj.y
        else
            if (entityFactories[obj.type]) then
                local refId = obj.id
                local r,l = entityFactories[obj.type](layer, obj)
                if (l and l > 0) then 
                    for i = 1,l do
                        self.registry:add(r[i])
                    end
                else
                    r.refId = refId
                    self.registry:add(r)
                end
            end
        end
    end

    self.currentLevel = level

    local loadTiledMap = love.filesystem.load(level.path)
    self.tilemap:load(loadTiledMap(), level.tileset)

    -- limit camera to tilemap boundaries
    self.camera.min_x = 0
    self.camera.min_y = 0
    self.camera.max_x = ((self.tilemap.width-1) * self.tilemap.tilewidth) + 16
    self.camera.max_y = ((self.tilemap.height-1) * self.tilemap.tileheight) +16

    -- setup kill zone below the map
    self.registry:add(KillZone(-1000, self.camera.max_y + 16, self.camera.max_x + 2000, 16))


    self.player = Player(self.playerSpawnX, self.playerSpawnY)
    self.registry:add(self.player)
    self.camera:setPosition(self.player.position.x, self.player.position.y)
end

function Game:enter(old, level)
    self:loadLevel(level)
end


function Game:update(dt)
    self.dtAcc = self.dtAcc + dt

    -- update in discrete steps consuming full delta
    while (self.dtAcc > 0) do
        local ndt = math.min(self.timestep, self.dtAcc)
        self.registry:update(ndt, updateFilter)
        self.dtAcc = self.dtAcc - ndt
    end
    self.super.updateInput(self)
end

function Game:draw()
    local dt = love.timer.getDelta()

    love.graphics.clear()

    local cx, cy = self.camera:topLeft()

    self.camera:attach()

    love.graphics.setColor(1, 1, 1, 1)   
    self.tilemap:draw(cx, cy, self.camera.width, self.camera.height)
    self.registry:update(dt, drawFilter)

    if (programSwitches.debug) then 
        local items, len = self.world:getItems()
        for i=1,len do
            local t = items[i]
            if (t.noDebug ~= true) then
                love.graphics.setColor(1, 1, 1, 1)

                if (t == self.player) then 
                    love.graphics.setColor(0, 1, 0, 1)
                elseif (t.tile and self.tilemap:getTileDef(t.id).properties.one_way) then
                    love.graphics.setColor(1, 1, 0, 1)
                elseif (t.collisionLayer == COLLISION_SOLID or t.tile) then
                    love.graphics.setColor(1, 1, 1, 1)
                elseif (t.causesDamage) then 
                    love.graphics.setColor(1, 0, 0, 1)
                else
                    love.graphics.setColor(0, 0, 1, 1)
                end

                if (t.tile) then
                    love.graphics.rectangle("line", t.x, t.y, t.w, t.h)
                elseif (t.position and t.hitbox) then
                    love.graphics.rectangle("line", t.position.x, t.position.y, t.hitbox.w, t.hitbox.h)
                end
            end
        end
    end
  
    self.camera:detach()
end

return Game
