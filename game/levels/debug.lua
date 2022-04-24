local Level = require("framework.level")
local BackgroundLayer = require("framework.background")

local DebugLevel = Level:extend()

function DebugLevel:new()
    self.super.new(self, "tilemaps/debug.lua", assets.tilesets.mainTileset, {
        BackgroundLayer(assets.backgrounds.bg0, 0.2, -32),
        BackgroundLayer(assets.backgrounds.bg1, 0.6, 0)
    })
    self.timer = 0
    self.complete = false
end

-- function DebugLevel:onEnter_secret_area(obj)
--     print("Well done, you found the secret area")
-- end

-- function DebugLevel:update(dt)
--     self.timer = self.timer + dt
--     if (self.complete == false and self.timer >= 2.5) then
--         print("Complete!")
--         self.complete = true
--     end
-- end

levels.debug = DebugLevel()
