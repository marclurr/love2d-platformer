local Level = require("framework.level")
local BackgroundLayer = require("framework.background")

local Level1 = Level:extend()

function Level1:new()
    self.super.new(self, "tilemaps/level1.lua", assets.tilesets.mainTileset, {
        BackgroundLayer(assets.backgrounds.bg0, 0.2, -32),
        BackgroundLayer(assets.backgrounds.bg1, 0.6, 0)
    })
    self.timer = 0
    self.complete = false
end


levels.level1 = Level1()
