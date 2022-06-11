local Object = require("lib.classic")
local PhysicsSystem = tiny.processingSystem(Object:extend())

PhysicsSystem.gravity = 660

function PhysicsSystem:new()
    self.filter = tiny.requireAll("physics", "position", "velocity", "hitbox")
end

function PhysicsSystem:process(e, dt)
    local pos = e.position
    local vel = e.velocity
    local hitbox = e.hitbox
    local physics = e.physics
    local physicsFilter = physics.filter

    if (physics.affectedByGravity) then
        vel.y = vel.y + (PhysicsSystem.gravity * dt)
    end
    
    local collisionIterations = 1
    local iter = 0
    local finalX = pos.x
    local finalY = pos.y
    local grounded = false
    local pushableObj = nil
    
    while collisionIterations > 0  and iter < 3 do
        iter = iter + 1
        collisionIterations = collisionIterations - 1

        local goalX = pos.x + (vel.x * dt)
        local goalY = pos.y + (vel.y * dt)
        local actualX, actualY, cols, len = game.world:move(e, goalX, goalY, physicsFilter)
        
        local onOneWay = true
        
        for i=1,len do  
            if (cols[i].type == "slide")  then
                if (cols[i].normal.y ~= 0) then
                    vel.y = 0
                end
                if (cols[i].normal.y == -1) then
                    grounded = true
                end
                if (e.isPlayer) then  print(tostring(cols[i].normal.y)) end
                oneOneWay = onOneWay and (grounded and cols[i].other.tile and game.tilemap:getTileDef(cols[i].other.id).properties.one_way) 
            end  
        end
        
        physics.onWall = false
        for i=1,len do  
            if (cols[i].type == "slide")  then
                
                if (grounded and cols[i].normal.x ~= 0) then
                    local o = cols[i].other
                    
                    local yoff =(pos.y + hitbox.h) - o.position.y
                    print("here " .. tostring(yoff))
                    if (yoff  <= 3 and yoff > 0) then     
                        
                        -- handle stepping up onto low offset objects
                        pos.y = pos.y - yoff
                        game.world:move(e, pos.x, pos.y, physicsFilter)
                    
                        collisionIterations = collisionIterations + 1
                        
                    else
                        physics.onWall = true
                        if (o.physics and o.physics.isPushable and o.physics.onGround)  then
                            pushableObj = o
                        end
                    end
                end
            end
        end
        finalX = actualX
        finalY = actualY
        physics.onOneWay = onOneWay
    end

    -- if was grounded but now we're not see if we're close enough to the ground to pull back down
    if (physics.onGround and not grounded and vel.y >= 0) then    
        local cols, len = game.world:project(e, finalX, finalY, hitbox.w, hitbox.h, finalX, finalY + 3, physicsFilter)
        
        if (len > 0) then
            local col = cols[1]
            if (col.type=="slide" and col.normal.y == -1) then
                finalY = col.touch.y
                vel.y = 0
                grounded = true
            end
        end      
    end

  
    game.world:move(e, finalX, finalY, physicsFilter)
    pos.x = finalX
    pos.y = finalY
    physics.onGround = grounded
    physics.pushableObj = pushableObj
    
    
    if (physics.isPushable) then
        vel.x = 0
    end
end

return PhysicsSystem