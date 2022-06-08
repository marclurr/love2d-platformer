local Object = require("lib.classic")
local Gamestate = require("lib.hump.gamestate")
local BaseState = require("base_state")
local Registry = require("lib.hump.signal")
local bump = require("lib.bump")
local anim8 = require("lib.anim8")
local gamestate = require("lib.hump.gamestate")
local vector = require("lib.hump.vector")
local EntityManager = require("framework.entity_manager")
local TileMap = require("framework.tilemap")
local Camera = require("framework.camera")
local BackgroundLayer = require("framework.background")
local Button = require("framework.button")
local Player = require("game.entities.player")


COLLISION_SOLID = 1
COLLISION_PICKUP = 2


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
    trigger = require("game.entities.trigger"),
    trap_spikes = require("game.entities.trap_spikes"),
    stone = require("game.entities.stone"),
    button = require("game.entities.button"),
    strange_door = require("game.entities.strange_door"),
    push_ability_pickup = require("game.entities.base_pickup"),
    attack_ability_pickup = require("game.entities.base_pickup")
}

local Game = BaseState:extend()

function Game:new()
    self.super.new(self)
    self.camera = Camera(DRAW_WIDTH, DRAW_HEIGHT)

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
    self.manager = EntityManager(self.world)
    self.tilemap = TileMap(tilePrefabs)
    self.tilemap.onTileAdded = registerTileMapCollisions(self.world) 

    local manager = self.manager
    self.tilemap.onObject = function(layer, obj) 
        if (obj.type == "player_spawn") then
            self.playerSpawnX = obj.x
            self.playerSpawnY = obj.y
        else
            if (entityFactories[obj.type]) then
                local refId = obj.id
                local r,l = entityFactories[obj.type](layer, obj)
                if (l and l > 0) then 
                    manager:addAll(r)
                else
                    r.refId = refId
                    manager:add(r)
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
    self.camera.max_x = (self.tilemap.width-1) * self.tilemap.tilewidth
    self.camera.max_y = (self.tilemap.height-1) * self.tilemap.tileheight

    if (self.player) then 
        self.manager:add(self.player)
        self.player:spawn(self.playerSpawnX, self.playerSpawnY , false)
        self.camera:setPosition(self.player.x, self.player.y)
    end



end

function Game:enter(old, level)
    self.player = Player()
    self:loadLevel(level)
end


function Game:update(dt)
    self.manager:update(dt)

    if (self.player) then
        local cx = self.camera.pos.x 
        local cy = self.camera.pos.y

        cx = cx + ((self.player.x - cx) * 8 * dt)
        cy = cy + ((self.player.y - cy) * 8 * dt)


        self.camera:setPosition(cx, cy)

        if (not self.player:isDead() and self.player.y > self.tilemap.height * self.tilemap.tileheight) then
            self.player:kill()
        end
    end

    if (self.currentLevel.update) then 
        self.currentLevel:update(dt)
    end

    self.super.updateInput(self)
end

function Game:draw(dt)
    love.graphics.clear()

    local cx, cy = self.camera:topLeft()
    
    for i=1,#self.currentLevel.backgrounds do
        self.currentLevel.backgrounds[i]:draw(cx)
    end
     

    self.camera:attach()

    love.graphics.setColor(1, 1, 1, 1)   
    self.tilemap:draw(cx, cy, self.camera.width, self.camera.height)
    self.manager:draw()

    if (programSwitches.debug) then 
        self.manager:drawDebug()

        local items, len = self.world:getItems()
        for i=1,len do
            local t = items[i]
            if (t.noDebug ~= true) then
                love.graphics.setColor(1, 1, 1, 1)

                if (t == self.player) then 
                    love.graphics.setColor(0, 1, 0, 1)
                elseif (t.tile and self.tilemap:getTileDef(t.id).properties.one_way) then
                    love.graphics.setColor(1, 1, 0, 1)
                elseif (t.debugLabel and t.debugLabel == "danger") then
                    love.graphics.setColor(1, 0, 0, 1)
                end

                love.graphics.rectangle("line", t.x, t.y, t.w, t.h)
            end
        end
    end


    self.camera:detach()
end

return Game
