import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders

doFloatNoFocus :: ManageHook
doFloatNoFocus = doFloat <+> doF W.focusDown

myManageHook = composeAll
    [ className =? "Xmessage" --> doFloatNoFocus
    , className =? "Alert" --> doFloatNoFocus
    , stringProperty "WM_WINDOW_ROLE" =? "alert" --> doFloatNoFocus
    , manageDocks
    ]

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig
        { modMask = mod4Mask
        , focusedBorderColor = "#7289da"
        , workspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        , manageHook = myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        -- Keep Xmobar visible.
        , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "".shorten 50
            }
        } `additionalKeysP`
        [ ("<XF86AudioLowerVolume>", spawn "amixer -D pulse sset Master 5%-")
        , ("<XF86AudioRaiseVolume>", spawn "amixer -D pulse sset Master 5%+")
        , ("<XF86AudioMute>", spawn "amixer -D pulse set Master 1+ toggle")
        , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
        , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
        , ("M-<Tab>", moveTo Next NonEmptyWS)
        , ("M-S-<Tab>", moveTo Prev NonEmptyWS)
        , ("M-0", windows $ W.greedyView "0")
        , ("M-S-0", windows $ W.shift "0")
        ]
