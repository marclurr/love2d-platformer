local Object = require("lib.classic")
local Gamestate = require("lib.hump.gamestate")
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


eventBus = Registry()

input = {
    left = Button(),
    right = Button(),
    down = Button(),
    jump = Button()
}

local inputMap = {
    keyboard = {
        a = input.left,
        s = input.down,
        d = input.right,
        j = input.jump
    },

    gamepad = {
        dpleft = input.left,
        dpdown = input.down,
        dpright = input.right,
        a = input.jump
    }
}

local entityFactories = {
    trigger = require("game.entities.trigger"),
    trap_spikes = require("game.entities.trap_spikes"),
    stone = require("game.entities.stone"),
    button = require("game.entities.button"),
    strange_door = require("game.entities.strange_door")
}

local Game = Object:extend()

function Game:new()
    self.camera = Camera(DRAW_WIDTH, DRAW_HEIGHT)

end

function Game:onPlayerDied()
    -- print("The player died, bloody hell")
    player:spawn(self.playerSpawnX, self.playerSpawnY)
end


function Game:loadLevel(level)
    self.manager = EntityManager()
    self.tilemap = TileMap()
    self.tilemap.onTileAdded = registerTileMapCollisions(self.manager.world) 

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
    self.camera.max_x = self.tilemap.width * self.tilemap.tilewidth
    self.camera.max_y = self.tilemap.height * self.tilemap.tileheight

    if (player) then 
        self.manager:add(player)
        player:spawn(self.playerSpawnX, self.playerSpawnY)
    end
end

function Game:enter(old, level)
    player = Player()
    self:loadLevel(level)
end


function Game:update(dt)
    self.manager:update(dt)

    if (player) then
        self.camera:setPosition(player.x, player.y)

        if (not player:isDead() and player.y > self.tilemap.height * self.tilemap.tileheight) then
            player:kill()
        end
    end

    if (self.currentLevel.update) then 
        self.currentLevel:update(dt)
    end

    for k, b in pairs(input) do
        b:update()
    end
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

        local items, len = self.manager.world:getItems()
        for i=1,len do
            local t = items[i]
            if (t.noDebug ~= true) then
                love.graphics.setColor(1, 1, 1, 1)

                if (t == player) then 
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

function Game:keyreleased(key)
    if (inputMap.keyboard[key]) then
        inputMap.keyboard[key]:release()
    end
    if (key == "escape") then 
        love.event.quit()
    elseif (key == "1") then
        self:loadLevel(levels.debug)
    elseif (key == "2") then
        self:loadLevel(levels.level1)
    elseif (key == "f11") then
        love.window.setFullscreen(not love.window.getFullscreen(), "desktop")
        DRAW_SCALE = love.graphics.getWidth() / DRAW_WIDTH
    end
end

function Game:keypressed(key)
    if (inputMap.keyboard[key]) then
        inputMap.keyboard[key]:press()
    end

    if (key == "x") then
        programSwitches.debug = not programSwitches.debug
    end
end


function Game:gamepadpressed(j, button)
    if (inputMap.gamepad[button]) then
        inputMap.gamepad[button]:press()
    end
end


function Game:gamepadreleased(j, button)
    if (inputMap.gamepad[button]) then
        inputMap.gamepad[button]:release()
    end
end

return Game
