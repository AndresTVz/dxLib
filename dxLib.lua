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
