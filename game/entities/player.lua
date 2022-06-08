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
    die = anim8.newAnimation(g("1-9", 1), 0.065, "pauseAtEnd")
}

function Player:new(initialX, initialY)
    self.isPlayer = true
    Components.position(self, initialX, initialY)
    Components.velocity(self)
    Components.hitbox(self, 8, 12)
    Components.animatedSprite(self, assets.sprites.hero, Player.animations.idle, 4, 4)
    Components.health(self, 3)
    
    local minJumpHeight = 0.65 * CELL_SIZE
    local maxJumpHeight = 3.3 * CELL_SIZE
    local jumpDuration = 0.4
    local gravity = (2 * maxJumpHeight) / (jumpDuration * jumpDuration)
    self.platforming = {
        runSpeed = 128,
        pushSpeed = 64,
        maxJumpVelocity = -math.sqrt(2 * gravity * maxJumpHeight),
        minJumpVelocity = -math.sqrt(2 * gravity * minJumpHeight),
        jumpDuration = jumpDuration,
        gravity = gravity,
        maxFallSpeed = 28 * CELL_SIZE, 
        dropDown = 0,
        jumpPressTime = 0
    }

    self.platforming_animation = {
        idle = anim8.newAnimation(g("1-4", 6), 0.2),
        run = anim8.newAnimation(g("1-6", 2), 0.1),
        push = anim8.newAnimation(g("1-6", 3), 0.1),
        jump = anim8.newAnimation(g("1-3", 8), 0.2),
        fall = anim8.newAnimation(g("1-3", 7), 0.2)
    }
end


function Player:onAnimationComplete(animation)
    if (animation == Player.animations.die) then
        game.registry:remove(self)
    end
end

function Player:onHealthDepleted()
    self.sprite.animation = Player.animations.die
    self.sprite.animation:reset()
    self.platforming = nil
    game.registry:add(self)
end

return Player