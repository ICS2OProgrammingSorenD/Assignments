-----------------------------------------------------------------------------------------
--Title: Math quiz
-- Name:Soren Drew 
--Course:ICS2O
---This program displays a math question and ask the use to answer
--before time runs out
-------------------------------------------------------------------

--hide the status bar 
display.setStatusBar(display.HiddenStatusBar)

--set the background colour
display.setDefault("background", 137/255, 199/255, 230/255)

--correct sound
local correctSound = audio.loadSound( "Sounds/correctSound.mp3" )
local correctSoundChannel

--incorrect sound
local incorrectSound = audio.loadSound( "Sounds/wrongSound.mp3" )
local incorrectSoundChannel

local gameOverSound = audio.loadSound( "Sounds/booSound.mp3" )
local gameOverSoundChannel
-----------------------------------------------------------------------------------------
--LOCAL VARIABLES
-----------------------------------------------------------------------------------------

--CREATE LOCAL VARIABLES
local questionObject

local correctObject
local incorrectObject

local numericField

local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local randomOperator

local numberPoints = 0
local pointsObject

--create variables for the timer 
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer

local lives = 3
local heart1
local heart2
local heart3
local gameOver
local youWin

-----------------------------------------------------------------------------------------
--LOCAL FUNCTION
-----------------------------------------------------------------------------------------

local function AskQuestion()
	--generate random operator (number betwen 1 and 3)
	randomOperator = math.random(1, 4)

	--generate 2 random numbers between 1 and 10 
	randomNumber1 = math.random(0, 10)
	randomNumber2 = math.random(0, 10)

	if (randomOperator == 1) then

		correctAnswer = randomNumber1  +  randomNumber2 

		-- create question in text object
	    questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

	elseif (randomOperator == 2) then
		correctAnswer = randomNumber1  -  randomNumber2  

		--create question in text object
		questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
	

	elseif (randomOperator == 3) then

		correctAnswer = randomNumber1  *  randomNumber2  

		--create question in text object
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

	elseif (randomOperator == 4 ) then 

		correctAnswer = randomNumber1 / randomNumber2

		--create question in text object
		questionObject.text = randomNumber1 ..  " / " .. randomNumber2 .. " = "

	end
end

local function GameOver()
	if (lives == 0) then
		heart3.isVisible = false
		heart2.isVisible = false
		heart1.isVisible = false
		gameOver = display.newImageRect("Images/gameOver2.png", 1028, 756)
		gameOver.x = display.contentWidth/2
		gameOver.y = display.contentHeight/2
		gameOverSoundChannel = audio.play(gameOverSound)
	else 
		AskQuestion()
	end
end

local function YouWin()
	if (numberPoints == 5) then
		display.newImage("Images/trophy.png", 1024, 756)
	end
end


local function UpdateHearts()

	if (lives == 2 ) then 
		heart3.isVisible = false
	elseif (lives == 1) then
		heart2.isVisible = false
	elseif (lives == 0) then
	GameOver()
	end
end





local function UpdateTime()

	--decrement the number of seconds
	secondsLeft = secondsLeft - 1

	--display the number of seconds left in the clock object
	clockText.text = "Time: \n"  ..    secondsLeft

	if (secondsLeft == 0 ) then
		--reset the number of seconds left
		secondsLeft = totalSeconds
		-- decrease life
		lives = lives - 1 
		-- update the hearts
		UpdateHearts()
		-- call game over or ask another question
		GameOver()
	
	end
		
end



				
--function that calls the timer
local function StartTimer()
	--create a countdown timer that loops infintely
	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end




local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion() 
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end
 
local function NumericFieldListener( event )	

	--user begins editing "numericfield"
	if (event.phase == "began") then

		--clear text field
		event.target.text = ""

	elseif (event.phase == "submitted") then 
		--when the answer is submitted (enter key is pressed) set user input to user's answer 
		userAnswer = tonumber(event.target.text)
		print(userAnswer)

		--if the users answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then 
			correctObject.isVisible = true 
			correctSoundChannel = audio.play(correctSound)
			numberPoints = numberPoints + 1
			pointsObject.text = "Points:" .. numberPoints
			timer.performWithDelay(1000, HideCorrect)
		
		else 
			correctObject.isVisible = false 
			incorrectObject.isVisible = true
			incorrectSoundChannel = audio.play(incorrectSound)
			timer.performWithDelay(1000, HideIncorrect) 
			lives = lives - 1 
			UpdateHearts()
			
		end

		event.target.text = ""
    end
end
  


-----------------------------------------------------------------------------------------
--OBJECT CREATION 
-----------------------------------------------------------------------------------------

--create the lives to display on the creen 
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7


--displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 50 )
questionObject:setTextColor(1, 1, 1)

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(0, 0, 0)
correctObject.isVisible = false


-- create the incorrect text object
incorrectObject = display.newText( "Incorrect!", 500, 500, nil, 50 )
incorrectObject:setTextColor(238/255, 13/255, 13/255)
incorrectObject.isVisible = false


-- create numeric field
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80 )
numericField.inputType = "number"

-- add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener )

pointsObject = display.newText ("Points:" .. numberPoints, 100, 100, nil, 50)
pointsObject:setTextColor(1, 1, 1)

clockText = display.newText ("Time: \n"  ..  secondsLeft, 100, 500, nil, 50)
clockText:setTextColor(1, 1, 1)



-----------------------------------------------------------------------------------------
--FUNCTION CALLS 
-----------------------------------------------------------------------------------------

-- call the function to ask the question 
AskQuestion()
StartTimer()