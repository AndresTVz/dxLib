function createButton(text,posx,posy,width,height,color,fontsize,font,fontcolor,textalignHor,textalignVer)

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
