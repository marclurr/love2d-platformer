local Object = require("lib.classic")
local bump =  require("lib.bump")

local EntityManager = Object:extend()

function EntityManager:new() 
    self.entities = {}
    self.world = bump.newWorld()
    self.toRemove = {}
    self.nextId = 1
end

function EntityManager:addAll(entities)
    for _, entity in ipairs(entities) do       
        self:add(entity)
    end
end

function EntityManager:add(entity)
    entity.id = self.nextId
    entity.manager = self
    if (entity.beforeAdd) then
        entity:beforeAdd()
    end

    table.insert(self.entities, #self.entities + 1, entity)
    self.nextId = self.nextId + 1
end

function EntityManager:update(dt)
    local i = 1

    while i <= #self.entities do
        local entity = self.entities[i]
        entity:update(dt)
        if (entity.isDestroyed) then
            if (entity.beforeRemove) then
                entity:beforeRemove()
            end
            self.entities[i] = nil
        else
            i = i + 1
        end
    end
end

function EntityManager:destroy(entity)
    entity.isDestroyed = true
end

function EntityManager:draw()
    for l, entity in ipairs(self.entities) do
        if (entity.draw) then
            entity:draw()
        end
    end
end

function EntityManager:drawDebug()
    for l, entity in ipairs(self.entities) do
        if (entity.drawDebug) then
            entity:drawDebug()
        end
    end
end

return EntityManager