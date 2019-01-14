require "colors"

Fruit = {}

function Fruit:new(x,y)
  local this = {}

  this.x = x
  this.y = y

  this.draw = function()
    -- Draw body
    love.graphics.setColor(colors.RED)
    love.graphics.rectangle("fill", this.x, this.y, 8, 8)

    love.graphics.setColor(colors.WHITE)
  end

  this.update = function()
  end

  return this
end
