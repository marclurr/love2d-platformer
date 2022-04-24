local Object = require("lib.classic")
local Level = Object:extend()

function Level:new(path, tileset, backgrounds)
    self.path = path
    self.tileset = tileset
    self.backgrounds = backgrounds
end

return Level

