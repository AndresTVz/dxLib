--- THIS LIBRARY WAS CREATED BY ANDRESTVZ -- 
      --- PLEASE DO NOT DELETE THIS ---

local screen = Vector2(guiGetScreenSize())

function dxDrawCheckbox(x,y,w,h,color,postGUI)
    local object = {
        id = math.floor(x+y+w+h),
        x = x or 0,
        y = y or 0,
        w = w <= 100 and w or 100,
        h = h <= 50 and h or 50,
        rectangleColor = tocolor(250,250,250,205),
        circleColor = color or tocolor(255,255,255,255),
        checkColor = color or tocolor(0,0,0,255),
        postGUI = postGUI or false,
        isActived = false,
        image = "recir.png",
        temp = false,
        tick = 0
    }

    addEventHandler("onClientClick", getRootElement(),
    function(button, state)
        if (button == "left" and state == "down") then
            object.temp = true
            setTimer(function() object.temp = false end,50,1);
        end
    end)

    object.saveColor = function(r,g,b,a)
        local color = tocolor(r,g,b,a)
        object.checkColor = color
    end

    object.render = function()
        if object.temp and isCursorHover(object.x,object.y,object.w,object.h) then
            object.temp = false
            if not object.isActived then
                object.tick = getTickCount()
                object.isActived = true
            else
                object.tick = getTickCount()
                object.isActived = false
            end
        end

        local circle = object.h * 1.25
        local currentTick = getTickCount()

        object.progress = object.x
        object.progress = interpolateBetween( object.isActived and (object.progress - (circle - object.h)) or (object.progress + object.h), 0, 0, object.isActived and (object.progress + object.h) or (object.progress - (circle - object.h)) , 0, 0, math.min(1000, currentTick - object.tick)/1000, "Linear") 
        dxDrawImageSection(object.x, object.y, object.w, object.h, 51, 0, 105, 50, object.image, 0,0,0, object.rectangleColor, object.postGUI)
        dxDrawImageSection(object.progress, object.y - (circle - object.h)/2, circle, circle, 0, 0, 50, 51, object.image, 0,0,0, object.isActived and object.checkColor or object.circleColor, object.postGUI)
    end

    object.getStatus = function()
        return object.isActived
    end

    return object
end

function dxDrawButton(text,posx,posy,width,height,color,fontsize,font,fontcolor,textalignHor,textalignVer)
    local object = {
        text = text or "",
        x = posx or 0,
        y = posy or 0,
        width = width or 0,
        height = height or 0,
        color = color or tocolor(0,0,0,100),
        fontsize = fontsize or 1,
        font = font or "default",
        fontcolor = fontcolor or tocolor(255,255,255,255),
        textalign = textalign or "center",
        textalignVer = textalignVer or "center",
    }

    object.render = function ()
            -- ANCHO DEL RECTANGULO MIN SERA TODO LO QUE OCUPE EL TEXTO
        object.width = object.width >= dxGetTextWidth(object.text, object.fontsize,object.font) and object.width or dxGetTextWidth(object.text, object.fontsize,object.font)
        object.height = object.height >= dxGetFontHeight(object.fontsize,object.font) and object.height or dxGetFontHeight(object.fontsize,object.font)

        dxDrawRectangle(object.x,object.y,object.width,object.height,object.color)
        dxDrawText(object.text, object.x,object.y, object.x + object.width, object.y + object.height, object.fontcolor, object.fontsize, object.font, object.textalign,object.textalignVer, false, false, false, true)
    end

    object.isClicked = function()
        if getKeyState("mouse1") then -- SI LA PERSONA CLICKEA
            if isCursorHover(object.x,object.y,object.width,object.height) then
                return true
            end
        end
        return false
    end

    object.isHovered = function()
        if isCursorHover(object.x,object.y,object.width,object.height) then
            return true
        end
        return false
    end

    object.setText = function(text)
        object.text = text and text or object.text
    end

    return object
end

function dxDrawEditbox(text,posx,posy,width,height,color,fontsize,font,fontcolor,textalignHor,textalignVer,ismasked)
    local object = {
        id = id,
        textDefault = text or "",
        text = text or "",
        x = posx or 0,
        y = posy or 0,
        width = width or 0,
        height = height or 0,
        color = color or tocolor(0,0,0,100),
        fontsize = fontsize or 1,
        font = font or "default",
        fontcolor = fontcolor or tocolor(255,255,255,255),
        textalign = textalign or "center",
        textalignVer = textalignVer or "center",
        ismasked = ismasked,
        isActive = false,
        isEnable = false,
    }
	addEventHandler("onClientCharacter", getRootElement(),function(letter)
        if letter ~= " " then
            letra = letter
        end
    end)
    
	addEventHandler("onClientKey", root, function(key,status)
        if status then
            if object.isActive then 
                if string.len(object.text) > 0 and key == "backspace" then
                    object.text = string.sub(object.text,1,string.len(object.text) -1) -- elimina el ultimo valor de la string
                end
            end
        end
    end)

    object.render = function ()
        if getKeyState("mouse1") then -- SI LA PERSONA CLICKEA
            if isCursorHover(object.x,object.y,object.width,object.height) then -- SI EL CURSOR ESTA DENTRO DEL RECTANGULO --
                if not object.isActive then
                    object.isActive = true
                    if object.text == object.textDefault then -- SI EL TEXTO ES IGUAL AL DEFAULT ESTE LO BORRARA AL DAR CLICK PARA PODER INGRESAR LOS DATOS
                        object.text = ""
                    end
                end
            end
            if not isCursorHover(object.x,object.y,object.width,object.height) then -- SI LA PERSONA CLICKEA FUERA DEL EDIT
                if object.isActive then
                    object.isActive = false
                end
            end
        end
        if object.isActive then -- SI ESTA CLICKEADO ESTE ESCRIBIRA LAS LETRAS
            if letra ~= nil then 
                object.text = object.text..letra
                letra = ""
            end
        end
        -- ANCHO DEL RECTANGULO MIN SERA TODO LO QUE OCUPE EL TEXTO
        object.width = object.width >= dxGetTextWidth((object.ismasked and object.textMasked or object.text), object.fontsize,object.font) and object.width or dxGetTextWidth((object.ismasked and object.textMasked or object.text), object.fontsize,object.font)
        object.height = object.height >= dxGetFontHeight(object.fontsize,object.font) and object.height or dxGetFontHeight(object.fontsize,object.font)
        -- SI EL EDIT ES OCULTO CAMBIARA EL TEXTO POR *** 
        if object.ismasked then
            object.textMasked = string.rep('*', #object.text)
        end
        dxDrawRectangle(object.x,object.y,object.width,object.height,object.color)
        dxDrawText(object.ismasked and object.textMasked or object.text, object.x,object.y, object.x + object.width, object.y + object.height, object.fontcolor, object.fontsize, object.font, object.textalign,object.textalignVer, false, false, false, true)
    end

    object.getText = function() return object.text end
    
    return {
        render = object.render,
        text = object.getText
   }
end


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


--- THIS LIBRARY WAS CREATED BY ANDRESTVZ -- 
      --- PLEASE DO NOT DELETE THIS ---
