Config { 

   -- appearance
--     font = "xft:Noto Sans:size=10:antialias:=true"
     font = "xft:FontAwesome Regular:size=10:antialias:=true"
   , additionalFonts = [ 
            "xft:FontAwesome Regular:size=10:bold:antialias:=true"
        ,   "xft:Noto Sans:size=10:bold:antialias:=true"
        ,   "xft:Monospace:size=14:bold:antialias=true"
        ,   "xft:Symbols Nerd Font:size=13"
        ,   "xft:Ubuntu Mono:size=13"
        ,   "xft:Bitstream Vera Sans Mono:size=15:bold:antialias=true"
        ]

   , iconRoot = "/home/papa/.config/xmobar/icons/"
   , bgColor =      "black"
   , alpha = 200
--   , fgColor =      "#646464"
--   , fgColor =      "#ABABAB"
--   , fgColor =      "#DEDEDE"
   , fgColor =      "#d3d7cf"
   , position =     Top
--   , border =       BottomB
--   , borderColor =  "#333333"
   -- , borderColor =  "#646464"
--   , borderWidth =  2  

   -- layout
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment

   , template = "<fn=4></fn> %UnsafeStdinReader% }{ \
                \<action=`xterm -e wificonnect`>\
                    \%wlan0wi%\
                \</action>   \
                \<fn=4></fn> <fc=lightblue><fn=1>%redshiftparams%</fn></fc>   \
                \<action=`xterm -e pacupd`>\
                    \<fc=lightblue><fn=1>%archupdates%</fn></fc>\
                \</action>   \
                \<action=`xterm -e htop`>\
                    \%cpu% %k10temp%   \
                    \%memory%\
                \</action>   \
                \%CYUL%   \
                \<action=`pavucontrol`>\
                    \%pulsevolume% %pulsemicvol%\
                \</action>   \
                \%date%   \
                \<action=`fcitx-configtool`>\
                    \<fn=4></fn> <fc=lightblue><fn=1>%im_pipe%</fn></fc> \
                \</action>"

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
       [
        -- Workspaces
          Run UnsafeStdinReader

        -- wifi activity monitor
        , Run Wireless "wlan0"
                             [ "--template" , "<qualityipat> <fc=lightblue><fn=1><ssid></fn></fc>"
                             , "--Low"      , "50"
                             , "--High"     , "70"
                             , "--low"      , "darkred"
                             , "--normal"   , "darkorange"
                             , "--high"     , "lightblue"
                             , "--nastring" , "<icon=status-nm-signal_offline.xpm/>"
                             , "--"
                             , "--quality-icon-pattern" , "<icon=status-nm-signal_%%.xpm/>"
                             ] 20

        --Redshift Period 
        , Run Com "/home/papa/bin/xmbGetRedshiftParams" [] "redshiftparams" 600
 
        -- -- Number of updates 
        -- , Run Com "/home/papa/bin/xmbGetNumberOfArchUpdates.sh" [] "archupdates" 600

        -- Number of updates 
        , Run PipeReader "/home/papa/.config/xmobar/archupd_pipe" "archupdates"

        -- cpu activity monitor
        , Run Cpu            [ "--template" , "<fn=4>\xf85a</fn><fn=1> <total></fn>%"
                             , "--Low"      , "70"
                             , "--High"     , "90"
                             , "--low"      , "lightblue"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             , "--width"    , "2"
                             , "--align"    , "l"
                             ] 20

        -- CPU temperature monitor for Radeon chips
        , Run K10Temp "0000:00:18.3"
                            [ "-t", "<fn=4>\xf2c9</fn> <fn=1><Tctl></fn>°C "
                            , "-L", "70", "-H", "100"
                            , "-l", "lightblue", "-n", "darkorange", "-h", "red"
                            ] 20

        -- memory usage monitor
        , Run Memory         [ "--template" ,"<fn=4>\xe266</fn> <fn=1><usedratio></fn>%"
                             , "--Low"      , "70"        -- units: %
                             , "--High"     , "90"        -- units: %
                             , "--low"      , "lightblue"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 20

        -- weather monitor
        , Run WeatherX "CYUL" 
                   [ ("clear",                      "<fn=4>\xe30d</fn>")
                    , ("sunny",                     "<fn=4>\xfa98</fn>")
                    , ("mostly clear",              "<fn=4>\xe30c</fn>")
                    , ("mostly sunny",              "<fn=4>\xe30c</fn>")
                    , ("partly sunny",              "<fn=4>\xe30d</fn>")
                    , ("fair",                      "<fn=4>\xe3e3</fn>")
                    , ("cloudy",                    "<fn=4>\xe33d</fn>")
                    , ("overcast",                  "<fn=4>\xe33d</fn>")
                    , ("partly cloudy",             "<fn=4>\xfa94</fn>")
                    , ("mostly cloudy",             "<fn=4>\xe32e</fn>")
                    , ("considerable cloudiness",   "<fn=4>\xe312</fn>")]
                   [ "--template"
                    ,   "<action=`firefox https://montréal.weatherstats.ca/`>\
                            \<fn=5><skyConditionS></fn> \
                            \<fc=lightblue><fn=1><tempC></fn></fc>°C  \
                            \<fn=4>\xe275</fn> \
                            \<fc=lightblue><fn=1><rh></fn></fc>%\
                        \</action>"
                             ] 18000

        -- Receives changes in volume by the script xmbSetPulseVol
        , Run PipeReader "/home/papa/.config/xmobar/volume_pipe" "pulsevolume"
 
        -- Receives changes in microphone volume by the script xmbSetPulseMicVol
        , Run PipeReader "/home/papa/.config/xmobar/micvol_pipe" "pulsemicvol"
 
        -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "<action=`firefox https://calendar.google.com/`>\
                                \%a %b %d <fc=lightblue><fn=1>%R</fn></fc> \
                             \</action>" "date" 600

        -- input method
--        , Run Com "/home/papa/bin/xmbGetCurrentIM.sh" [] "currim" 200

        -- Receives changes in volume by the script xmbSetPulseVol
        , Run PipeReader "/home/papa/.config/xmobar/im_pipe" "im_pipe"
 

        --
--        , Run MultiCpu       [ "--template" , "Cpu: <total0>%|<total1>%"
--                             , "--Low"      , "70"         -- units: %
--                             , "--High"     , "90"         -- units: %
--                             , "--low"      , "green"
--                             , "--normal"   , "darkorange"
--                             , "--high"     , "darkred"
--                             ] 10

        -- CPU temp 
        --, Run Com "/home/papa/bin/xmbGetCPUTemp.sh" [] "cputemp" 10
 
        -- network activity monitor (dynamic interface resolution)
        -- , Run DynNetwork     [ "--template" , "<dev>: D <tx>kB/s|U <rx>kB/s"
        --                      , "--Low"      , "1000"       -- units: B/s
        --                      , "--High"     , "5000"       -- units: B/s
        --                      , "--low"      , "darkgreen"
        --                      , "--normal"   , "darkorange"
        --                      , "--high"     , "darkred"
        --                      ] 10

        --, Run Volume "default:1"  "Master" ["-t", "Vol: <volume>%"] 10

        -- cpu core temperature monitor
        -- , Run CoreTemp       [ "--template" , "Temp: <core0>°C|<core1>°C"
        --                      , "--Low"      , "70"        -- units: °C
        --                      , "--High"     , "80"        -- units: °C
        --                      , "--low"      , "green"
        --                      , "--normal"   , "darkorange"
        --                      , "--high"     , "darkred"
        --                      ] 50
                          
        -- keyboard layout indicator
--        , Run Kbd            [ ("us(dvorak)" , "<fc=#00008B>DV</fc>")
--                             , ("us"         , "<fc=#8B0000>US</fc>")
--                             ]
        ]
   }
