Config { 

   -- appearance
--     font = "xft:Noto Sans:size=12:antialias:=true"
     font = "xft:FontAwesome Regular:size=12:antialias:=true"
   , additionalFonts = [ 
            "xft:FontAwesome Regular:size=12:antialias:=true"
        ,   "xft:Noto Sans:size=12:bold:antialias:=true"
        ,   "xft:Monospace:size=14:bold:antialias=true"
        ,   "xft:Source Code Pro:size=10:regular:antialias=true"
        ,   "xft:Bitstream Vera Sans Mono:size=15:bold:antialias=true"
        ]

   , bgColor =      "black"
   , alpha = 100
--   , fgColor =      "#646464"
--   , fgColor =      "#ABABAB"
   , fgColor =      "#DEDEDE"
   , position =     Top
--   , border =       BottomB
--   , borderColor =  "#333333"
   -- , borderColor =  "#646464"
--   , borderWidth =  2  

   -- layout
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment
--   , template = "%battery% | %multicpu% | %coretemp% | %memory% | %dynnetwork% }{ %RJTT% | %date% || %kbd% "

   , template = "%UnsafeStdinReader% }{\
                \RdSh: <fc=lightblue><fn=1>%redshiftparams%</fn></fc> | \
                \Upd: <fc=lightblue><fn=1>%archupdates%</fn></fc> | \
                \<action=`xterm -e htop`>\
                    \%cpu% \
                    \<fc=lightblue><fn=1>%cputemp%</fn></fc>°C | \
                    \%memory%\
                \</action> | \
                \%CYUL% | \
                \<action=`pavucontrol`>\
                    \%pulsevol%\
                \</action> | \
                \%date% | \
                \<fc=lightblue><fn=1>%currim%</fn></fc> "

  -- general behavior
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       False   -- *enable/disable hiding (True = disabled)

   -- plugins
   --   Numbers can be automatically colored according to their value. xmobar
   --   decides color based on a three-tier/two-cutoff system, controlled by
   --   command options:
   --     --Low sets the low cutoff
   --     --High sets the high cutoff
   --
   --     --low sets the color below --Low cutoffunicode
   --     --normal sets the color between --Low and --High cutoffs
   --     --High sets the color above --High cutoff
   --
   --   The --template option controls how the plugin is displayed. Text
   --   color can be set by enclosing in <fc></fc> tags. For more details
   --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
   , commands = 

        -- weather monitor
        [ Run Weather "CYUL" [ "--template"
                    ,   "<action=`firefox https://montréal.weatherstats.ca/`>\
                            \<skyCondition> \
                            \<fc=lightblue><fn=1><tempC></fn></fc>°C \
                            \<fc=lightblue><fn=1><rh></fn></fc>%\
                        \</action>"
                             ] 36000

        -- Workspaces
        , Run UnsafeStdinReader
 
        -- volume
        , Run Com "/home/papa/bin/getpulseaudiovol" [] "pulsevol" 10
 
        -- input method
        , Run Com "/home/papa/bin/getCurrentIM" [] "currim" 10

        -- CPU temp 
        , Run Com "/home/papa/bin/getCPUTemp" [] "cputemp" 10
 
        --Redshift Period 
        , Run Com "/home/papa/bin/getRedshiftParams" [] "redshiftparams" 600
 
        -- CPU temp 
        , Run Com "/home/papa/bin/getNumberOfArchUpdates" [] "archupdates" 36000

-- network activity monitor (dynamic interface resolution)
        -- , Run DynNetwork     [ "--template" , "<dev>: D <tx>kB/s|U <rx>kB/s"
        --                      , "--Low"      , "1000"       -- units: B/s
        --                      , "--High"     , "5000"       -- units: B/s
        --                      , "--low"      , "darkgreen"
        --                      , "--normal"   , "darkorange"
        --                      , "--high"     , "darkred"
        --                      ] 10

        -- cpu activity monitor
        , Run Cpu            [ "--template" , "Cpu: <fn=1><total></fn>%"
                             , "--Low"      , "70"
                             , "--High"     , "90"
                             , "--low"      , "lightblue"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10

        -- cpu core temperature monitor
        -- , Run CoreTemp       [ "--template" , "Temp: <core0>°C|<core1>°C"
        --                      , "--Low"      , "70"        -- units: °C
        --                      , "--High"     , "80"        -- units: °C
        --                      , "--low"      , "green"
        --                      , "--normal"   , "darkorange"
        --                      , "--high"     , "darkred"
        --                      ] 50
                          
        -- memory usage monitor
        , Run Memory         [ "--template" ,"Mem: <fn=1><usedratio></fn>%"
                             , "--Low"      , "50"        -- units: %
                             , "--High"     , "90"        -- units: %
                             , "--low"      , "lightblue"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10

        -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "<action=`firefox https://calendar.google.com/`>\
                                \<fc=#DEDEDE>%a %b %d</fc> <fc=lightblue><fn=1>%R</fn></fc> \
                             \</action>" "date" 600

--        , Run MultiCpu       [ "--template" , "Cpu: <total0>%|<total1>%"
--                             , "--Low"      , "70"         -- units: %
--                             , "--High"     , "90"         -- units: %
--                             , "--low"      , "green"
--                             , "--normal"   , "darkorange"
--                             , "--high"     , "darkred"
--                             ] 10

        -- battery monitor
--        , Run Battery        [ "--template" , "Batt: <acstatus>"
--                             , "--Low"      , "10"        -- units: %
--                             , "--High"     , "80"        -- units: %
--                             , "--low"      , "darkred"
--                             , "--normal"   , "darkorange"
--                             , "--high"     , "green"
-- 
--                             , "--" -- battery specific options
--                                       -- discharging status
--                                      , "-o" , "<left>% (<timeleft>)"
--                                       -- AC "on" status
--                                       , "-O" , "<fc=#dAA520>Charging</fc>"
--                                       -- charged status
--                                       , "-i" , "<fc=#006000>Charged</fc>"
--                             ] 50

        -- keyboard layout indicator
--        , Run Kbd            [ ("us(dvorak)" , "<fc=#00008B>DV</fc>")
--                             , ("us"         , "<fc=#8B0000>US</fc>")
--                             ]
        ]
   }
