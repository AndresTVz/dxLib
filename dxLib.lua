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

dxDrawButtom = function(text,posx,posy,width,height,font,fontsize,alpha)

    local buttom = {}
    local relScale, relFontScale = math.min(math.max(posx/1600, 0.5), 1), math.min(math.max(posy/1600, 0.85),1)


    buttom.text = text or "buttom"
    buttom.font = font or "sans"
    buttom.fontSize = (fontsize or 1) * relFontScale
    buttom.padding = 10
    buttom.minWidth = dxGetTextWidth(buttom.text, buttom.fontSize, buttom.font) +  buttom.padding * 3
    
    buttom.width, buttom.height = math.floor(width * relScale), math.floor(height * relScale)

    buttom.width = buttom.width < buttom.minWidth and buttom.minWidth or buttom.width

    
    buttom.x, buttom.y = (posx - buttom.width),(posy - buttom.height)

    dxDrawRectangle(buttom.x, buttom.y, buttom.width, buttom.height, tocolor(255,255,255,alpha))
    dxDrawText(string.upper(buttom.text), buttom.x, buttom.y, buttom.x + buttom.width, buttom.y + buttom.height, tocolor(0,0,0,alpha), buttom.fontSize, buttom.font,"center","center", false, false, false, true)


    local isCursorInside =  function()
        if isCursorHover(buttom.x, buttom.y, buttom.width, buttom.height) then
            return true
        end
        return false
    end
    local isClicked =   function ()
        if isCursorHover(buttom.x, buttom.y, buttom.width, buttom.height) and temp then
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
