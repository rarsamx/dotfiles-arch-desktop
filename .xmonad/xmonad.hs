-- Darcs template taken from 
-- https://wiki.haskell.org/Xmonad/Config_archive

import Data.Monoid
import Data.List  -- for `isSuffixOf`
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import XMonad
import XMonad.Actions.WindowBringer
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Util.Dmenu
import XMonad.Util.Dzen as DZ
import XMonad.Util.Paste
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
--import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Util.Font (Align(..))

import XMonad.Config.Gnome
import XMonad.Actions.Plane
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import qualified Data.Map as M
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import System.IO(Handle, hPutStrLn)
import System.Exit
import Control.Monad

import Data.Tree
import qualified XMonad.Actions.TreeSelect as TS

import XMonad.Prompt as P
-- import XMonad.Prompt.AppLauncher as AL
import XMonad.Prompt.Shell
import XMonad.Prompt.FuzzyMatch

import XMonad.Actions.DynamicWorkspaces as DW
import XMonad.Actions.CopyWindow(copy)
import XMonad.Actions.CycleWS as CWS
import XMonad.Actions.WorkspaceNames as WN
-- import XMonad.Actions.UpdatePointer as UP

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "xterm"
--myTerminal      = "xterm -e tmux"

-- The pfereffed editor program
editor    = "gvimd" -- Wrapper for gvim to start a single instance

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
-- Setting it to false makes the xmonad Prompt and treeselect to freeze
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- Default font for most things
myFont = "xft:Ubuntu:size=11:antialias:=true"

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
--
--myWorkspaces :: [String]        
--myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
-- myWorkspaces = clickable . (map xmobarEscape) $ ["FreeMind","BBB","xzoom","Demos","Browser","6","7","8","9"]
                                                                              
--   where                                                                       
--          clickable l = [ "<action=xdotool key Super_L+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
--                              (i,ws) <- zip [1..9] l,                                        
--                             let n = i ]

myWorkspaces :: Forest String        
myWorkspaces = [ Node "1" []
               , Node "2" []
               , Node "3" []
               , Node "4" []
               , Node "5" []
               , Node "6" []
               , Node "7" []
               , Node "8" []
               , Node "9" []
               ]
                                                                              
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
--myFocusedBorderColor = "#ff0000"
--myFocusedBorderColor = "#0000ff"
myFocusedBorderColor = "#000000"

------------------------------------------------------------
-- Tree select for sound sinks and sources 
tsSound :: TS.TSConfig (X ()) -> X()
tsSound a = TS.treeselectAction a
   [ Node (TS.TSNode "Volume Control" ""  
                            (spawn "pavucontrol")) [] 
   , Node (TS.TSNode "> Default Speakers" "" (return ()))
       [ Node (TS.TSNode    "Built-in Audio Analog Stereo" ""  
                            (spawn "pacmd \"set-default-sink alsa_output.pci-0000_00_14.2.analog-stereo\"")) []
       , Node (TS.TSNode    "Plantronics Blackwire 520 Analog Stereo" "" 
                            (spawn "pacmd \"set-default-sink alsa_output.usb-Plantronics_Plantronics_Blackwire_5220_Series_54A8348DFAB44ED5BB6A2F7EED3724BA-00.analog-stereo\""))  []
       , Node (TS.TSNode    "Logitech H570e Stereo" "" 
                            (spawn "pacmd \"set-default-sink alsa_output.usb-Logitech_Inc_Logitech_H570e_Stereo_00000000-00.analog-stereo\""))  []
        ]
--   , Node (TS.TSNode "> Default Microphone" "" (return ()))
--       [ Node (TS.TSNode    "Plantronics Blackwire 520 Digital Stereo" "" 
--                            (spawn "pacmd \"set-default-source alsa_input.usb-Plantronics_Plantronics_Blackwire_520-00.iec958-stereo\"")) []
--       , Node (TS.TSNode    "LifeCam NX-6000 Multichannel" ""             
--                            (spawn "pacmd \"set-default-source alsa_input.usb-Microsoft_Microsoft___LifeCam_NX-6000-02.multichannel-input\""))  []
--       ]
    , Node (TS.TSNode "> Default Microphone" "" (return ()))
       [ Node (TS.TSNode    "Plantronics Blackwire 5220 Digital Stereo" "" 
                            (spawn "pacmd \"set-default-source alsa_input.usb-Plantronics_Plantronics_Blackwire_5220_Series_54A8348DFAB44ED5BB6A2F7EED3724BA-00.mono-fallback\"")) []
       , Node (TS.TSNode    "LifeCam NX-6000 Multichannel" ""             
                            (spawn "pacmd \"set-default-source alsa_input.usb-Microsoft_Microsoft___LifeCam_NX-6000-02.multichannel-input\""))  []
       ]
   ]

-- Tree select for shutdown options
tsPower :: TS.TSConfig (X ()) -> X()
tsPower a = TS.treeselectAction a
   [ Node (TS.TSNode "Restart Xmonad"   "" (spawn "xmonad --recompile; xmonad --restart"))  []
   , Node (TS.TSNode "Logout"           "" (spawn "gracefulShutdown logout"))  []  
   , Node (TS.TSNode "Reboot"           "" (spawn "gracefulShutdown reboot"))  []
   , Node (TS.TSNode "Shutdown"         "" (spawn "gracefulShutdown shutdown"))  []           
   ]

tsDefaultConfig :: TS.TSConfig a
tsDefaultConfig =  TS.TSConfig { TS.ts_hidechildren = False
                              , TS.ts_background   = 0x66000000               --   #c0c0c0
                              , TS.ts_font         = myFont
                              , TS.ts_node         = (0xff000000, 0xff666666) --  (#000000, #666666)
                              , TS.ts_nodealt      = (0xff000000, 0xff666666) --  (#000000, #666666)
                              , TS.ts_highlight    = (0xff000000, 0xff999999) --  (#000000, #999999)
                              , TS.ts_extra        = 0xffffffff               --   #000000
                              , TS.ts_node_width   = 400
                              , TS.ts_node_height  = 25
                              , TS.ts_originX      = 500
                              , TS.ts_originY      = 500
                              , TS.ts_indent       = 30
                              , TS.ts_navigate     = tsTreeNavigation
                           }

--myTreeNavigation:: M.Map (KeyMask, KeySym) (TreeSelect a (Maybe a))
tsTreeNavigation = M.fromList
    [ ((0, xK_Escape), TS.cancel)
    , ((0, xK_Return), TS.select)
    , ((0, xK_space),  TS.select)
    , ((0, xK_Up),     TS.movePrev)
    , ((0, xK_Down),   TS.moveNext)
    , ((0, xK_Left),   TS.moveParent)
    , ((0, xK_Right),  TS.moveChild)
    , ((0, xK_k),      TS.movePrev)
    , ((0, xK_j),      TS.moveNext)
    , ((0, xK_h),      TS.moveParent)
    , ((0, xK_l),      TS.moveChild)
    , ((0, xK_o),      TS.moveHistBack)
    , ((0, xK_i),      TS.moveHistForward)
    ]

------------------------------------------------------------
-- Prompts configuration
defXPConfig :: XPConfig
defXPConfig = def
      { P.font                = myFont
      , P.bgColor             = "#282c34"
      , P.fgColor             = "#bbc2cf"
      , P.bgHLight            = "#c792ea"
      , P.fgHLight            = "#000000"
      , P.borderColor         = "#535974"
      , P.promptBorderWidth   = 0
--      , promptKeymap        = dtXPKeymap
      , P.promptKeymap        = vimLikeXPKeymap
      , P.position            = Top
      -- , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
      , P.height              = 23
      , P.historySize         = 256
      , P.historyFilter       = id
      , P.defaultText         = []
      --, autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , P.autoComplete        = Nothing  -- set Just 100000 for .1 sec
      , P.showCompletionOnTab = False -- Only show list of completions when Tab was pressed
      -- , searchPredicate     = isPrefixOf
      , P.searchPredicate     = fuzzyMatch
      , P.defaultPrompter     = id -- $ map toUpper  -- change prompt to UPPER
      -- , defaultPrompter     = unwords . map reverse . words  -- reverse the prompt
      -- , defaultPrompter     = drop 5 .id (++ "XXXX: ")  -- drop first 5 chars of prompt and add XXXX:
      , P.alwaysHighlight     = True
      , P.maxComplRows        = Just 1 -- Nothing      -- set to 'Just 5' for 5 rows
      }

wsXPConfig :: XPConfig
wsXPConfig = def { P.position = Top
                , P.historySize = 50
                , P.font = myFont 
                , P.bgColor             = "#282c34"
                , P.fgColor             = "#bbc2cf"
                , P.bgHLight            = "#c792ea"
                , P.fgHLight            = "#000000"
                , P.borderColor         = "#535974"
                , P.promptBorderWidth   = 0
                , P.promptKeymap = vimLikeXPKeymap
                , P.historyFilter = deleteAllDuplicates
                 } 

------------------------------------------------------------------------
-- External commands used by Keybindings
--
sinkVolUp = "xmbSetPulseVol +5%" 
sinkVolDn = "xmbSetPulseVol -5%"
sinkMute  = "xmbSetPulseVol toggle"
micVolUp  = "xmbSetPulseMicVol +5%" 
micVolDn  = "xmbSetPulseMicVol -5%"
micMute   = "xmbSetPulseMicVol toggle"
closeWindows = "closeWindows"

confirm :: String -> X () -> X ()
confirm m f = do
  result <- dmenu [m]
  when (result == "Quit") f

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.

-- volDn = "amixer -q sset Master 4%-"
-- volUp = "amixer -q sset Master 2%+"
-- mute  "amixer set Master toggle"
 
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ 
      ((modm,                xK_p        ), spawn "dmenu_run")            -- launch dmenu
    , ((0 ,                  xK_Menu     ), shellPrompt defXPConfig )     -- launch shell prompt
--    , ((modm .|. shiftMask,  xK_Return   ), spawn $ XMonad.terminal conf) -- launch a terminal
    , ((modm .|. shiftMask,  xK_Return   ), runInTerm "" "tmux")   -- Open Terminal with tmux
    , ((modm,                xK_v        ), spawn editor     )            -- launch editor

    , ((modm,               xK_a        ), DW.selectWorkspace wsXPConfig)
    , ((modm .|. shiftMask, xK_a        ), DW.addWorkspacePrompt wsXPConfig )
    , ((modm,               xK_d        ), DW.renameWorkspace wsXPConfig) 
    , ((modm,               xK_d        ), WN.renameWorkspace wsXPConfig) 
    , ((modm .|. shiftMask, xK_d        ), DW.removeEmptyWorkspace)
    
    --  , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")              -- launch gmrun (not installed)

    -- **** Start Raul Modifications

    ------------------------------     
    -- Alternative ways to show menus
    -- Turn off/ Reboot / Suspend
    -- , ((modm, xK_q     ), spawn "xmobar  /home/papa/.config/xmobar/xmobarpoweroffrc.hs")
    -- , ((modm , xK_q     ), dzenConfig (timeout 20 >=> 
    --                                                  DZ.onCurr(center 400 100) >=> 
    --                                                  DZ.fgColor    "darkGreen" >=> 
    --                                                  DZ.bgColor    "darkGray" >=>
    --                                                  DZ.slaveAlign AlignCenter >=>
    --                                                  DZ.lineCount  4 >=>
    --                                                  DZ.addArgs    [ "-m", "h"
-- --                                                                , "-l", "4"
-- --                                                                , "-sa", "c"
    --                                                             , "-e"
    --                                                             , "button1=exit;button2=exit;\
    --                                                               \onstart=grabkeys;\
    --                                                               \key_Left=scrollup;\
    --                                                               \key_Right=scrolldown;\
    --                                                               \key_Escape=ungrabkeys,exit;\
    --                                                               \key_l=ungrabkeys,exec:gracefulShutdown logout"
    --                                                             ]
    --                                                  )  
    --       "^ca(1, gracefulShutdown shutdown)Shutdown^ca()^\n\
    --       \^ca(1, gracefulShutdown reboot  )Reboot^ca()\n\
    --       \^ca(1, gracefulShutdown logout  )Logout^ca()\n\
    --       \Cancel")

    -- Select the audio sink
    -- , ((modm,                xK_s     ), dzenConfig (timeout 10 >=> 
    --                                                  onCurr(center 400 25) >=> 
    --                                                  fgColor "#000000" >=> 
    --                                                  bgColor "#ffffff" >=>
    --                                                  lineCount 3
    --                                                 )  
    --       "Select Sound sink\n\
    --      \^ca(1,pacmd \"set-default-sink alsa_output.pci-0000_00_14.2.analog-stereo\")Built-in Audio Analog Stereo^ca()\n\
    --      \^ca(1,pacmd \"set-default-sink alsa_output.pci-0000_00_14.2.analog-stereo.echo-cancel\")Built-in Audio Analog Stereo (echo cancelled)^ca()\n\
    --      \^ca(1,pacmd \"set-default-sink alsa_output.usb-Plantronics_Plantronics_Blackwire_520-00.iec958-stereo\")Plantronics Blackwire 520 Analog Stereo^ca()")

    -- -- Select the audio source
    -- , ((modm .|. controlMask, xK_s     ), dzenConfig (timeout 10 >=> 
    --                                                   onCurr(center 400 25) >=> 
    --                                                   fgColor "#000000" >=> 
    --                                                   bgColor "#ffffff" >=>
    --                                                   lineCount 2
    --                                                  )  
    --       "Select Microphone\n\
    --      \^ca(1,pacmd \"set-default-source alsa_input.usb-Plantronics_Plantronics_Blackwire_520-00.iec958-stereo\")Plantronics Blackwire 520 Digital Stereo^ca()\n\
    --      \^ca(1,pacmd \"set-default-source alsa_input.usb-Microsoft_Microsoft___LifeCam_NX-6000-02.multichannel-input\")LifeCam NX-6000 Multichannel^ca()")



    -- ** Raul: Keyboard custom keys, requires import Graphics.X11.ExtraTypes.XF86
    --
    -- R:Sample execute two commands
    --  , ((0 ,  0x1008FF11), sequence_ [spawn "command1", spawn "command2"]  )

    --------------------------
    -- Multimedia keyboard controls
    , ((0,              xF86XK_AudioRaiseVolume ), spawn sinkVolUp )        -- Volume up
    , ((0,              xF86XK_AudioLowerVolume ), spawn sinkVolDn )        -- Volume down
    , ((0,              xF86XK_AudioMute        ), spawn sinkMute  )        -- Mute
    , ((controlMask,    xF86XK_AudioRaiseVolume ), spawn micVolUp )         -- Mic Volume up
    , ((controlMask,    xF86XK_AudioLowerVolume ), spawn micVolDn )         -- Mic Volume down
    , ((controlMask,    xF86XK_AudioMute        ), spawn micMute  )         -- Mic Mute
    , ((0,              xF86XK_AudioPlay        ), spawn "cmus-remote -u")  -- Play music
    , ((0,              xF86XK_AudioPause       ), spawn "cmus-remote -u")  -- Pause music
    , ((0,              xF86XK_AudioStop        ), spawn "cmus-remote -s")  -- Stop music
    , ((0,              xF86XK_AudioPrev        ), spawn "cmus-remote -r")  -- Previous track
    , ((0,              xF86XK_AudioNext        ), spawn "cmus-remote -n")  -- Next track
    , ((0,              xF86XK_Mail             ), spawn "thunderbird")     -- Open Mailreader
    , ((0,              xF86XK_HomePage         ), spawn "firefox")         -- Open Browser
    , ((0,              xF86XK_Documents        ), runInTerm "" "n3")   -- Open File mgr
    , ((0,              xF86XK_Calculator       ), runInTerm "" "bc -l")           -- Calculator
--    , ((0,              xF86XK_Documents        ), spawn "xterm -e 'tmuxc new-session n3'")       -- Open File mgr
    , ((0,              xK_Print                ), spawn "gnome-screenshot -i") -- Screenshot tool
    , ((shiftMask,      xK_Insert               ), spawn "gnome-screenshot -i") -- Screenshot tool
    
    ------------------------- 
    -- Keyboard layout (only needed if not using fcitx)
    --    , ((modm,      xK_u     ), spawn "setxkbmap -layout us")    -- layout to US
    --    , ((modm,      xK_i     ), spawn "setxkbmap -variant <fn=1>\xf011</fn>intl") -- Layout to US Int  
    
    -------------------------
    -- Treeselect Menues
    -- , ((modm,               xK_d    ), TS.treeselectWorkspace tsDefaultConfig myWorkspaces W.greedyView) -- Menu to select defautl speakers and microphone
    , ((modm,               xK_s    ), tsSound tsDefaultConfig ) -- Menu to select defautl speakers and microphone
    , ((modm,               xK_q    ), tsPower tsDefaultConfig ) -- Menu for Shutodwn options

    -- ----------------------
    -- Workspace management keybindings
    
    -- Show List of running apps to select one
    -- requires XMonad.Actions.WindowBringer
    , ((modm,               xK_g    ), gotoMenu)   --Switch to app workspace
    , ((modm .|. shiftMask, xK_g    ), bringMenu)  -- Brings app to workspace
 
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_Down  ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_Up    ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_Down  ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm .|. shiftMask, xK_Up    ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,                 xK_h   ), sendMessage Shrink)
    , ((modm .|. controlMask, xK_Left), sendMessage Shrink)

    -- Expand the master area
    , ((modm,                 xK_l    ), sendMessage Expand)
    , ((modm .|. controlMask, xK_Right), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    , ((modm              , xK_b     ), sendMessage ToggleStruts)
    , ((modm              , xK_equal ), incWindowSpacing 2)
    , ((modm              , xK_minus ), decWindowSpacing 2)

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++

    -- Raul: Changed keys to be left and right instead of w and e
    -- mod-{Left,Right,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{Left,Right,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_Left, xK_Right, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [
    ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout 
--  = avoidStruts ( tiled ||| wide ||| tabs ||| noBorders Full)
  = avoidStruts ( tall ||| wide ||| tabs ||| full )
  where
    myWindowGap = 0 :: Integer
    -- default tiling algorithm partitions the screen into two panes
    tall    
      = renamed [Replace "Tall"] $ 
          mySpacing myWindowGap $
          Tall nmaster delta ratio
      where
        nmaster = 1      -- The default number of windows in the master pane
        ratio   = 1/2    -- Default proportion of screen occupied by master pane
        delta   = 3/100  -- Percent of screen to increment by when resizing panes

    wide
      = renamed [Replace "Wide"] $ Mirror tall
    tabs
--      = renamed [Replace "Tabbed"] $ noBorders (tabbed shrinkText myTabConfig)
      = renamed [Replace "Tabbed"] $ tabbed shrinkText myTabConfig
      where
        myTabConfig = def { activeColor = "#556064"
                 , inactiveColor = "#2F3D44"
                 , urgentColor = "#FDF6E3"
                 , activeBorderColor = "#454948"
                 , inactiveBorderColor = "#454948"
                 , urgentBorderColor = "#268BD2"
                 , activeTextColor = "#80FFF9"
                 , inactiveTextColor = "#1ABC9C"
                 , urgentTextColor = "#1ABC9C"
                 , fontName = myFont
                 }
    full
      = renamed [Replace "Full"] $ Full

    mySpacing gap = spacingRaw False (Border 0 gap 0 gap) True (Border gap 0 gap 0) True


-----------------------------4-------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--

-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , (fmap ("gimp-image-window" `isPrefixOf`) role) --> (ask >>=doF . W.sink)
    , className =? "Gimp"           --> doFloat
    , className =? "Pavucontrol"    --> doFloat
--    , title     =? "Print"          --> doFloat
    , className =? "Zoiper"         --> doFloat
    , resource  =? "Dialog"         --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
    , role      =? "About"          --> doFloat]
  where role = stringProperty "WM_WINDOW_ROLE"
-- xmobarEscape = concatMap doubleLts
--   where doubleLts '<' = "<<"
--         doubleLts x   = [x]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--myStartupHook = return ()
myStartupHook = do
    spawn "xmbMonitorIMChanges"  -- Monitors for changes to the Input method
    spawn "xmbSetPulseVol"  -- Initializes the pipe with the volume
    spawn "xmbSetPulseMicVol"  -- Initializes the pipe with the volume
    spawn "xmbGetNumArchUpd"  -- Initializes the pipe with the volume
--    spawn "fcitx-autostart"
--    spawnOnce "nitrogen --restore"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

clickable l = [ "<action=xdotool key Super_L+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                (i,ws) <- zip [1..9] l,                                        
                             let n = i ]
-- Run xmonad with the settings you specify. No need to modify this.
--
--main = xmonad defaults
-- main = do
--         xmproc <- spawnPipe "xmobar -x 1 /home/papa/.config/xmobar/xmobarrc"
--         xmonad $ docks defaults
main = do
    xmproc <- spawnPipe "xmobar -x 0 /home/papa/.config/xmobar/xmobarrc.hs"
    xmonad $ docks $ ewmh defaults
        { manageHook = manageDocks <+> myManageHook 
        -- , layoutHook = avoidStruts  $  layoutHook desktopConfig
--        , workspaces = myWorkspaces
        , workspaces = TS.toWorkspaces myWorkspaces
--        , workspaces = clickable . (map xmobarEscape) $ TS.toWorkspaces myWorkspaces
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput  = hPutStrLn xmproc
                        , ppSep     = " | "
                        , ppSort    = getSortByXineramaRule
                        , ppCurrent = xmobarColor "lightblue" "darkBlue" . wrap "<fn=1> " " </fn>"
                        , ppHiddenNoWindows = xmobarColor "blue" ""
                        , ppHidden  = xmobarColor "gray" "" . wrap "<fn=1> " " </fn>"
                        , ppTitle   = xmobarColor "lightblue"  "" . shorten 40
                        , ppVisible = xmobarColor "yellow" "" . wrap "<fn=1> " " </fn>"
                        , ppUrgent  = xmobarColor "red" "yellow"
                        , ppOrder   = \(ws:_:t:_) -> [ws,t]
                        } 
                        -- >> UP.updatePointer (0.25, 0.25) (0.25, 0.25)
        } 
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        -- manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        -- logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'WinKey'.",
    "Current keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-Down       Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-Up         Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return     Swap the focused window and the master window",
    "mod-Shift-j    Swap the focused window with the next window",
    "mod-Shift-Down Swap the focused window with the next window",
    "mod-Shift-k    Swap the focused window with the previous window",
    "mod-Shift-Up   Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h          Shrink the master area",
    "mod-Ctl-Left   Shrink the master area",
    "mod-l          Expand the master area",
    "mod-Ctl-Right  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-{Left,Right,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "mod-Shift-{Left,Right,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging",
    "",
    "mod-g  Show List of running apps to switch to app/workspace",
    "mod-b  Show List of running apps to bring to current workspace"]
