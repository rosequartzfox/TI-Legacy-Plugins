<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE muclient>
<!-- Saved on Wednesday, December 01, 2010, 11:54 AM -->
<!-- MuClient version 4.70 -->

<muclient>
<plugin
   name="Repaint_Buffer"
   author="Fiendish"
   id="e2a1af0b5e462318bb423764"
   language="Lua"
   purpose="Condenses repaint calls from other plugins to reduce display overhead"
   date_written="2010-12-01 11:51:55"
   requires="4.70"
   version="1.0"
>

</plugin>
<!--  Script  -->

<script>
<![CDATA[

local repaint_on_tick = false
local last_repaint_time = utils.timer()
function OnPluginBroadcast (msg, id, name, text)
   if (msg == 999 and text == "repaint") then
      repaint_on_tick = true
      if (utils.timer() - last_repaint_time > .1) then
         repaint_on_tick = false        
         Repaint()
         last_repaint_time = utils.timer()
      end
   end
end

-- if ticks are coming through, then we have enough time to repaint again
function OnPluginTick()
   if repaint_on_tick == true then
      repaint_on_tick = false        
      Repaint()
      last_repaint_time = utils.timer()
   end
end

function OnPluginDisable()
   EnablePlugin(GetPluginID(), true)
   ColourNote("white", "blue", "You are not allowed to disable the "..
   GetPluginInfo(GetPluginID(), 1).." plugin. It is necessary for other plugins.")
end

]]>
</script>
</muclient>