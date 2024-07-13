local PUBG = {}

PUBG.SLEEP_TIME = 20    -- 间隔时间 毫秒
PUBG.MOVE_SENSITIVE = 5 -- 下拖灵敏度 像素
PUBG.MAX_TIME = 5 * 1000 --- 开枪最大可持续时间 毫秒

PUBG.dragMouse = function()
    local maxIndex = PUBG.MAX_TIME / PUBG.SLEEP_TIME
    for i = 1, maxIndex, 1 do
        Sleep(PUBG.SLEEP_TIME)
        if not IsMouseButtonPressed(1) then
            break
        end
        if not IsMouseButtonPressed(3) then
            break
        end
        --- OutputLogMessage('dragMouse~ \n')
        MoveMouseRelative(0, PUBG.MOVE_SENSITIVE)
    end
end

PUBG.OnEvent = function(event, arg)
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 1) then
        PUBG.dragMouse()
    end
end

-- 驱动入口函数
function OnEvent(event, arg)
    EnablePrimaryMouseButtonEvents(true)
    PUBG.OnEvent(event, arg)
end
