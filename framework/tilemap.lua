
function findTileDef(tilesets, id) 
    for ti,ts in ipairs(tilesets) do
        for i,t in ipairs(ts.tiles) do
            if (t.id + 1 == id) then
                return t
            end
        end
    end

    return {properties = {}}
end

local Object = require("lib.classic")
local TileMap = Object:extend()

function TileMap:new()
    self.onTileAdded = function(tm, layer, tile) return end
    self.onObject = function(layer, object) return end
    self.layers = {}
    self.tileset = {  
        tiles = {}
    }
end

function TileMap:clear()
    
    self.layers = nil
    self.tileset = nil
    collectgarbage("collect")
    print(tostring(collectgarbage("count")))
    
    

    self.layers = {}
    self.tileset = {
        tiles = {}
    }
    setmetatable(self.layers, {
        __gc = function()
            print'table garbage collected'
        end
    })
        
    setmetatable(self.tileset, {__gc  = function(o) print("o.f.x") end})
    -- for i, _ in ipairs(self.layers) do
    --     table.remove(self.layers, i)
    -- end
    
    -- for i, _ in ipairs(self.layers) do
    --     table.remove(self.layers, i)
    -- end
end

function TileMap:load(tiledMap, image)
    self.tileset.image = image
    self.spriteBatch = love.graphics.newSpriteBatch(self.tileset.image, 1000, "stream")

    self.width = tiledMap.width
    self.height = tiledMap.height
    self.tilewidth = tiledMap.tilewidth
    self.tileheight = tiledMap.tileheight

    local tilesetCols = image:getWidth()/self.tilewidth
    local totalTiles = (tilesetCols * image:getHeight()/self.tileheight) 
    for i=1,totalTiles do
        local qx = ((i-1) % tilesetCols) * self.tilewidth
        local qy = math.floor((i-1) / tilesetCols) * self.tileheight
        local tile = {}
        tile.quad = love.graphics.newQuad(qx, qy, self.tilewidth, self.tileheight, self.tileset.image)
        tile.properties = findTileDef(tiledMap.tilesets, i).properties
        
        table.insert(self.tileset.tiles, tile)
    end


    for k,v in ipairs(tiledMap.layers)  do
        if (v.type == "objectgroup") then
            for _,obj in ipairs(v.objects) do
                self.onObject(v, obj)
            end
        end

        if (v.type == "tilelayer") then
            local layer = {}
            layer.properties = v.properties
            layer.data = {}
            for i,t in ipairs(v.data) do    
                    local ti = i-1
                    local x = (ti % tiledMap.width) * tiledMap.tilewidth
                    local y = (math.floor(ti / tiledMap.width)) * tiledMap.tileheight
    
                    local tile = {}
                    tile.tile = true
                    tile.id = t
                    tile.x = x
                    tile.y = y
                    tile.w = tiledMap.tilewidth
                    tile.h = tiledMap.tileheight
    
                    table.insert(layer.data,i, tile)
                    self.onTileAdded(self, layer, tile)
            end

            table.insert(self.layers, layer)
        end
    end

end

function TileMap:getTileDef(id)
    return self.tileset.tiles[id]
end

function TileMap:fromWorld(x, y)
    return math.floor(x / self.tilewidth), math.floor(y /self.tileheight)
end

function TileMap:toWorld(x, y)
    return x * self.tilewidth, y * self.tileheight
end

function TileMap:draw(x,y,w,h)
    local startTime = love.timer.getTime()

    if not x then x = 0 end
    if not y then y = 0 end
    if not w then w = self.width * self.tilewidth end
    if not h then h = self.height * self.tileheight end

    local startX, startY = self:fromWorld(x, y)
    local endX, endY = self:fromWorld(x + w, y + h)

    self.spriteBatch:clear()

    
    for k,layer in ipairs(self.layers)  do
        for ty = startY,endY do
            for tx = startX,endX do
                if (tx >= 0 and tx < self.width and ty >= 0 and ty < self.height) then 
                    local index = (ty * self.width) + tx
                   
                    local t = layer.data[index+1]
                    local tileDef = self:getTileDef(t.id)
                    if (tileDef ~= nil) then
                        self.spriteBatch:add(tileDef.quad, t.x, t.y)
                    end
                end
                
            end
        end
    end
    love.graphics.draw(self.spriteBatch)

end


return TileMap