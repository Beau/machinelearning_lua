require "colors"
require("brain")

Creature = {}

Creature.MIN_SIZE = 8
Creature.MAX_SIZE = 64

brain = Brain:new()
brain.initialize()

function Creature:new(x,y,color)
  local this = {}

  this.x = x
  this.y = y
  this.speed = 5
  this.jumpSpeed = 10
  this.fallSpeed = 5
  this.velX = 1
  this.velY = 0
  this.color = color
  this.size = 16
  this.energy = 75 -- ranges from 0 to 100

  this.draw = function()
    -- Draw body
    love.graphics.setColor(this.color)
    love.graphics.rectangle("fill", this.x, this.y, this.size, this.size)

    -- Draw face
    this.drawFace()

    -- Draw energy bar
    this.drawEnergyBar()

    love.graphics.setColor(colors.WHITE)
  end

  this.drawEnergyBar = function()
    local height = this.size/4
    -- Background
    love.graphics.setColor(colors.RED)
    love.graphics.rectangle("fill", this.x, this.y - height*2, this.size, height)
    -- Foreground
    love.graphics.setColor(colors.GREEN)
    love.graphics.rectangle("fill", this.x, this.y - height*2, this.energy * this.size / 100, height)
  end

  this.drawFace = function()
    -- Set color to black if body is bright, otherwise white
    local avgColor = (this.color[1] + this.color[2] + this.color[3]) / 3
    love.graphics.setColor(avgColor > 0.5 and colors.BLACK or colors.WHITE)

    local quarter = this.size / 4;

    local left = this.x + quarter
    local right = this.x + this.size - quarter + 1

    local facePoints = {
      -- Eyes
      { left, this.y + quarter },
      { right, this.y + quarter }
    }
    -- Mouth
    for i=left, right do
      table.insert(facePoints, {i, this.y + this.size - quarter - ((i==left or i==right) and 1 or 0) })
    end
    love.graphics.points(facePoints)
  end

  this.update = function()
    this.x = this.x + this.velX
    this.y = this.y + this.velY
    -- Jumping
    if this.velY < this.fallSpeed then
      this.velY = this.velY + 0.75
    else
      -- Falling
      if (this.y > 320 - this.size * 2) then
        this.y = 320 - this.size * 2
      end
    end

    if love.keyboard.isDown("space") and this.velY > 0 then
      this.jump()
    end
  end

  this.jump = function()
    this.velY = -this.jumpSpeed
  end

  return this
end
