require "creature"
require "fruit"
require "colors"

function love.load()

	img_tileset = love.graphics.newImage("tileset.png")

	tileset = {
		block = love.graphics.newQuad(0, 0, 16, 16, img_tileset:getDimensions()),
		black = love.graphics.newQuad(16, 0, 16, 16, img_tileset:getDimensions()),
		white = love.graphics.newQuad(32, 0,16,16, img_tileset:getDimensions())
	}

	creatures = {
		Creature:new(10,200, colors.YELLOW),
		Creature:new(60,10, colors.RED),
		Creature:new(100,10, colors.BLUE),
		Creature:new(300,10, colors.GREEN)
	}

	fruits = {
		Fruit:new(20,200)
	}
end

function love.update()
	for i,creature in pairs(creatures) do
		creature.update()
	end
end

function love.draw()

	-- Draw tiles
	for i=0, 25 do
		for j=0, 19 do
			love.graphics.draw(img_tileset, tileset.white, 16 * i, 16 * j)
		end
	end

	for i=0, 25 do
		love.graphics.draw(img_tileset, tileset.white, 16 * i, 0)
		love.graphics.draw(img_tileset, tileset.white, 16 * i, 16)
		love.graphics.draw(img_tileset, tileset.white, 16 * i, 32)
		love.graphics.draw(img_tileset, tileset.white, 16 * i, 288)
		love.graphics.draw(img_tileset, tileset.block, 16 * i, 288+16)
	end

	for i,creature in pairs(creatures) do
		creature.draw()
	end

	for i,fruit in pairs(fruits) do
		fruit.draw()
	end

end
