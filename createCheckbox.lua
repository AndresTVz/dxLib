--- EDITBOX CREATED BY ANDRESTVZ -- 
      --- do not delete  ---

function createCheckbox(x,y,w,h,color,postGUI)
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
        local circle = object.h * 1.25
        local currentTick = getTickCount()
        object.progress = object.x
        object.progress = interpolateBetween( object.isActived and (object.progress - (circle - object.h)) or (object.progress + object.h), 0, 0, object.isActived and (object.progress + object.h) or (object.progress - (circle - object.h)) , 0, 0, math.min(1000, currentTick - object.tick)/1000, "Linear") 
        dxDrawImageSection(object.x, object.y, object.w, object.h, 51, 0, 105, 50, object.image, 0,0,0, object.rectangleColor, object.postGUI)

        dxDrawImageSection(object.progress, object.y - (circle - object.h)/2, circle, circle, 0, 0, 50, 51, object.image, 0,0,0, object.isActived and object.checkColor or object.circleColor, object.postGUI)
    end

    object.isClicked = function()
        if getKeyState("mouse1") and object.temp and isCursorHover(object.x,object.y,object.w,object.h) then
            object.temp = false
            if not object.isActived then
                object.tick = getTickCount()
                object.isActived = true
            else
                object.tick = getTickCount()
                object.isActived = false
            end
            return object.id
        end
        return false
    end

    object.getStatus = function()
        return object.isActived
    end

    return object
end
