local Object = require("lib.classic")
local anim8 = require("lib.anim8")



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
            if ((item.dropDown and item.dropDown > 0) or item.y + item.h > other.y) then
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

local runSpeed = 128
local pushSpeed = 64
local minJumpHeight = 0.65 * CELL_SIZE
local jumpHeight = 3.3 * CELL_SIZE
local jumpDuration = 0.4
local g = (2 * jumpHeight) / (jumpDuration * jumpDuration) 
local v = -math.sqrt(2 * g * jumpHeight) 
local mv = -math.sqrt(2 * g * minJumpHeight)
local maxFallSpeed = 28 * CELL_SIZE
local Player = Object:extend()

function Player:new()
    self.x = 0
    self.y = 0
    self.w = 8
    self.h = 12
    self.vx = 0
    self.vy = 0

    
    self.spritesheet = assets.sprites.hero

    local g = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())

    self.playerIdle = anim8.newAnimation(g("1-4", 6), 0.2)
    self.playerRun = anim8.newAnimation(g("1-6", 2), 0.1)
    self.playerPush = anim8.newAnimation(g("1-6", 3), 0.1)
    self.playerJump = anim8.newAnimation(g("1-3", 8), 0.2)
    self.playerFall = anim8.newAnimation(g("1-3", 7), 0.2)
    self.playerLand = anim8.newAnimation(g("1-3", 11), 0.2, "pauseAtEnd")
    self.playerDie = anim8.newAnimation(g("1-9", 1), 0.065, "pauseAtEnd")
    self.playerRespawn = anim8.newAnimation(g("9-1", 1), 0.065, "pauseAtEnd")

    self.playerIdle.name = "playerIdle"
    self.playerRun.name = "playerRun"
    self.playerPush.name = "playerPush"
    self.playerJump.name = "playerJump"
    self.playerFall.name = "playerFall"
    self.playerLand.name = "playerLand"
    self.playerDie.name = "playerDie"
    self.playerRespawn.name = "playerRespawn"

    self.anim = self.playerDie
    self.anim:gotoFrame(9)

    self.dropDown = 0
    self.groundedLatch = Latch(6 * (1 / 60))
    self.jumpPressTime = 0
    self.jumpButtonLatch = Latch(4 * (1/60))
    self.onOneWay = false
    self.state = "dead"
end

function Player:resetVars()
    self.vx = 0
    self.vy = 0
    self.jumpPressTime = 0
    self.onOneWay = false
    self.jumpPressTime = 0
    self.dropDown = 0
    self.groundedLatch:reset()
    self.jumpButtonLatch:reset()
end

function Player:beforeAdd()
    self.manager.world:add(self, self.x, self.y, self.w, self.h)
end

function Player:beforeRemove()
     self.manager.world:remove(self)
end

function Player:kill()
    self.state = "dying"
    self:playAnimation(self.playerDie)
    
end

function Player:isDead()
    return self.state == "dead" or self.state == "dying"
end

function Player:move(x, y, filter)
    if (not filter) then
        filter = function(item, other)
            local tileDef = game.tilemap.tileset.tiles[other.id]
            if (other.tile and tileDef and tileDef.properties.solid) then 
                if (tileDef.properties.one_way) then
                    if ((item.dropDown and item.dropDown > 0) or item.y + item.h > other.y) then
                        return nil
                    end
                end
                return "slide" 
            end
            if (other.pushable) then
                return "slide"
            end
            return "cross"
        end
    end

    local ax, ay, cols, len = self.manager.world:move(self, x, y, filter)
    self.x = ax
    self.y = ay

    return ax, ay, cols, len
end

function Player:check(x, y)
    -- if (not filter) then
    --     filter = function(item, other)
    --         local tileDef = game.tilemap.tileset.tiles[other.id]
    --         if (other.tile and tileDef and tileDef.properties.solid) then 
    --             if (tileDef.properties.one_way) then
    --                 if (self.dropDown > 0 or item.y + item.h > other.y) then
    --                     return nil
    --                 end
    --             end
    --             return "slide" 
    --         end
    --         if (other.pushable) then
    --             return "slide"
    --         end
    --         return "cross"
    --     end
    -- end

    local ax, ay, cols, len = self.manager.world:move(self, x, y, filter)
    self.x = ax
    self.y = ay

    return ax, ay, cols, len
end


function Player:spawn(x, y)
    self:resetVars()
    self.x = x
    self.y = y
    self.manager.world:update(self, x + 4, y + 4)
    -- self:move(x + 4, y + 4, function(l,r) return nil end)

    self.state = "spawning"
    self:playAnimation(self.playerRespawn)
end



function Player:playAnimation(newAnim)
    if (newAnim ~= self.anim) then
        self.anim = newAnim
        self.anim:reset()

    end
end

function Player:updateAnimation(dt)
    self.anim.flippedH = self.flippedH
    self.anim:update(dt)
    if (self.anim.status == "paused") then
        self:animationComplete(self.anim)
    end

end

function Player:animationComplete(anim) 
    if (self.state == "dying") then
        self.state = "dead"
        game:onPlayerDied() -- this can cause a loop that breaks the animation!

    elseif (self.state == "spawning") then
        self:playAnimation(self.playerIdle)
        self.state = "alive"
    end
end
frame = 0
function Player:update(dt)
    -- update player movement and collision
    if (self.state == "alive") then
        self.vy = math.min(maxFallSpeed, self.vy + (g * dt))
        self.dropDown = math.max(0, self.dropDown - dt)
        self.jumpPressTime = math.max(0, self.jumpPressTime - dt)

        local mx = 0

        if (input.right.pressed) then 
            self.flippedH = false
            mx = 1
        elseif (input.left.pressed) then
            self.flippedH = true
            mx = -1 
        end

        if (self.pushingObj ~= nil) then
            self.vx = mx * pushSpeed
        else
            self.vx = mx * runSpeed
        end

        self.jumpButtonLatch:update(input.jump:justPressed(), dt)
        if (self.jumpButtonLatch.value) then
            if (self.vy >= 0 and self.groundedLatch.value) then
                if (input.down.pressed and self.onOneWay) then 
                    self.dropDown = 0.05
                else
                    self.vy = v
                end
                self.jumpPressTime = 0.7 * jumpDuration
            end
        end
            
        
        
        if (input.jump:justReleased()) then
            if (self.grounded == false and self.vy < mv and self.jumpPressTime > 0) then
                self.vy = mv
            end
        end

        if (input.attack:justPressed()) then
            self:attack()
        end
            
        if (self.pushingObj) then
            self.pushingObj:push(self.vx * dt *0.8 )
        end

        frame = frame +1
        local collisionIterations = 1
        -- ::checkmovement::
        local iter = 0

        local finalX, finalY = self.x, self.y
        local grounded = false
        local pushing = false
        local nx, ny = 0, 0
        local potentialPush = nil
        while collisionIterations > 0  and iter < 3 do
            iter = iter + 1
            collisionIterations = collisionIterations - 1

            local goalX = self.x + (self.vx * dt)
            local goalY = self.y + (self.vy * dt)

            
            local actualX, actualY, cols, len = self:check(goalX, goalY)



            local onOneWay = true
            self.pushingObj = nil
           
            for i=1,len do  
                if (cols[i].type == "slide")  then
                    if (cols[i].normal.x ~= 0) then
                        local o = cols[i].other
                        
                        local yoff =(self.y + self.h) - o.y
                    
                        if (yoff  <= 3 and yoff > 0) then 
                           
                            self.y = self.y - yoff
                            self.manager.world:update(self, self.x, self.y)
                         
                            collisionIterations = collisionIterations + 1
                            
                        else
                            pushing = true
                           
                            if (o.pushable and o.grounded) then
                                potentialPush = o
                            end
                        end
                    end

                    if (cols[i].normal.y == -1) then
                        self.vy = 0
                        grounded = true
                    elseif (cols[i].normal.y == 1) then
                        self.vy = 0
                    end

                    oneOneWay = onOneWay and (grounded and cols[i].other.tile and game.tilemap:getTileDef(cols[i].other.id).properties.one_way) 

                end  
            end
            finalX = actualX
            finalY = actualY
        end

        -- if was grounded but now we're not see if we're close enough to the ground to pull back down
        if (self.grounded and not grounded and self.vy >= 0) then
           
            local cols, len = self.manager.world:project(self, finalX, finalY, self.w, self.h, finalX, finalY + 3, filter)
           
            if (len > 0) then
                local col = cols[1]
                if (col.type=="slide" and col.normal.y == -1) then
                    finalY = col.touch.y
                    self.vy = 0
                    grounded = true
                end
            end
            
        end

        if (potentialPush and grounded) then
            self.pushingObj = potentialPush
        end
        

        self.manager.world:update(self, finalX, finalY)
        self.x = finalX
        self.y = finalY

        self.onOneWay = oneOneWay
        self.groundedLatch:update(grounded, dt)
        self.grounded = grounded 
        self.pushing = pushing
        
    end

    -- set and update animation 
    if (self.state == "alive") then
        if (self.grounded) then
            if (self.pushing or self.pushingObj) then
                self:playAnimation(self.playerPush)
            else 
                if (self.vx ~= 0) then
                    self:playAnimation(self.playerRun)
                else
                    self:playAnimation(self.playerIdle)
                end
            end
        end

        if (self.vy < 0) then
            self:playAnimation(self.playerJump)
        elseif (self.vy > 0) then
            self:playAnimation(self.playerFall)
        end
    end


    self:updateAnimation(dt)
end

function Player:draw()
    local ox = 4
    self.anim:draw(self.spritesheet, math.floor(self.x), math.floor(self.y), 0, 1, 1, ox, 4)
end

function Player:attack()
    print("thwack!")
end

return Player