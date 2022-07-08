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

levels.debug = DebugLevel()
