local Object = require("lib.classic")
local PlayerDeathSystem = tiny.system(Object:extend())

-- responsible for adding and removing entities with hitboxes into the physics world
function PlayerDeathSystem:new()
    self.filter = tiny.requireAll("isPlayer")
end



function PlayerDeathSystem:onRemove(e)
    Gamestate.switch(gameOver)
end
    
return PlayerDeathSystem