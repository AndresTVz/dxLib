--- EDITBOX CREATED BY ANDRESTVZ -- 
      --- do not delete  ---

function createEditbox(text,posx,posy,width,height,color,fontsize,font,fontcolor,textalignHor,textalignVer,ismasked)
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
