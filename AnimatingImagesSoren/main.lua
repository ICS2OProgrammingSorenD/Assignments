-----------------------------------------------------------------------------------------
--Title:Animating Images
-- Name:soren
--Course ICS20/3C
----This program displays 3 images that move around the screen

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- global variables
scrollSpeedBuisness = 4
scrollSpeedHeart = 3
scrollSpreedCube = 0.01


-- backgroun image with width and height
local backgroundImage = display.newImageRect("Images/diamonds.png", 2048, 1536)

-- add characters image with width and height
local buisness = display.newImageRect("Images/buisness.png", 200, 200)
local heart = display.newImageRect("Images/heart.png", 200, 200)
local cube = display.newImageRect("Images/cube.png", 300, 300)

--set the man to be solid 
buisness.alpha = 1

--set the heart to be transparent
heart.alpha = 0

--set the cube to be solid
cube.alpha = 1

-- set the initial x and y position of the buisnessman 
buisness.x = 15
buisness.y = display.contentHeight/3

--set the initial x and y position of the heart
heart.x = 300
heart.y = 400

--set the initial x and y position of the cube
cube.x = 800
cube.y = 450

--function: MoveMan
--Input: this function accepts an events listener
--Output:none
--Description: this function add the scroll speed to the x value of the man
local function MoveMan(event)
	--add the scrollspeed to the x value of the man
	buisness.x = buisness.x + scrollSpeedBuisness
	--change the tancparency of the man as he moves so it fades out
	buisness.alpha = buisness.alpha - 0.001
end

--MoveMan will be called over and over again
Runtime:addEventListener("enterFrame", MoveMan)

--function: MoveHeart
--Input: this function accepts an events listener
--Output:none
--Description: this function add the scroll speed to the x and y value of the Heart
local function MoveHeart(event)
	--add the scrollspeed to the x value of the heart
	heart.x = heart.x + scrollSpeedHeart
	--add the scroll speed to the y value of the heart
	heart.y = heart.y + scrollSpeedHeart
	--change the tancparency of the man as he moves so it fades out
	heart.alpha = heart.alpha + 0.01
end

--MoveHeart will be called over and over again
Runtime:addEventListener("enterFrame", MoveHeart)

--change the direction of the cube
cube:scale(-1, 1)

--set the x and y scale of the cube
cube.xScale = 1
cube.yScale = 1

--function: MoveCube
--Input: this function accepts an events listener
--Output:none
--Description: this function add the scroll speed to the x value of the cube
local function ShrinkCube(event)
	--add the scrollspeed to the x value of the cube
	cube.xScale = cube.xScale + scrollSpreedCube
	--add the scroll speed to the y value of the cube
	cube.yScale = cube.yScale + scrollSpreedCube
end

--Shrinkcube will be called over and over again
Runtime:addEventListener("enterFrame", ShrinkCube)