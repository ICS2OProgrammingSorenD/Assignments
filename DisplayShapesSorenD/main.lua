-----------------------------------------------------------------------------------------
--Title:Displaying shapes
-- Name: Soren Drew
--Course ICS2O/3C
--This program displays 3 different shapes with a coloured background
local myQuadrilateral
local myTriangle
local myPentagon
local textQuadrilateral
local textTriangle
local textPentagon
local textSize = 50
local halfW = display.contentWidth * 0.5
local halfH = display.contentHeight * 0.5

--set the background colour 
display.setDefault("background", 178/255, 102/255, 255/255)

----remove the status bar
display.setStatusBar(display.HiddenStatusBar)

--create vertices for triangle
local verticesTri = { 150, 150, 300, 210, 180, 300, }

--create triangle and colour it
local myTriangle = display.newPolygon( halfW, halfH, verticesTri )
myTriangle.fill = { 0/255, 255/255, 0/255 }
myTriangle.strokeWidth = 5
myTriangle:setStrokeColor( 0, 0, 0 )

--anchor the polygon and set its x,y position
myTriangle.anchorX = 0
myTriangle.anchorY = 0
myTriangle.x = 20
myTriangle.y = 20

--write the name of the triangle
textTriangle = display.newText("Triangle" , 0, 0, Arial, textSize)

--anchor and set the x,y position of the triangle text
textTriangle.anchorX = 0
textTriangle.anchorY = 0
textTriangle.x = 50
textTriangle.y = 200

--set the colour of the triangle text
textTriangle:setTextColor(1, 1, 1)

--set the vertices for the quadrilateral
local verticesQuad = { 100, 240, 300, 240, 500, 600, 400, 600 }

--create the quadrilateral
local myQuadrilateral = display.newPolygon( halfW, halfH, verticesQuad )

--colour the inside of the quadrilateral
myQuadrilateral.fill = { 255/255, 128/255, 0/255 }

--set the stroke colour for the quadrilateral
myQuadrilateral.strokeWidth = 5

--set the stroke colour for the quadrilateral
myQuadrilateral:setStrokeColor( 153/255, 204/255, 255/255 )

--write the name of the quadrlateral
textQuadrilateral = display.newText("Quadrilateral" , 600, 600, Arial, textSize)

--colour the quadrilateral text
textQuadrilateral:setTextColor(102/255, 0/255, 0/255)

--set the vetices for the hexagon
local verticesPen = { -1000, 350, -1080, 500, -1050, 700, -900, 700, -880, 500 }

--create the hexagon
local myPentagon = display.newPolygon( halfW, halfH, verticesPen )

--set the pentagon's x,y position
myPentagon.x = 100
myPentagon.y = 500

--write the name of the pentagon
textPentagon = display.newText("Pentagon" , 110, 700, Arial, textSize)

--colour the pentagon
myPentagon.fill= { 0/255, 255/255, 255/255}

--set stroke width
myPentagon.strokeWidth = 5

--set text colour
textPentagon:setTextColor( 204/255, 204/255, 0/255)