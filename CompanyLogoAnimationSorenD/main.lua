-----------------------------------------------------------------------------------------
-- Title: Company Logo Animation
-- Name: Soren Drew
-- Date: November 8th 2018
-- Course: ICS2O
-- This program displays a company logo and 
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- global variables
scrollSpeedComet1 = 6
scrollSpeedComet2 = 6

--create sound (variables)
local swooshSound1 = audio.loadSound( "Sound/swoosh.mp3")
local swooshSoundChannel1

local swooshSound2 = audio.loadSound( "Sound/swoosh2.mp3")
local swooshSoundChannel2

----create background image with width and height
local background = display.newImageRect("Images/background.jfif", 2048, 1536)

--add comet images with width and height
local comet1 = display.newImageRect("Images/comet.png", 150, 150)
local comet2 = display.newImageRect("Images/comet.png", 150, 150)

--add the company logos
local FlossBoss = display.newImageRect("Images/CompanyLogoSoren.png", 600, 600)
local FlossBoss2 = display.newImageRect("Images/CompanyLogoGlow.png", 600, 600)

--make the second floss boss invisible
FlossBoss2.isVisible = false
FlossBoss.isVisible = true

--set the initial x and y position of the comets
comet1.x = 0
comet1.y = 450

comet2.x = 1024
comet2.y = 150

--set the initial x and y position of the logos
FlossBoss.x = 570
FlossBoss.y = 350

FlossBoss2.x = 570
FlossBoss2.y = 350


--change the direction of the first comet
comet1:scale(-1, 1)

--create the move function for the first comet
local function MoveComet(event)
	--add the scroll speed to the x-value and the y-value of the comet
	comet1.x = comet1.x + scrollSpeedComet1
	comet1.y = comet1.y - scrollSpeedComet2
	--play the sound 
	swooshSoundChannel1 = audio.play(swooshSound1)
	--change the image and stop the sound once the comet is off the screen
	if (comet1.y == 0) then 
		--make the second floss boss invisible
		FlossBoss2.isVisible = true
		FlossBoss.isVisible = false
		swooshSoundChannel1 = audio.pause()
	end
end

--MoveComet will be called over and over agian
Runtime:addEventListener("enterFrame", MoveComet)


--create the move function for the second comet
local function MoveComet2(event)
	--add the scroll speed to the x-value and the y-value of the comet
	comet2.x = comet2.x - scrollSpeedComet2
	comet2.y = comet2.y + scrollSpeedComet2
	--play the sound
	swooshSoundChannel2 = audio.play(swooshSound2)
	--play the sound after a delay
	timer.performWithDelay (500, swooshSoundChannel2)
	--stop the sound once the comet is off the screen
	if (comet2.y == 500) then 
		swooshSoundChannel2 = audio.pause()
	end
end

--MoveComet will be called over and over agian
Runtime:addEventListener("enterFrame", MoveComet2)

