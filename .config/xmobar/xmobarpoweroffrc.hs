Config {
	font = "xft:Droid Sans Mono-10"
	, additionalFonts = ["xft:FontAwesome-10"]
	, border = FullB
	, borderColor = "#8a8a8a"
	, borderWidth = 2
--	, bgColor = "#3c3b37"
	, bgColor = "#131426"
	, fgColor = "#ffffff"
	, lowerOnStart = False
	-- , position = Static { xpos = 660 , ypos = 0, width = 300, height = 25 }
	, position =  Top
	, template = "}<action=`systemctl poweroff`><fn=1>\xf011</fn><fc=darkorange>Shutdown</fc></action>    \
	        \<action=`systemctl reboot`><fc=lightblue>Reboot</fc></action>    \
		\<action=`ps -o pid | sed '3q;d' |xargs kill && systemctl suspend`>Suspend</action>    \
		\<action=`ps -o pid | sed '3q;d' |xargs kill`><fc=darkgreen>Exit</fc></action>{"
}                                  
