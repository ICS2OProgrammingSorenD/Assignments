-----------------------------------------------------------------------------------------
--Title:Displaying shapes
-- Name: Soren Drew
--Course ICS2O/3C
--This program displays 3 different shapes with a coloured background

local myPolygon
local myTriangle
local myHexagon
local textPolygon
local textTriangle
local textHexagon
local textSize = 50
local vertices =

--set the background colour 
display.setDefault("background", 178/255,102/255,255/255)

----remove the status bar
display.setStatusBar(display.HiddenStatusBar)

--display the first shape (polygon) 
local vertices = {100, 100, 200, 100, 150, 200}
love.graphics.polygon('fill', vertices)
--anchor the polygon and set its x,y position
myPolygon.anchorX = 0
myPolygon.anchorY = 0
myPolygon.x = 20
myPolygon.y = 20


