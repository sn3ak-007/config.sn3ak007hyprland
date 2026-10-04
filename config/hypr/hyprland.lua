-- ============================================================
-- MICTIAN HYPRLAND CONFIG
-- Linux + Hyprland Lua configuration
-- Laptop 1920x1080 @ 60Hz
-- ============================================================


-- ============================================================
-- PROGRAMS
-- ============================================================

local home = os.getenv("HOME")
if not home then
    error("HOME is not set")
end

local localBin = home .. "/.local/bin"
local terminal = os.getenv("TERMINAL") or "alacritty"
local fileManager = os.getenv("FILE_MANAGER") or "dolphin"
local launcher = os.getenv("LAUNCHER") or "fuzzel"
local browser = localBin .. "/hypr-launch-browser"


-- ============================================================
-- MONITOR
-- ============================================================

-- Let Hyprland choose preferred modes for laptop and external displays.
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})


-- ============================================================
-- ENVIRONMENT
-- ============================================================

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("SDL_VIDEODRIVER", "wayland,x11")


-- ============================================================
-- AUTOSTART
-- ============================================================

hl.on("hyprland.start", function()

    -- Use Mako so volume and brightness can update one notification in place.
    hl.exec_cmd("mako")

    -- Waybar
    hl.exec_cmd("waybar")

    -- Show a small notification whenever Caps Lock changes state.
    hl.exec_cmd(localBin .. "/hypr-osd caps-watch")

    -- Snap newly opened tiled windows to the nearest 10% of the work area.
    hl.exec_cmd(localBin .. "/hypr-window-snap")

    -- Use the video wallpaper when mpvpaper is installed, otherwise use hyprpaper.
    hl.exec_cmd(localBin .. "/hypr-video-wallpaper")

    -- Use the installed monochrome Xcursor theme.
    hl.exec_cmd("hyprctl setcursor Adwaita 24")

end)


-- ============================================================
-- LOOK & FEEL
-- ============================================================

hl.config({

    general = {

        -- Gaps
        gaps_in  = 6,
        gaps_out = 12,

        -- Window borders
        border_size = 2,
        resize_on_border = true,

        -- Layout
        layout = "dwindle",

        -- No tearing
        allow_tearing = false,

        -- Border colors
        col = {
            active_border = {
                colors = {
                    "rgba(eeeeeeee)",
                    "rgba(888888ee)"
                },
                angle = 45
            },

            inactive_border = "rgba(505050aa)",
        },
    },


    -- ========================================================
    -- DECORATION
    -- ========================================================

    decoration = {

        -- Square window corners.
        rounding = 0,
        rounding_power = 2,

        -- Fully opaque windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee000000,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.15,
        },
    },


    -- ========================================================
    -- ANIMATIONS
    -- ========================================================

    animations = {
        enabled = true,
    },


    -- ========================================================
    -- INPUT
    -- ========================================================

    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        accel_profile = "flat",

        touchpad = {
            natural_scroll = true,
            disable_while_typing = false,
            clickfinger_behavior = true,
            tap_to_click = true,
            scroll_factor = 0.4,
        },
    },


    -- ========================================================
    -- MISC
    -- ========================================================

    misc = {

        -- Don't show Hyprland anime wallpaper
        force_default_wallpaper = 0,

        -- Don't show Hyprland logo
        disable_hyprland_logo = true,

        -- Faster startup
        disable_splash_rendering = true,
    },


    -- ========================================================
    -- DWINDLE
    -- ========================================================

    dwindle = {

        -- Give the first two windows equal halves; later windows snap to 10% steps.
        default_split_ratio = 1.0,

        -- Let Dwindle alternate split direction from each area's shape.
        smart_split = false,
        preserve_split = true,

        smart_resizing = true,
    },


    -- ========================================================
    -- MASTER
    -- ========================================================

    master = {
        new_status = "master",
    },
})


-- ============================================================
-- ANIMATION CURVES
-- ============================================================

hl.curve(
    "easeOutQuint",
    {
        type = "bezier",
        points = {
            {0.23, 1},
            {0.32, 1}
        }
    }
)

hl.curve(
    "easeInOutCubic",
    {
        type = "bezier",
        points = {
            {0.65, 0.05},
            {0.36, 1}
        }
    }
)

hl.curve(
    "quick",
    {
        type = "bezier",
        points = {
            {0.15, 0},
            {0.1, 1}
        }
    }
)


-- Global animation
hl.animation({
    leaf = "global",
    enabled = true,
    speed = 10,
    bezier = "easeOutQuint"
})


-- Windows
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint"
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint"
})


hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 5,
    bezier = "easeOutQuint",
    style = "popin 85%"
})


hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 4,
    bezier = "quick",
    style = "popin 85%"
})


-- Fade
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 4,
    bezier = "quick"
})


hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 4,
    bezier = "quick"
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3,
    bezier = "quick"
})


-- Workspaces
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
    style = "fade"
})


-- ============================================================
-- KEYBINDS
-- ============================================================

local mainMod = "SUPER"


-- ------------------------------------------------------------
-- Applications
-- ------------------------------------------------------------

-- Terminal
hl.bind(
    mainMod .. " + RETURN",
    hl.dsp.exec_cmd(terminal),
    {
        description = "Open terminal"
    }
)


-- File manager
hl.bind(
    mainMod .. " + E",
    hl.dsp.exec_cmd(fileManager),
    {
        description = "Open file manager"
    }
)


-- Launcher
hl.bind(
    mainMod .. " + SPACE",
    hl.dsp.exec_cmd(launcher),
    {
        description = "Open application launcher"
    }
)

-- Browser
hl.bind(
    mainMod .. " + SHIFT + B",
    hl.dsp.exec_cmd(browser),
    {
        description = "Open browser"
    }
)

-- ------------------------------------------------------------
-- Window management
-- ------------------------------------------------------------

-- Close window
hl.bind(
    mainMod .. " + Q",
    hl.dsp.window.close(),
    {
        description = "Close window"
    }
)


-- Toggle floating
hl.bind(
    mainMod .. " + V",
    hl.dsp.window.float({
        action = "toggle"
    }),
    {
        description = "Toggle floating"
    }
)


-- Fullscreen
hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen(),
    {
        description = "Fullscreen"
    }
)


-- Pseudo
hl.bind(
    mainMod .. " + P",
    hl.dsp.window.pseudo(),
    {
        description = "Toggle pseudo"
    }
)


-- Toggle split
hl.bind(
    mainMod .. " + J",
    hl.dsp.layout("togglesplit"),
    {
        description = "Toggle split"
    }
)


-- ------------------------------------------------------------
-- Focus
-- ------------------------------------------------------------

hl.bind(
    mainMod .. " + LEFT",
    hl.dsp.focus({
        direction = "left"
    }),
    {
        description = "Focus left"
    }
)


hl.bind(
    mainMod .. " + RIGHT",
    hl.dsp.focus({
        direction = "right"
    }),
    {
        description = "Focus right"
    }
)


hl.bind(
    mainMod .. " + UP",
    hl.dsp.focus({
        direction = "up"
    }),
    {
        description = "Focus up"
    }
)


hl.bind(
    mainMod .. " + DOWN",
    hl.dsp.focus({
        direction = "down"
    }),
    {
        description = "Focus down"
    }
)


-- ------------------------------------------------------------
-- Move windows
-- ------------------------------------------------------------

hl.bind(
    mainMod .. " + SHIFT + LEFT",
    hl.dsp.window.move({
        direction = "left"
    }),
    {
        description = "Move window left"
    }
)


hl.bind(
    mainMod .. " + SHIFT + RIGHT",
    hl.dsp.window.move({
        direction = "right"
    }),
    {
        description = "Move window right"
    }
)


hl.bind(
    mainMod .. " + SHIFT + UP",
    hl.dsp.window.move({
        direction = "up"
    }),
    {
        description = "Move window up"
    }
)


hl.bind(
    mainMod .. " + SHIFT + DOWN",
    hl.dsp.window.move({
        direction = "down"
    }),
    {
        description = "Move window down"
    }
)


-- ============================================================
-- WORKSPACES
-- ============================================================

for i = 1, 10 do

    local key = i % 10

    -- Switch workspace
    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({
            workspace = i
        }),
        {
            description = "Switch to workspace " .. i
        }
    )


    -- Move window to workspace
    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({
            workspace = i
        }),
        {
            description = "Move window to workspace " .. i
        }
    )

end


-- ============================================================
-- WORKSPACE SCROLLING
-- ============================================================

hl.bind(
    mainMod .. " + mouse_down",
    hl.dsp.focus({
        workspace = "e+1"
    })
)


hl.bind(
    mainMod .. " + mouse_up",
    hl.dsp.focus({
        workspace = "e-1"
    })
)


-- ============================================================
-- SPECIAL WORKSPACE
-- ============================================================

hl.bind(
    mainMod .. " + S",
    hl.dsp.workspace.toggle_special("scratch")
)


hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.window.move({
        workspace = "special:scratch"
    })
)


-- ============================================================
-- MOUSE WINDOW CONTROL
-- ============================================================

hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    {
        mouse = true
    }
)


hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    {
        mouse = true
    }
)


-- ============================================================
-- AUDIO
-- ============================================================

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        localBin .. "/hypr-osd volume-up"
    ),
    {
        locked = true,
        repeating = true
    }
)


hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        localBin .. "/hypr-osd volume-down"
    ),
    {
        locked = true,
        repeating = true
    }
)


hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd(
        localBin .. "/hypr-osd volume-mute"
    ),
    {
        locked = true
    }
)


hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ),
    {
        locked = true
    }
)


-- ============================================================
-- BRIGHTNESS
-- ============================================================

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd(
        localBin .. "/hypr-osd brightness-up"
    ),
    {
        locked = true,
        repeating = true
    }
)


hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd(
        localBin .. "/hypr-osd brightness-down"
    ),
    {
        locked = true,
        repeating = true
    }
)


-- ============================================================
-- MEDIA
-- ============================================================

hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd(localBin .. "/waybar-media toggle"),
    {
        locked = true
    }
)


hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd(localBin .. "/waybar-media toggle"),
    {
        locked = true
    }
)


hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd(localBin .. "/waybar-media next"),
    {
        locked = true
    }
)


hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd(localBin .. "/waybar-media previous"),
    {
        locked = true
    }
)


-- ============================================================
-- SCREENSHOTS
-- ============================================================

-- Full screen screenshot
hl.bind(
    "PRINT",
    hl.dsp.exec_cmd(
        "grim ~/Pictures/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
    ),
    {
        description = "Take screenshot"
    }
)


-- Select area screenshot
hl.bind(
    "SHIFT + PRINT",
    hl.dsp.exec_cmd(
        "grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
    ),
    {
        description = "Screenshot selected area"
    }
)


-- ============================================================
-- LOCK SCREEN
-- ============================================================

hl.bind(
    mainMod .. " + L",
    hl.dsp.exec_cmd("hyprlock"),
    {
        description = "Lock screen"
    }
)


-- ============================================================
-- POWER MENU
-- ============================================================

hl.bind(
    mainMod .. " + SHIFT + Q",
    hl.dsp.exec_cmd(localBin .. "/waybar-control-menu power"),
    {
        description = "Power menu"
    }
)


-- ============================================================
-- CLIPBOARD
-- ============================================================

-- Clipboard history requires cliphist.
-- Uncomment after installing cliphist:
--
-- hl.bind(
--     mainMod .. " + C",
--     hl.dsp.exec_cmd(
--         "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
--     )
-- )


-- ============================================================
-- WINDOW RULES
-- ============================================================

-- Don't let applications force maximize
hl.window_rule({
    name = "disable-maximize",
    match = {
        class = ".*"
    },

    suppress_event = "maximize",
})


-- XWayland drag fix
hl.window_rule({
    name = "xwayland-drag-fix",

    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})


-- ============================================================
-- TOUCHPAD GESTURE
-- ============================================================

-- Three-finger swipe between workspaces
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})


-- ============================================================
-- END
-- ============================================================
