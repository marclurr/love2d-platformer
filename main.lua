tiny = require("lib.tiny")
Components = require("game.components")

CELL_SIZE = 16
DRAW_WIDTH = 320
DRAW_HEIGHT = 180
DRAW_SCALE = love.graphics.getWidth() / DRAW_WIDTH

WORLD_WIDTH = DRAW_WIDTH / CELL_SIZE
WORLD_HEIGHT = DRAW_HEIGHT / CELL_SIZE

viewportY = 0

function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- local d = "width = 1280"
-- local s, e = string.find(d, "=")
-- local v = string.sub(d, e + 1)
-- local w = love.data.unpack("J", "1280")
-- print(tostring(w))



love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setLineStyle("rough")

require("framework.helpers")
require("assets")
require("levels")
require("ui.menus")

local Button = require("framework.button")

local inputEvents = {}
table.insert(inputEvents, {name="up", bindings={keyboard="w", gamepad="dpup"}})
table.insert(inputEvents, {name="down", bindings={keyboard="s", gamepad="dpdown"}})
table.insert(inputEvents, {name="left", bindings={keyboard="a", gamepad="dpleft"}})
table.insert(inputEvents, {name="right", bindings={keyboard="d", gamepad="dpright"}})
table.insert(inputEvents, {name="jump", bindings={keyboard="j", gamepad="a"}})
table.insert(inputEvents, {name="attack", bindings={keyboard="k", gamepad="x"}})

table.insert(inputEvents, {name="ui_accept", bindings={keyboard="j", gamepad="a"}})
table.insert(inputEvents, {name="ui_cancel", bindings={keyboard="escape", gamepad="start"}})


input = {}
inputMap = {
    keyboard = {},
    gamepad = {}
}


for _, event in ipairs(inputEvents) do
    input[event.name] = Button(event.name)
    if (inputMap.keyboard[event.bindings.keyboard] == nil) then
        inputMap.keyboard[event.bindings.keyboard] = {}
    end
    if (inputMap.gamepad[event.bindings.gamepad] == nil) then
        inputMap.gamepad[event.bindings.gamepad] = {}
    end

    table.insert(inputMap.keyboard[event.bindings.keyboard], input[event.name])
    table.insert(inputMap.gamepad[event.bindings.gamepad], input[event.name])

end

function defineBooleanOption(labels, default)
    return {
        type = "boolean",
        labels = labels,
        value = value
    }
end

options = {}
options.video = {}
options.video.fullscreen = {
    options = {
        defineBooleanOption("Off", false),
        defineBooleanOption("On", true)
    },
    defaultValue 

}

Gamestate = require("lib.hump.gamestate")

local GameState = require("game")
local PauseState = require("pause")
local TitleState = require("title_menu")
local GameOverState = require("game_over")

function love.load(args)
    love.window.setMode(DRAW_WIDTH * 4, DRAW_HEIGHT * 4)
    updateDrawScaling()
    

    drawbuf = love.graphics.newCanvas(DRAW_WIDTH+16, DRAW_HEIGHT+16)

    Gamestate.registerEvents()
    game = GameState()
    title = TitleState()
    pause = PauseState()
    gameOver = GameOverState()

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
        Gamestate.switch(title)
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

fnt = love.graphics.newFont(10, "mono")
local fnt2 = love.graphics.newFont(16, "mono")

function love.draw()
    -- render game
    love.graphics.setCanvas(drawbuf)
    love.graphics.clear()

    local cx, cy = game.camera:topLeft()
    Gamestate.draw()

    -- render and scale to current viewport
    love.graphics.setCanvas()
    love.graphics.setColor(1, 1, 1, 1)
   
    local xOff = 0
    local yOff = 0

    if (Gamestate.current() == game) then
        xOff = -(game.camera.pos.x - math.floor(game.camera.pos.x))
        yOff = -(game.camera.pos.y - math.floor(game.camera.pos.y))
    end


    love.graphics.draw(drawbuf, xOff, viewportY + yOff, 0, DRAW_SCALE, DRAW_SCALE)
    
    if (programSwitches.debug) then 
        love.graphics.print(tostring(love.timer.getFPS()) .. "FPS" .. " " .. tostring(love.timer.getDelta()*1000) .. "ms", 10, 10)
        love.graphics.print(tostring(#game.manager.entities) .. " entities", 10, 22)
        love.graphics.print(tostring(game.manager.world:countItems()) .. " colliders", 10, 34)
        if (game.player) then
            love.graphics.print("Player pos: " .. tostring(game.player.x) .. ", " .. tostring(game.player.y), 10, 46)
        end
        love.graphics.print(tostring(game.registry:getEntityCount()) .. " entities",10, 58)
    end
end


function love.resizes(w, h)
    DRAW_SCALE = love.graphics.getWidth() / DRAW_WIDTH
    if (DRAW_SCALE - math.floor(DRAW_SCALE) ~= 0) then
        local height = DRAW_HEIGHT * DRAW_SCALE
        viewportY = (love.graphics.getHeight() - height) / 2
    else
        viewportY = 0
    end
end


