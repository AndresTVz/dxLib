# ***MTA Library*** <sub>*by AndresTVz*</sub>

#### Here you can find all the mta library that I have been creating during these years.

## Instalacion 

`
Create a dxlib.lua file and copy paste the function dxDrawCheckbox and isHoverCursor function or insert the funtions in your code.
`

## Create a Checkbox

`
bool dxDrawCheckbox ( float x [1], float y [2], float width [3], float height [4], int color [5], bool postGUI = false [6])
`

#### Required Arguments:
1. An float representing the absolute origin X position of the rectangle, represented by pixels on the screen.</sub>
2. An float representing the absolute origin Y position of the rectangle, represented by pixels on the screen.
3. An float representing the width of the rectangle, drawn in a right direction from the origin.
4. An float representing the height of the rectangle, drawn in a downwards direction from the origin.
5. The hex color of the rectangle, produced using tocolor or 0xAARRGGBB (AA = alpha, RR = red, GG = green, BB = blue).
6. A bool representing whether the line should be drawn on top of or behind any ingame GUI.

#### Example:
```Lua
local screen = Vector2(guiGetScreenSize())
addEventHandler("onClientResourceStart", root, 
function()
    showCursor(true)
    checkbox = dxDrawCheckbox(screen.x / 2, screen.y / 2, 40, 20)
    checkbox.saveColor(0,255,0,255)
    addEventHandler("onClientRender",root, function()
        checkbox.render()
    end)
end)
```
  
  

  




