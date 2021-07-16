
-- CREATE A RECTANGLE WITH BORDERS --


dxDrawCurvedRectangle = function( posX, posY, width, height, border_radius, color)
    if not (posX or posY or width or height or border_radius or color) then
        return outputDebugString("Syntax Error: \n ------> dxDrawCurvedRectangle( posX, posY, width, height, border_radius, color )",4)
    end
    -- center
    dxDrawRectangle(posX - border_radius , posY, width  + border_radius * 2,height, color)
    -- up
    dxDrawRectangle(posX, posY - border_radius, width, border_radius , color)
    -- down
    dxDrawRectangle(posX, posY + height, width, border_radius, color)

 
    -- RIGHT
    dxDrawCircle( posX + width, posY, border_radius, 0 , -90, color, color, 20)
    dxDrawCircle( posX + width, posY + height, border_radius, 0 , 90, color, color, 20)
    -- LEFT
    dxDrawCircle( posX, posY, border_radius, -90 , -180, color, color, 20)
    dxDrawCircle( posX, posY + height, border_radius, -180 , -270, color, color, 20)
end





-- CREATE A CENTER WINDOW --

dxDrawCenterWindow = function(text,width,height,font,titleBar,fondo,fontColor)

    local sx,sy = guiGetScreenSize()
    local relScale, relFontScale = math.min(math.max(sx/1600, 0.5), 1), math.min(math.max(sx/1600, 0.85),1)

    local window = {}
    --window.font = "sans"
    window.fontSize = 1 * relFontScale
    window.fontHeight = dxGetFontHeight(window.fontSize,font)
    window.recWidth, window.recHeight  = math.floor(width * relScale), math.floor(height * relScale)
    window.x, window.y = (sx - window.recWidth)/2,(sy - window.recHeight)/2
    window.titleRec = window.recHeight * 0.035

    dxDrawRectangle(window.x, window.y, window.recWidth, window.recHeight,fondo) -- fondo 
    dxDrawRectangle(window.x, window.y, window.recWidth, window.titleRec,titleBar) -- titulo REC 
    dxDrawText(text, window.x, window.y, window.x + window.recWidth , window.y + window.titleRec, fontColor, window.fontSize,font,"center","center", false, false, false, true)

end


-- CREATE A BUTTOM --

dxDrawbutton = function(text,posx,posy,width,height,font,fontsize,alpha)

    local button = {}
    local relScale, relFontScale = math.min(math.max(posx/1600, 0.5), 1), math.min(math.max(posy/1600, 0.85),1)


    button.text = text or "button"
    button.font = font or "sans"
    button.fontSize = (fontsize or 1) * relFontScale
    button.padding = 10
    button.minWidth = dxGetTextWidth(button.text, button.fontSize, button.font) +  button.padding * 3
    
    button.width, button.height = math.floor(width * relScale), math.floor(height * relScale)

    button.width = button.width < button.minWidth and button.minWidth or button.width

    
    button.x, button.y = (posx - button.width),(posy - button.height)

    dxDrawRectangle(button.x, button.y, button.width, button.height, tocolor(255,255,255,alpha))
    dxDrawText(string.upper(button.text), button.x, button.y, button.x + button.width, button.y + button.height, tocolor(0,0,0,alpha), button.fontSize, button.font,"center","center", false, false, false, true)


    local isCursorInside =  function()
        if isCursorHover(button.x, button.y, button.width, button.height) then
            return true
        end
        return false
    end
    local isClicked =   function ()
        if isCursorHover(button.x, button.y, button.width, button.height) and temp then
            temp = false
            return true
        end
        return false									
    end


    return {
        isCursorInside = isCursorInside,
        isClicked = isClicked
    }

end



function isCursorHover(pX,pY,sX,sY)
	if isCursorShowing() then
		local cX,cY,_,_,_ = getCursorPosition()
		if cX and cY then
			if cX >= pX/sx and cX <= (pX+sX)/sx and cY >= pY/sy and cY <= (pY+sY)/sy then
		        return true
		    end
		end
	end
    return false
end


addEventHandler("onClientClick", getRootElement(),
function(button, state)
	if (button == "left" and state == "down") then
		temp = true
		setTimer(function() temp = false end,50,1);
	end
end)
