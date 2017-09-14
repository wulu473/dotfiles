import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import Data.Map as M (fromList, union)
import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
--import XMonad.Actions.GridSelect
--import XMonad.Layout.TwoPane

main = xmonad defaultConfig {  
-- Set mod key:
-- By default xmonad uses the alt key. Uncomment one of the following lines to use a different mod key
   modMask = mod4Mask, -- Bind mod key to win/cmd 
   terminal = "gnome-terminal",
   startupHook = ewmhDesktopsStartup >> setWMName "LG3D",
   keys = \c -> myKeys c `M.union` keys defaultConfig c
}

-- layout = Tall 1 (3/100) (1/2) ||| Full ||| TwoPane (3/100) (1/2)

-- key bindings
myKeys conf@(XConfig {XMonad.modMask = mod}) = M.fromList
  [ 
--((mod, xK_g), goToSelected defaultGSConfig)
  ((mod .|. shiftMask, xK_b), spawn "/lsc/opt/bin/google-chrome")
  , ((mod .|. shiftMask, xK_m), spawn "/lsc/zeushome/lw473/bin/mendeley")
    -- 0 here means no mod key
  , ((mod .|. shiftMask, xK_l), spawn "gnome-screensaver-command -l")
  , ((mod .|. shiftMask, xK_v), spawn "visit")
  , ((mod .|. shiftMask, xK_i), spawn "VirtualBox")
  , ((mod .|. shiftMask, xK_m), spawn "mathematica")
  ,((0, xK_F10), spawn "amixer set Master toggle")
  ,((0, xK_F11), spawn "amixer set Master 5%-")
  ,((0, xK_F12), spawn "amixer set Master 5%+")
  ]

myManageHooks = composeAll
 {-Allows focusing other monitors without killing the fullscreen-}
 --  [ isFullscreen --> (doF W.focusDown <+> doFullFloat)
  
  -- Single monitor setups, or if the previous hook doesn't work
      [ isFullscreen --> doFullFloat]

