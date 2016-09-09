function love.load()
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
 
  objects = {} -- table to hold all our physical objects
  platform = {}
  player = {}
  --let's create the ground
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  objects.ground.shape = love.physics.newRectangleShape(650, 50) --make a rectangle with a width of 650 and a height of 50
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body
 
  --let's create a ball
  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  objects.ball.shape = love.physics.newCircleShape(25) --the ball's shape has a radius of 20
  objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1.5) -- Attach fixture to body and give it a density of 1.
  objects.ball.fixture:setRestitution(0.9) --let the ball bounce
 
  --let's create a couple blocks to play around with
 objects.block1 = {}
 objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
 objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
 objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.
 
 objects.block2 = {}
 objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
  objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
  objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)
 
  --initial graphics setup
  love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
  love.window.setMode(650, 650) --set the window dimensions to 650 by 650
  
  platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight()
 
	platform.x = 0
	platform.y = platform.height / 2
 
	player.x = love.graphics.getWidth() / 2
	player.y = love.graphics.getHeight() / 2
 
	player.speed = 300
 
	player.img = love.graphics.newImage('purple.png')
 
	player.ground = player.y
 
	player.y_velocity = 0
 
	player.jump_height = -300
	player.gravity = -500
end
 
 
function love.update(dt)
  world:update(dt) --this puts the world into motion
 
  --here we are going to create some keyboard events
  if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
    objects.ball.body:applyForce(400, 0)
  elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
    objects.ball.body:applyForce(-400, 0)
  elseif love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
    objects.ball.body:setPosition(650/2, 650/2)
   -- objects.ball.body:setLinearVelocity(0, 0) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
  end

  if love.keyboard.isDown('d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed * dt)
		end
	elseif love.keyboard.isDown('a') then
		if player.x > 0 then 
			player.x = player.x - (player.speed * dt)
		end
	end
 
	if love.keyboard.isDown('space') then
		if player.y_velocity == 0 then
			player.y_velocity = player.jump_height
		end
	end
 
	if player.y_velocity ~= 0 then
		player.y = player.y + player.y_velocity * dt
		player.y_velocity = player.y_velocity - player.gravity * dt
	end
 
	if player.y > player.ground then
		player.y_velocity = 0
    	player.y = player.ground
  end
end

function love.draw()
  love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
 
  love.graphics.setColor(50, 50, 50) --set the drawing color to red for the ball
  love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
 
  love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
 love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
  love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
 -- love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
	love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
end