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
    self.filter = tiny.requireAll("physics", "platforming", "position", "velocity", "hitbox")
end

function PlatformingSystem:process(e, dt)
    local pos = e.position
    local vel = e.velocity
    local hitbox = e.hitbox
    local physics = e.physics
    local platforming = e.platforming

    platforming.disabled = math.max(0, platforming.disabled - dt)

   
    if (not platforming.jumpButtonLatch) then 
        platforming.jumpButtonLatch = Latch(4 * (1/60))
    end
    if (not platforming.groundedLatch) then 
        platforming.groundedLatch = Latch(6 * (1 / 60))
    end

    platforming.grounded = physics.onGround
    platforming.groundedLatch:update(platforming.grounded, dt)
    platforming.onOneWay = physics.onOneWay
    platforming.pushing = physics.onWall



    vel.y = math.min(vel.y + platforming.gravity * dt, platforming.maxFallSpeed)
    platforming.dropDown = math.max(platforming.dropDown - dt, 0)

    local speed = platforming.runSpeed
    if (platforming.disabled == 0 and physics.pushableObj) then
        speed = platforming.pushSpeed
    end


    
    local hInput = 0
    if (platforming.disabled == 0 ) then
        if (input.right.pressed) then 
            hInput = 1
            platforming.direction = "r"
        elseif (input.left.pressed) then
            hInput = -1
            platforming.direction = "l"
        end
    end

    if (hInput ~= 0) then 
        local accel = 14
        if (not physics.onGround) then 
            accel = 5
        end
        vel.x = lerp(vel.x, speed * hInput, accel * dt)
    else
        local friction = 10
        if (not physics.onGround) then 
            friction = 4
        end
        vel.x = lerp(vel.x, 0, friction * dt)
        if (math.abs(vel.x) < 8 ) then
            vel.x = 0
        end 

        
        
    end

    -- if (physics.onWall) then
    --     print("here")
    --     vel.x = 0
    -- end

    if (platforming.disabled == 0 and physics.pushableObj) then
        local obj = physics.pushableObj
        if (obj.velocity) then
            obj.velocity.x = vel.x * 0.8
        end
    end

    if (platforming.jumping and platforming.grounded) then
        platforming.jumping = false
    end

    platforming.jumpButtonLatch:update(input.jump:justPressed(), dt)
    if (platforming.disabled == 0 and platforming.jumpButtonLatch.value) then
        if (vel.y >= 0 and platforming.groundedLatch.value and not physics.onCeilling) then
            if (input.down.pressed and platforming.onOneWay) then 
                platforming.dropDown = 0.05
            else
                vel.y = platforming.maxJumpVelocity
                platforming.jumping = true
            end
            platforming.jumpPressTime = 0.7 * platforming.jumpDuration
        end
    end

    if (platforming.disabled == 0 and input.jump:justReleased() and platforming.jumping == true) then
        if (platforming.grounded == false and vel.y < platforming.minJumpVelocity and platforming.jumpPressTime > 0 and not physics.onCeilling) then
            vel.y = platforming.minJumpVelocity
        end
    end

end
    
return PlatformingSystem