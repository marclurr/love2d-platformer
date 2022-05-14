local Object = require("lib.classic")
local bump =  require("lib.bump")

local EntityManager = Object:extend()

function EntityManager:new(world) 
    self.entities = {}
    self.world = world
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
    local entitiesToRemove = {}
    local i = 1
    
    for i, entity in ipairs(self.entities) do
        entity:update(dt)
        if (entity.isDestroyed) then
            if (entity.beforeRemove) then
                entity:beforeRemove()
            end
            table.insert(entitiesToRemove, i)
        end
    end
    
    for _, i in ipairs(entitiesToRemove) do
        local e = self.entities[i]
        table.remove(self.entities, i)
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