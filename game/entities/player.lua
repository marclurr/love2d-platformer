flashShader = love.graphics.newShader([[
    vec4 effect(vec4 colour, Image tex, vec2 uv, vec2 xy) {
        return  Texel(tex, uv).a * colour;
    }
]])



local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local Player = Object:extend()
local g = anim8.newGrid(16, 16, assets.sprites.hero:getWidth(), assets.sprites.hero:getHeight())

Player.animations = {
    idle = anim8.newAnimation(g("1-4", 6), 0.2),
    run = anim8.newAnimation(g("1-6", 2), 0.1),
    push = anim8.newAnimation(g("1-6", 3), 0.1),
    jump = anim8.newAnimation(g("1-3", 8), 0.2),
    fall = anim8.newAnimation(g("1-3", 7), 0.2), 
    hit = anim8.newAnimation(g("1-3", 9), 0.1), 
    attack = anim8.newAnimation(g("1-4", 4), 0.05, "pauseAtEnd"), 
    die = anim8.newAnimation(g("1-9", 1), 0.065, "pauseAtEnd"),

    slash = anim8.newAnimation(g("1-4", 15), 0.05, "pauseAtEnd"),
}



local function physicsFilter(item, other)
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

local function newPlayerAttack(x, y, direction)
    local e = {}
    local width = 16
    
    local xOffset = direction == "l" and -16 or 8
    local sprOffset = direction == "l" and 2 or -2

    Components.position(e, x + xOffset, y)
    Components.hitbox(e, width, 10 )
    Components.animation(e)
    Player.animations.slash:reset()
    Components.animatedSprite(e, assets.sprites.hero, Player.animations.slash, sprOffset, 4)
    Components.lifetime(e, 0.25)
    e.sprite.flippedH = direction == "l"
    Components.causesDamage(e, Damage.constant(1), function(e)
        return not e.isPlayer
    end, function() end, direction == "l" and -1 or 1)
    Components.controller(e, function(e)
        e.position.x = game.player.position.x + xOffset
        e.position.y = game.player.position.y
    end)
    return e
end

local function playerPlatforming(e, x, jumpPressed, jumpReleased, dt)
    local pos = e.position
    local vel = e.velocity
    local hitbox = e.hitbox
    local physics = e.physics
    local platforming = e.platforming

    -- decrement timers
    platforming.dropDown = math.max(platforming.dropDown - dt, 0)
    platforming.jumpPressTime = math.max(0, platforming.jumpPressTime - dt)
    platforming.onGroundTime = math.max(0, platforming.onGroundTime - dt)

    -- reinitialise timers
    platforming.jumpPressTime = jumpPressed and 6 * (1/60) or platforming.jumpPressTime
    platforming.onGroundTime = physics.onGround and 6 * (1/60) or platforming.onGroundTime

    -- apply gravity
    vel.y = math.min(vel.y + platforming.gravity * dt, platforming.maxFallSpeed)
       
    -- handle horizontal input
    local speed = physics.pushableObj and platforming.pushSpeed or platforming.runSpeed


    local hInput = x 
    platforming.direction = hInput == 1 and "r" or hInput == -1 and "l" or platforming.direction

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

    if (physics.pushableObj) then
        local obj = physics.pushableObj
        if (obj.velocity) then
            obj.velocity.x = vel.x * 0.8
        end
    end

    e.sprite.flippedH = e.platforming.direction == "l" or false

    -- handle jumping
    if (platforming.jumpPressTime > 0) then
        if (vel.y >= 0 and platforming.onGroundTime > 0 and not physics.onCeilling) then
            if (input.down.pressed and physics.onOneWay) then 
                platforming.dropDown = 0.05
            else
                vel.y = platforming.maxJumpVelocity
            end
        end
    end

    if (jumpReleased ) then 
        if (physics.onGround == false and vel.y < platforming.minJumpVelocity and not physics.onCeilling) then
            vel.y =  platforming.minJumpVelocity
        end
    end
end

local function playerController(e, dt)
    local x = 0
    local jumpPressed = false
    local jumpReleased = false

    e.attacking = math.max(0, e.attacking - dt)
    e.pauseSimulation = math.max(0, e.pauseSimulation - dt)

    if (e.health.current > 0) then
        x = input.right.pressed and 1 or input.left.pressed and -1 or 0
        jumpPressed = input.jump:justPressed()
        jumpReleased = input.jump:justReleased()
        local attackPressed = input.attack:justPressed()

        e.attackPressTime = attackPressed and 8 * (1/60) or e.attackPressTime


        if ( input.attack:justPressed() and e.attacking == 0) then 
            e.attacking = 0.225
            e.pauseSimulation = 2 * (1/60)
            e.health.invincible = 8 * (1/60)
            local direction = e.platforming.direction 
            game.registry:addEntity(newPlayerAttack(e.position.x ,  e.position.y , direction))
        end
    else
        e.velocity.x = 0
        e.velocity.y = 0
        return
    end

    if (e.pauseSimulation == 0) then 
        e.physics.simulate = true
        playerPlatforming(e, x, jumpPressed, jumpReleased, dt)
    else 
        e.physics.simulate = false
    end

    

end

local function playerAnimation(e, dt)
    local pan = Player.animations
    local platforming = e.platforming
    local vel = e.velocity
    local an = pan.idle
    local physics = e.physics

    if (e.health.current == 0) then 
        return pan.die
    end

    if (e.attacking >= 0.16) then 
        an = pan.attack
    else
        if (physics.onGround) then
            if (physics.onWall) then
                an = pan.push
            else 
                if (vel.x ~= 0) then
                    an = pan.run
                else
                    an = pan.idle
                end
            end
        else

            if (vel.y < 0) then
                an = pan.jump
            elseif (vel.y > 0) then
                an = pan.fall
            end
        end
    end
    
    return an
end

function Player:new(initialX, initialY)
    self.id = 99999
    self.name = "Player"
    self.isPlayer = true
    self.collisionLayer = COLLISION_ACTORS
    self.attacking = 0
    self.pauseSimulation = 0
    self.recover = 0
    Components.position(self, initialX, initialY)
    Components.velocity(self)
    Components.hitbox(self, 8, 12)
    Components.physics(self, physicsFilter)
    Components.animatedSprite(self, assets.sprites.hero, Player.animations.fall, 4, 4)
    Components.animation(self, playerAnimation)
    Components.health(self, 3)
    
    local minJumpHeight = 0.65 * CELL_SIZE
    local maxJumpHeight = 3.3 * CELL_SIZE
    local jumpDuration = 0.4
    local gravity = (2 * maxJumpHeight) / (jumpDuration * jumpDuration)
    self.platforming = {
        runSpeed = 132,
        pushSpeed = 58,
        maxJumpVelocity = -math.sqrt(2 * gravity * maxJumpHeight),
        minJumpVelocity = -math.sqrt(2 * gravity * minJumpHeight),
        jumpDuration = jumpDuration,
        gravity = gravity,
        maxFallSpeed = 28 * CELL_SIZE, 
        dropDown = 0,
        onGroundTime = 0,
        jumpPressTime = 0, 
        jumpHeldTime = 0,
        disabled = 0, 
        jumping = false
    }

    Components.controller(self, playerController)
    self.hit = 0
end

function Player:draw()
    self.hit = math.max(0, self.hit - love.timer.getDelta())
    self.recover = math.max(0, self.recover - game.dt)
    if (self.hit > 0) then
        self.sprite.shader = flashShader
    else
        self.sprite.shader = nil
        if (self.recover > 0) then 
             self.sprite.mod[4] = math.ceil(math.sin(self.recover * 20)) * 1
        else 
            self.sprite.mod[4] = 1
        end
    end   
end

function Player:onAnimationComplete(animation)
    if (animation == Player.animations.die) then
        game.registry:remove(self)
    end
end

function Player:onHealthDepleted()
    self.sprite.animation = Player.animations.die
    self.sprite.animation:reset()
    self.platforming.disabled = 999
    game.registry:add(self)
end

function Player:onDamageTaken(dealer, amount, dir)
    if (self.health.current > 0) then
        self.velocity.x = 80 * dir
        self.velocity.y = -128
        self.platforming.disabled = 0.2
        self.health.invincible = 2
        self.hit = 0.15
        self.recover = 2
    end
    
end

return Player