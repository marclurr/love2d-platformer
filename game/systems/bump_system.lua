local Object = require("lib.classic")
local BumpSystem = tiny.system(Object:extend())

-- responsible for adding and removing entities with hitboxes into the physics world
function BumpSystem:new()
    self.filter = tiny.requireAll("position", "hitbox")
end

function BumpSystem:onAdd(e)
    local pos = e.position
    local hitbox = e.hitbox
    game.world:add(e, pos.x, pos.y, hitbox.w, hitbox.h)
end

function BumpSystem:onRemove(e)
    game.world:remove(e)
end
    
return BumpSystem