local loginStatus = false
local animation = {}

animation.start = 0
animation.current = 0
animation.interpolator = "Linear"

animation.alphaIni = 0
animation.alphaFin = 1
animation.widthIni = 100
animation.widthFin = 600



bindKey("F4","down",function()
    if not loginStatus then
        loginStatus = true
        animation.start = getTickCount()
        addEventHandler("onClientRender",root,drawLogin)
    else
        animation.start = getTickCount()
        loginStatus = false
    end

end)

function drawLogin()
  
    animation.current = getTickCount()

    if loginStatus then
        alpha, width = interpolateBetween(
            animation.alphaIni, animation.widthIni, 0, -- value initial
            animation.alphaFin, animation.widthFin, 0, -- value final
            math.min(1000, animation.current - animation.start )/1000, -- progress --
            animation.interpolator  -- interpolato(
        )
    else
        alpha, width = interpolateBetween(
            animation.alphaFin, animation.widthFin, 0, -- value initial
            animation.alphaIni, animation.widthIni, 0, -- value final
            math.min(1000, animation.current - animation.start )/1000, -- progress --
            animation.interpolator  -- interpolato(
        )
        if alpha == 0 then removeEventHandler("onClientRender",root,drawLogin) end
    end
  
    exports.dxLib:dxDrawCenterWindow("MTA Server Latino", width, 700, "sans", 
                        tocolor(100,100,100,255 * alpha),  -- title background
                        tocolor(0,0,0,150 * alpha),        -- background
                        tocolor(255,255,255,255 * alpha)   -- text color 
                    )
end
