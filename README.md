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
