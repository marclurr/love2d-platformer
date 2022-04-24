CELL_SIZE = 16
DRAW_WIDTH = 320
DRAW_HEIGHT = 180
DRAW_SCALE = love.graphics.getWidth() / DRAW_WIDTH

WORLD_WIDTH = DRAW_WIDTH / CELL_SIZE
WORLD_HEIGHT = DRAW_HEIGHT / CELL_SIZE

love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setLineStyle("rough")

require("framework.helpers")
require("assets")
require("levels")

Gamestate = require("lib.hump.gamestate")

local Game = require("game")

local gs = {}

function gs:keyreleased(key, code)
    Gamestate.switch(game, levels.debug)
   
end

function love.load(args)
    
    drawbuf = love.graphics.newCanvas(DRAW_WIDTH, DRAW_HEIGHT)

    Gamestate.registerEvents()
    game = Game()

    programSwitches = {debug = false}

    processProgramArguments(args)

    
    if (programSwitches.level) then 
        local levelName = programSwitches.level
        local level = levels[levelName]
        if (level) then
            Gamestate.switch(game, level)
        else
            print("Undefined level [" .. levelName .. "]")
            love.event.quit()
        end
    else
        Gamestate.switch(gs)
    end

end



function love.update(dt)
    Gamestate.update(dt)
end

function round(x) 
    return math.floor(0.5 + x)
end

function rem(x)
    return x - round(x)
end

local fnt = love.graphics.newImageFont("assets/fonts/fonts.png", "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!?/")
-- fnt:setFilter("nearest", "nearest")
function love.draw()
    love.graphics.setCanvas(drawbuf)
    love.graphics.clear()

    local cx, cy = game.camera:topLeft()
    Gamestate.draw()
    love.graphics.print("hello world", fnt, 100, 100)
    
    love.graphics.setCanvas()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(drawbuf, 0, 0, 0, DRAW_SCALE, DRAW_SCALE)
    
    if (programSwitches.debug) then 
        love.graphics.print(tostring(love.timer.getFPS()) .. "FPS" .. " " .. tostring(love.timer.getDelta()*1000) .. "ms", 10, 10)
        love.graphics.print(tostring(#game.manager.entities) .. " entities", 10, 22)
        love.graphics.print(tostring(game.manager.world:countItems()) .. " colliders", 10, 34)
    end
end


