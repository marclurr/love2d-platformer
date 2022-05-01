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

local Button = require("framework.button")

local inputEvents = {}
table.insert(inputEvents, {name="up", bindings={keyboard="w", gamepad="dpup"}})
table.insert(inputEvents, {name="down", bindings={keyboard="s", gamepad="dpdown"}})
table.insert(inputEvents, {name="left", bindings={keyboard="a", gamepad="dpleft"}})
table.insert(inputEvents, {name="right", bindings={keyboard="d", gamepad="dpright"}})
table.insert(inputEvents, {name="jump", bindings={keyboard="j", gamepad="a"}})

table.insert(inputEvents, {name="ui_accept", bindings={keyboard="j", gamepad="a"}})
table.insert(inputEvents, {name="ui_cancel", bindings={keyboard="escape", gamepad="b"}})


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


Gamestate = require("lib.hump.gamestate")

local Game = require("game")

local gs = require("title_menu")

-- function gs:new()
--     self.super.new(self)
--     self.super.registerReleaseEventHandler(self,"ui_accept", self.startGame)
--     self.super.registerPressEventHandler(self,"ui_accept", self.startGame)
-- end

-- function gs:startGame() 
--     Gamestate.switch(game, levels.debug)
-- end



function love.load(args)
    
    drawbuf = love.graphics.newCanvas(DRAW_WIDTH, DRAW_HEIGHT)

    Gamestate.registerEvents()
    game = Game()
    init = gs()

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
        Gamestate.switch(init)
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
    love.graphics.setCanvas(drawbuf)
    love.graphics.clear()

    local cx, cy = game.camera:topLeft()
    Gamestate.draw()
   -- love.graphics.print("Hello world!?/", fnt, 100, 100)
    love.graphics.setCanvas()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(drawbuf, 0, 0, 0, DRAW_SCALE, DRAW_SCALE)
    
    if (programSwitches.debug) then 
        love.graphics.print(tostring(love.timer.getFPS()) .. "FPS" .. " " .. tostring(love.timer.getDelta()*1000) .. "ms", 10, 10)
        love.graphics.print(tostring(#game.manager.entities) .. " entities", 10, 22)
        love.graphics.print(tostring(game.manager.world:countItems()) .. " colliders", 10, 34)
    end
end


