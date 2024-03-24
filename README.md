# PUBG-weapon-macro

一个很简单鼠标压枪宏

```lua
local pubg = {}
-------------------------------------------------------------------------------
-- pubg逻辑处理
-------------------------------------------------------------------------------
pubg.onEvent = function (event, arg)
	OutputLogMessage("event = %s, arg = %d\n", event, arg)
	
	-- 前进键盘负责开启和关闭
	if event == "MOUSE_BUTTON_PRESSED" and arg == 2 then
            EnablePrimaryMouseButtonEvents(true)
	elseif event == "MOUSE_BUTTON_RELEASED" and arg == 2 then
	    EnablePrimaryMouseButtonEvents(false)
	end

       -- 鼠标左键被按下
	if event == "MOUSE_BUTTON_PRESSED" and arg == 1 then
  	  repeat
  	    OutputLogMessage("use M416 MoveMouseRelative\n")
  		MoveMouseRelative(0, 5)
  		Sleep(20)
  	  until not IsMouseButtonPressed(1)
	end
end

-------------------------------------------------------------------------------
-- 驱动入口函数
-------------------------------------------------------------------------------

function OnEvent(event, arg)
	pubg.onEvent(event, arg)
end

```


[罗技鼠标宏api文档](https://consolelog.gitee.io/docs-logitech/docs-logitech/v8.45/Reference/OnEvent.html)


版本2：


```lua
-- v2 增加 下拉加速度 处理
local pubg = {}
-------------------------------------------------------------------------------
-- pubg逻辑处理
-------------------------------------------------------------------------------
local flag = 0 -- 开启开关
local SLEEP_TIME = 20 -- 间隔时间 毫秒
local MOVE_SENSITIVE = 5 -- 下拖灵敏度 像素
local move = MOVE_SENSITIVE

pubg.onEvent = function (event, arg)
	OutputLogMessage("event = %s, arg = %d flag = %s \n", event, arg, flag )

	-- 前进键盘负责开启和关闭
	if event == "MOUSE_BUTTON_PRESSED" and arg == 5 then
	    if flag == 0  then
	      EnablePrimaryMouseButtonEvents(true)
	      flag = 1
	    else
	      EnablePrimaryMouseButtonEvents(false)
	      flag = 0
	    end
	end

       -- 鼠标左键被按下
	if event == "MOUSE_BUTTON_PRESSED" and arg == 1 and IsMouseButtonPressed(3)  then
        for i = 0, 2000, 1 do --- 支持连续开火最长时间
            if not IsMouseButtonPressed(1) then
                move = MOVE_SENSITIVE
                break
            end
            if i % 40 == 0 and i <= 100 then --- 下拉加速度
                move = move + 1
            end
            MoveMouseRelative(0, move)
            Sleep(SLEEP_TIME)
        end
	end
end

-------------------------------------------------------------------------------
-- 驱动入口函数
-------------------------------------------------------------------------------

function OnEvent(event, arg)
	pubg.onEvent(event, arg)
end
```
