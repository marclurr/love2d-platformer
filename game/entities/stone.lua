local function physicsFilter(l, other)
    local tileDef = game.tilemap.tileset.tiles[other.id]
    if (other.tile and tileDef and tileDef.properties.solid) then 
        if (tileDef.properties.one_way and l.position.y + l.hitbox.h > other.position.y) then
            return nil
        end
        return "slide"
    elseif (other.collisionLayer and bit.band(other.collisionLayer, bit.bor(COLLISION_ACTORS, COLLISION_SOLID)) ~= 0) then
        return "slide"
    end

    return nil
end

return function(layer, obj) 
    local stone = {}
    stone.name = "Stone"
    stone.collisionLayer = COLLISION_SOLID
    Components.position(stone, obj.x, obj.y)
    Components.velocity(stone)
    Components.hitbox(stone, 14, 15)
    Components.physics(stone, physicsFilter, true, true)
    Components.sprite(stone, assets.sprites.stone, 1, 0)
    return stone
end