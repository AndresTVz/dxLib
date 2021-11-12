--- EDITBOX CREATED BY ANDRESTVZ -- 
      --- do not delete  ---

local screenWidth, screenHeight = guiGetScreenSize()


local edit = {}
local id = 0

function createEditbox(text,posx,posy,width,height,color,fontsize,font,fontcolor,textalignHor,textalignVer,ismasked)
    id = id + 1
    local editboxElement = createElement("editbox")

    local object = {
        id = id or 0,
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
        isClicked = false,
        isEnable = false,
    }

    if not edit[editboxElement] then
        edit[editboxElement] = object
    end

    if id <= 1 then
        addEventHandler("onClientCharacter", getRootElement(), character)
        addEventHandler("onClientKey", root, backspace)
	  end

    object.render = function ()
        if isElement(editboxElement) and getElementType(editboxElement) == "editbox" then
            local editbox = edit[editboxElement] -- EDITBOX TEMP
            if getKeyState("mouse1") then -- SI LA PERSONA CLICKEA
                if isCursorHover(editbox.x,editbox.y,editbox.width,editbox.height) then -- SI EL CURSOR ESTA DENTRO DEL RECTANGULO --
                    if not editbox.isClicked then
                        edit[editboxElement].isClicked = true
                        if edit[editboxElement].text == edit[editboxElement].textDefault then -- SI EL TEXTO ES IGUAL AL DEFAULT ESTE LO BORRARA AL DAR CLICK PARA PODER INGRESAR LOS DATOS
                            edit[editboxElement].text = ""
                        end
                    end
                end
                if not isCursorHover(editbox.x,editbox.y,editbox.width,editbox.height) then -- SI LA PERSONA CLICKEA FUERA DEL EDIT
                    if editbox.isClicked then
                        edit[editboxElement].isClicked = false
                    end
                end
            end
            if editbox.isClicked then -- SI ESTA CLICKEADO ESTE ESCRIBIRA LAS LETRAS
                if letra ~= nil then 
                    editbox.text = editbox.text..letra
                    letra = ""
                end
            end
            -- ANCHO DEL RECTANGULO MIN SERA TODO LO QUE OCUPE EL TEXTO
            editbox.width = editbox.width >= dxGetTextWidth((editbox.ismasked and editbox.textMasked or editbox.text), editbox.fontsize,editbox.font) and editbox.width or dxGetTextWidth((editbox.ismasked and editbox.textMasked or editbox.text), editbox.fontsize,editbox.font)
            editbox.height = editbox.height >= dxGetFontHeight(editbox.fontsize,editbox.font) and editbox.height or dxGetFontHeight(editbox.fontsize,editbox.font)
            -- SI EL EDIT ES OCULTO CAMBIARA EL TEXTO POR *** 
            if editbox.ismasked then
                editbox.textMasked = string.rep('*', #editbox.text)
            end
            dxDrawRectangle(editbox.x,editbox.y,editbox.width,editbox.height,editbox.color)
            dxDrawText(editbox.ismasked and editbox.textMasked or editbox.text, editbox.x,editbox.y, editbox.x + editbox.width, editbox.y + editbox.height, editbox.fontcolor, editbox.fontsize, editbox.font, editbox.textalign,editbox.textalignVer, false, false, false, true)
        end
    end

    object.getText = function() return edit[editboxElement].text end
    
    return { -- RETORNA LAS FUNCIONES PARA RENDERIZAR Y OBTENER EL TEXTO DEL EDITBOX
        render = object.render,
        text = object.getText
    }
end




--- FUNCIONES ---

function isCursorHover(pX,pY,sX,sY)
	if isCursorShowing() then
		local cX,cY,_,_,_ = getCursorPosition()
		if cX and cY then
			if cX >= pX/screenWidth and cX <= (pX+sX)/screenWidth and cY >= pY/screenHeight and cY <= (pY+sY)/screenHeight then
		        return true
		    end
		end
	end
    return false
end


function character(letter)
	if letter ~= " " then
		letra = letter
	end
end

function backspace(key,bool)
    local edits = getElementsByType("editbox")
    if bool then
        for i = 0 , #edits do
            editbox = edit[edits[i]]
            if editbox then
                if editbox.isClicked then 
                    if string.len(editbox.text) > 0 and key == "backspace" then
                        editbox.text = string.sub(editbox.text,1,string.len(editbox.text) -1) -- elimina el ultimo valor de la string
                    end
                end
            end
        end
    end
end
