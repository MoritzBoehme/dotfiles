import XMonad
  ( Choose,
    Default (def),
    Full,
    KeyMask,
    Mirror,
    Tall,
    X,
    XConfig (modMask, terminal),
    mod4Mask,
    spawn,
    xmonad,
  )
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Util.EZConfig (additionalKeysP)

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "kitty"

myKeys :: [(String, X ())]
myKeys =
  [ ("M-d", spawn "rofi -show combi"),
    ("M-e", spawn "emacsclient -c -a emacs"),
    ("M-f", spawn "firefox")
  ]

myConfig :: (XConfig (Choose Tall (Choose (Mirror Tall) Full)))
myConfig =
  def
    { modMask = myModMask,
      terminal = myTerminal
    }
    `additionalKeysP` myKeys

main :: IO ()
main = xmonad $ ewmh $ ewmhFullscreen myConfig
