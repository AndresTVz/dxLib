# ***MTA Library*** <sub>*by AndresTVz*</sub>

#### Here you can find all the mta library that I have been creating during these years.

## Instalacion 

`
Download dxlib folder and install in your script.
`

## Create a Checkbox

`
bool dxDrawRectangle ( float x, float y, float width, float height, int color, bool postGUI = false)
`

#### Required Arguments:
- An float representing the absolute origin X position of the rectangle, represented by pixels on the screen.</sub>
- An float representing the absolute origin Y position of the rectangle, represented by pixels on the screen.
- An float representing the width of the rectangle, drawn in a right direction from the origin.
- An float representing the height of the rectangle, drawn in a downwards direction from the origin.
- The hex color of the rectangle, produced using tocolor or 0xAARRGGBB (AA = alpha, RR = red, GG = green, BB = blue).
- A bool representing whether the line should be drawn on top of or behind any ingame GUI.

#### Example:
```Lua
addEventHandler("onClientResourceStart", root, 
function()
    showCursor(true)
    checkbox = exports.dxlib:dxDrawCheckbox(screen.x / 2, screen.y / 2, 40, 20)
    checkbox.saveColor(0,255,0,255)
    addEventHandler("onClientRender",root, function()
        checkbox.render()
    end)
end)
```
  
  

  




