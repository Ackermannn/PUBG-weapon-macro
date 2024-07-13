local PUBG = {}

PUBG.WEANPON = 'M416'

PUBG.M416 = {
    SLEEP_TIME = 20,
    MOVE_SENSITIVE = 5,
    MAX_MOVE_SENSITIVE = 2,
    MAX_TIME = 5 * 1000,
    TIME_WHEN_SENSITIVE_IS_MAX = 2 * 1000
}
PUBG.ACE32 = {
    SLEEP_TIME = 20,
    MOVE_SENSITIVE = 5,
    MAX_MOVE_SENSITIVE = 2,
    MAX_TIME = 5 * 1000,
    TIME_WHEN_SENSITIVE_IS_MAX = 2 * 1000
}

PUBG.SLEEP_TIME = PUBG[PUBG.WEANPON].SLEEP_TIME   -- 间隔时间 毫秒
PUBG.MOVE_SENSITIVE = PUBG[PUBG.WEANPON].MOVE_SENSITIVE -- 下拖灵敏度 像素
PUBG.MAX_MOVE_SENSITIVE = PUBG[PUBG.WEANPON].MAX_MOVE_SENSITIVE -- 灵敏度最大增量. 若3 为 5 到 5+3
PUBG.MAX_TIME = PUBG[PUBG.WEANPON].MAX_TIME -- 开枪最大可持续时间 毫秒
PUBG.TIME_WHEN_SENSITIVE_IS_MAX = PUBG[PUBG.WEANPON].TIME_WHEN_SENSITIVE_IS_MAX -- 灵敏度达到最大值的时间 毫秒


PUBG.calculateOffset = function(i)
    local t = i * PUBG.SLEEP_TIME
    local a = (PUBG.MAX_MOVE_SENSITIVE) / (PUBG.TIME_WHEN_SENSITIVE_IS_MAX) / (PUBG.TIME_WHEN_SENSITIVE_IS_MAX)
    local b = 2 * (PUBG.MAX_MOVE_SENSITIVE) / PUBG.TIME_WHEN_SENSITIVE_IS_MAX
    local c = PUBG.MOVE_SENSITIVE
    local res = math.floor(-1 * a * t ^ 2 + b * t + c)
    res = math.max(res, PUBG.MOVE_SENSITIVE)
    return res
end

PUBG.dragMouse = function()
    local maxIndex = PUBG.MAX_TIME / PUBG.SLEEP_TIME
    local offset = PUBG.MOVE_SENSITIVE
    for i = 1, maxIndex, 1 do
        Sleep(PUBG.SLEEP_TIME)
        if not IsMouseButtonPressed(1) then
            break
        end
        if not IsMouseButtonPressed(3) then
            break
        end
        --- OutputLogMessage('dragMouse~ \n')
       --- MoveMouseRelative(0, 5)
        MoveMouseRelative(0, PUBG.calculateOffset(i))
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
