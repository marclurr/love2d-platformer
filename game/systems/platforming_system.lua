local Object = require("lib.classic")
local PlatformingSystem = tiny.processingSystem(Object:extend())

local Latch = Object:extend()

function Latch:new(t)
    self.latchTime = t
    self.t = 0
    self.value = false
end

function Latch:reset()
    self.value = false
    self.t = 0
end

function Latch:update(value, dt)
    if (value) then
        self.value = true
        self.t = self.latchTime
    else
        self.t = math.max(0, self.t - dt)
        if (self.t == 0) then
            self.value = false
        end
    end
end

local function filter(item, other)
    local tileDef = game.tilemap.tileset.tiles[other.id]
    if (other.tile and tileDef and tileDef.properties.solid) then 
        if (tileDef.properties.one_way) then
            if ((item.platforming and item.platforming.dropDown and item.platforming.dropDown > 0) or item.position.y + item.hitbox.h > other.y) then
                return nil
            end
        end
        return "slide" 
    end
    if (other.collisionLayer and bit.band(other.collisionLayer, COLLISION_SOLID) ~= 0) then
        return "slide"
    end
    return "cross"
end

function PlatformingSystem:new()
    self.filter = tiny.requireAll("platforming", "position", "velocity", "hitbox")
end

function PlatformingSystem:process(e, dt)
    local pos = e.position
    local vel = e.velocity
    local hitbox = e.hitbox
    local platforming = e.platforming
    if (not platforming.jumpButtonLatch) then 
        platforming.jumpButtonLatch = Latch(4 * (1/60))
    end
    if (not platforming.groundedLatch) then 
        platforming.groundedLatch = Latch(6 * (1 / 60))
    end

    vel.y = math.min(vel.y + platforming.gravity * dt, platforming.maxFallSpeed)
    platforming.dropDown = math.max(platforming.dropDown - dt, 0)

    vel.x = 0
    if (input.right.pressed) then 
        -- self.flippedH = false
        vel.x = platforming.runSpeed
        platforming.direction = "r"
    elseif (input.left.pressed) then
        -- self.flippedH = true
        vel.x = -platforming.runSpeed 
        platforming.direction = "l"
    end

    platforming.jumpButtonLatch:update(input.jump:justPressed(), dt)
    if (platforming.jumpButtonLatch.value) then
        if (vel.y >= 0 and platforming.groundedLatch.value) then
            if (input.down.pressed and platforming.onOneWay) then 
                platforming.dropDown = 0.05
            else
                vel.y = platforming.maxJumpVelocity
            end
            platforming.jumpPressTime = 0.7 * platforming.jumpDuration
        end
    end

    if (input.jump:justReleased()) then
        if (platforming.grounded == false and vel.y < platforming.minJumpVelocity and platforming.jumpPressTime > 0) then
            vel.y = platforming.minJumpVelocity
        end
    end

    local collisionIterations = 1
    local iter = 0
    local finalX = pos.x
    local finalY = pos.y
    local grounded = false

    
    while collisionIterations > 0  and iter < 3 do
        iter = iter + 1
        collisionIterations = collisionIterations - 1

        local goalX = pos.x + (vel.x * dt)
        local goalY = pos.y + (vel.y * dt)
        local actualX, actualY, cols, len = game.world:move(e, goalX, goalY, filter)
        
        local onOneWay = true
        
        for i=1,len do  
            if (cols[i].type == "slide")  then
                if (cols[i].normal.y ~= 0) then
                    vel.y = 0
                end
                grounded = cols[i].normal.y == -1
                oneOneWay = onOneWay and (grounded and cols[i].other.tile and game.tilemap:getTileDef(cols[i].other.id).properties.one_way) 
            end  
        end
        
        platforming.pushing = false
        for i=1,len do  
            if (cols[i].type == "slide")  then
                if (grounded and cols[i].normal.x ~= 0) then
                    local o = cols[i].other
                    
                    local yoff =(pos.y + hitbox.h) - o.position.y
                    if (yoff  <= 3 and yoff > 0) then     
                        -- handle stepping up onto low offset objects
                        pos.y = pos.y - yoff
                        game.world:move(e, pos.x, pos.y, filter)
                    
                        collisionIterations = collisionIterations + 1
                        
                    else
                        platforming.pushing = true
                    
                    --     if (o.pushable and o.grounded) then
                    --         potentialPush = o
                    --     end
                    end
                end
            end
        end
        finalX = actualX
        finalY = actualY
        platforming.onOneWay = onOneWay
    end

    -- if was grounded but now we're not see if we're close enough to the ground to pull back down
    if (platforming.grounded and not grounded and vel.y >= 0) then
    
        local cols, len = game.world:project(e, finalX, finalY, hitbox.w, hitbox.h, finalX, finalY + 3, filter)
        
        if (len > 0) then
            local col = cols[1]
            if (col.type=="slide" and col.normal.y == -1) then
                finalY = col.touch.y
                vel.y = 0
                grounded = true
            end
        end
        
    end
    
    pos.x = finalX
    pos.y = finalY
    platforming.grounded = grounded
    platforming.groundedLatch:update(grounded, dt)    
end
    
return PlatformingSystem