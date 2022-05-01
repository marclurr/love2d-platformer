
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