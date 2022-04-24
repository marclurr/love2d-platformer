local Object = require("lib.classic")

local BaseState = Object:extend()


function BaseState:update(dt)
    self:updateInput()
end

function BaseState:updateInput()
    for k, b in pairs(input) do
        b:update()
    end
end

function BaseState:keyreleased(key)
    if (inputMap.keyboard[key]) then
        for _, b in ipairs(inputMap.keyboard[key]) do
           b:release()
        end
    end

    if (input.ui_cancel:justReleased()) then
        love.event.quit()
    end

    -- if (key == "escape") then 
    --     love.event.quit()
    -- elseif (key == "1") then
    --     self:loadLevel(levels.debug)
    -- elseif (key == "2") then
    --     self:loadLevel(levels.level1)
    -- elseif (key == "f11" or key == "p") then
    --     love.window.setFullscreen(not love.window.getFullscreen(), "desktop")
    --     DRAW_SCALE = love.graphics.getWidth() / DRAW_WIDTH
    -- end
end

function BaseState:keypressed(key)
    if (inputMap.keyboard[key]) then
        for _, b in ipairs(inputMap.keyboard[key]) do
           b:press()
        end
    end

    if (key == "x") then
        programSwitches.debug = not programSwitches.debug
    end
end


function BaseState:gamepadpressed(j, button)
    if (inputMap.gamepad[button]) then
        inputMap.gamepad[button]:press()
    end
end


function BaseState:gamepadreleased(j, button)
    if (inputMap.gamepad[button]) then
        inputMap.gamepad[button]:release()
    end
end

return BaseState