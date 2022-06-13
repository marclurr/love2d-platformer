
function registerTileMapCollisions(world)
    return function(tm, layer, tile)        
        local tileDef = tm:getTileDef(tile.id)
        if (tileDef and tileDef.properties.solid == true) then 
            world:add(tile, tile.x, tile.y, tile.w, tile.h)
        end
    end
end

function objectFactory(manager, factories)
    return function(layer, obj)
       
        local fn = factories[obj.type]
        if (fn) then
            local r,l = fn(layer, obj)
            if (l and l > 1) then 
                manager:addAll(r)
            else
                manager:add(r)
            end
        else
            if (programSwitches.debug) then
                print("No factory defined for object of type [" .. obj.type .. "]")
            end
        end
    end
end

function processProgramArguments(args)
    local parserDef = {
        ["-l"] = {"level", true},
        ["--level"] = {"level", true},
        ["-x"] = {"debug"},
        ["--debug"] = {"debug"}
    }
    
    local i = 1
    while i<=#args do
        local def = parserDef[args[i]]
        if (def) then
            if (def[2] == true) then
                programSwitches[def[1]] = args[i+1]
                i = i + 1
            else
                programSwitches[def[1]] = true
            end
        else
            print("unknown command line param [" .. args[i] .. "]")
        end

        i = i + 1
    end
end

hitboxDebug = {    
    drawTile = function(t)
        love.graphics.setColor(1, 1, 1, 1)
        if (t.one_way) then 
            love.graphics.setColor(1, 1, 0, 1)
        end
        love.graphics.rectangle("line", t.x, t.y, t.w, t.h)
    end
}

function centreText(text, offset, top) 
    local left = (DRAW_WIDTH /2) - (fnt:getWidth(text) / 2)

    love.graphics.print(text, fnt, left + offset, top)
    
end

function updateDrawScaling()
    DRAW_SCALE = love.graphics.getWidth() / DRAW_WIDTH
    if (DRAW_SCALE - math.floor(DRAW_SCALE) ~= 0) then
        local height = DRAW_HEIGHT * DRAW_SCALE
        viewportY = (love.graphics.getHeight() - height) / 2
    else
        viewportY = 0
    end
end

function toggleFullscreen()
    love.window.setFullscreen(not love.window.getFullscreen(), "desktop")
    updateDrawScaling()
end

Predicates = {
    any = function(obj)
        return true
    end,

    isPlayer = function(obj)
        return obj.isPlayer
    end,

    isPhysicsObject = function(obj)
        return obj.physics ~= nil
    end
}

Damage = {
    kill = function(obj)
        return obj.health.current
    end,

    constant = function(value)
        return function(obj)
            return value
        end
    end
}

function compose(...)
    local predicates = {...}
    return function(obj)
        local result = true
        for i,p in ipairs(predicates) do
            local p = predicates[i]
            result = result and p(obj)
        end
        return result
    end
end

function destroyEntity(e)
    game.registry:remove(e)
end

function invisibleCollider(x, y, w, h)
    local physicalObject = {}
    physicalObject.name = "InvisibleCollider"
    physicalObject.collisionLayer = COLLISION_SOLID
    Components.hitbox(physicalObject, w, h)
    Components.position(physicalObject, x, y)
    return physicalObject
end

function lerp(a, b, t)
    return (a + ((b - a) * t))
end