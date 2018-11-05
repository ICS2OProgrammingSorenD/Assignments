---------------------------------------------------------------------------------------
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
local incorrectSound = audio.loadSound( "Sounds/buzzer.mp3" )
local incorrectSoundChannel

local gameOverSound = audio.loadSound( "Sounds/crowdBoo.mp3" )
local gameOverSoundChannel
-----------------------------------------------------------------------------------------
--LOCAL VARIABLES
-----------------------------------------------------------------------------------------

--CREATE LOCAL VARIABLES
local questionObject

local correctObject
local incorrectObject
local showCorrectObject

local numericField

local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local randomOperator
local temp

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
    randomOperator = math.random(1, 5)

    if (randomOperator == 1) then

        --generate 2 random numbers between 1 and 10 
        randomNumber1Ad = math.random(0, 20)
        randomNumber2Ad = math.random(0, 20)

        correctAnswer = randomNumber1Ad  +  randomNumber2Ad 

        -- create question in text object
        questionObject.text = randomNumber1Ad .. " + " .. randomNumber2Ad .. " = "

    elseif (randomOperator == 2) then
         --generate 2 random numbers between 1 and 10 
            randomNumber1Sub = math.random(0, 20)
            randomNumber2Sub = math.random(0, 20)
         --create the problem
        if ( randomNumber1Sub  <  randomNumber2Sub ) then

            --change the numbers so there is no negatives
            randomNumber1 = temp
            randomNumber2 = randomNumber1
            temp = randomNumber2

            --create the equation
            correctAnswer = randomNumber1Sub - randomNumber2Sub

            --create the question in text object
            questionObject.text = randomNumber1Sub .. " - " .. randomNumber2Sub .. " = "
    

      elseif ( randomNumber1 > randomNumber2 ) then
    
        --create the equation
        correctAnswer = randomNumber1Sub - randomNumber2Sub
        --create question in text object
        questionObject.text = randomNumber1Sub .. " - " .. randomNumber2Sub .. " = "
        end
        
    
    elseif (randomOperator == 3) then

        --generate 2 random numbers between 1 and 10 
        randomNumber1Mul = math.random(0, 10)
        randomNumber2Mul = math.random(0, 10)

        --create the equation
        correctAnswer = randomNumber1Mul  *  randomNumber2Mul  

        --create question in text object
        questionObject.text = randomNumber1Mul .. " * " .. randomNumber2Mul .. " = "

    elseif (randomOperator == 4 ) then 

        --generate 2 random numbers between 1 and 10 
        randomNumber1Div = math.random(0, 100)
        randomNumber2Div = math.random(0, 100)

        --create the equation
        correctAnswer = randomNumber1Div / randomNumber2Div

        --round the number
        math.round( correctAnswer )

        --create question in text object
        questionObject.text = randomNumber1Div ..  " ÷ " .. randomNumber2Div .. " = "
    end
end


local function GameOver()

    if (lives == 0) then
        heart3.isVisible = false
        heart2.isVisible = false
        heart1.isVisible = false
        --display the image
        gameOver = display.newImageRect("Images/gameOver2.png", 1028, 756)
        --display the image over the entire screen
        gameOver.x = display.contentWidth/2
        gameOver.y = display.contentHeight/2
        --play the gameover sound
        gameOverSoundChannel = audio.play(gameOverSound)

    end
end

local function UpdateHearts()

    if (lives == 3) then
        heart4.isVisible = false
    elseif (lives == 2 ) then 
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
            --play correct sound
            correctSoundChannel = audio.play(correctSound)
            -- add a point
            numberPoints = numberPoints + 1
            --display the points
            pointsObject.text = "Points:" .. numberPoints
            timer.performWithDelay(1000, HideCorrect)
        else 
            correctObject.isVisible = false 
            incorrectObject.isVisible = true
            --play incorrect sound
            incorrectSoundChannel = audio.play(incorrectSound)
            timer.performWithDelay(1000, HideIncorrect) 
            --decrease a life
            lives = lives - 1 
            --show correct answer
            --showCorrectObject.text = "Correct Answer: " .. correctAnswer
            UpdateHearts()
        end

        event.target.text = ""
    end 
end

local function YouWin()
    
    if (numberPoints == 5) then
        --show image of trophy
        display.newImage("Images/trophy.png", 1024, 756)
        --display a text saying you win
        display.newText("You Win", 400, 600, nil, 150)
        --create the applause sound
        local applauseSound = audio.loadSound( "Sounds/applause.mp3" )
        local applauseSoundChannel
        --call the applause sound
        applauseSoundChannel = audio.play(applauseSound)
    end
end


-----------------------------------------------------------------------------------------
--OBJECT CREATION 
-----------------------------------------------------------------------------------------

--create the lives to display on the creen 
heart1 = display.newImageRect("Images/Heart.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/Heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/Heart.png", 100, 100)
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

--display the points 
pointsObject = display.newText ("Points:" .. numberPoints, 100, 100, nil, 50)
pointsObject:setTextColor(1, 1, 1)

--display the timer
clockText = display.newText ("Time: \n"  ..  secondsLeft, 100, 500, nil, 50)
clockText:setTextColor(1, 1, 1)

--display the correct answer if incorrect
--showCorrectObject = display.newText ("Correct: \n" .. correctAnswer, 300, 100, nil, 50)
--showCorrectObject:setTextColor(1, 1, 1)
-----------------------------------------------------------------------------------------
--FUNCTION CALLS 
-----------------------------------------------------------------------------------------

-- call the function to ask the question 
AskQuestion()

StartTimer()
