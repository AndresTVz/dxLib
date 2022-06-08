--- EDITBOX CREATED BY ANDRESTVZ -- 
      --- do not delete  ---
      
local screen = Vector2(guiGetScreenSize())

function isCursorHover(pX,pY,sX,sY)
	if isCursorShowing() then
		local cX,cY,_,_,_ = getCursorPosition()
		if cX and cY then
			if cX >= pX/screen.x and cX <= (pX+sX)/screen.x and cY >= pY/screen.y and cY <= (pY+sY)/screen.y then
		        return true
		    end
		end
	end
    return false
end
