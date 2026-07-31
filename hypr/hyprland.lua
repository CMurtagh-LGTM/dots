------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "foot"
local fileManager = "thunar"
local editor = "neovide"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
  hl.exec_cmd("quickshell -n")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("hyprpm reload -n")
  -- hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("HYPRCURSOR_THEME", "everforest-cursors")


-----------------------
----- PERMISSIONS -----
-----------------------

hl.config({
  ecosystem = {
    enforce_permissions = true,
  },
})

hl.permission({binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow"})
hl.permission({binary = "/usr/(bin|local/bin)/grimshot", type = "screencopy", mode = "allow"})
hl.permission({binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow"})
hl.permission({binary = "/usr/(bin|local/bin)/hyprlock", type = "screencopy", mode = "allow"})
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 15,

        border_size = {{border_size}},

        col = {
            active_border   = { colors = {"{{blue_hypr}}", "{{purple_hypr}}"}, angle = 45 },
            inactive_border = "{{bg0_hypr}}",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = {{corner_radius}},
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
        force_split = 2,
        special_scale_factor = 0.9
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
        disable_autoreload = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        focus_on_activate = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "ctrl:nocaps",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
            scroll_factor = 0.5
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name="wacom-bamboo-16fg-4x5-touch",
    natural_scroll=true,
})

hl.device({
    name="wacom-bamboo-16fg-4x5-pen",
    output="DP-3",
})

hl.device({
    name="bcm5974",
    natural_scroll=true,
})

---------------
--- PLUGINS ---
---------------

if hl.plugin.dynamic_cursors then
    hl.config { plugin = { dynamic_cursors = {
        enabled = true,
        shake = {
            effects = 'tilt',
        },
        hyprcursor = {
            enabled = true,
        },
    }}}
end


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "{{mod}}"


hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("bombadil link"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("qs ipc call launcher toggle"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("wofi-pass -t"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("qs ipc call panel toggle"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("qs ipc call logout toggle"))
hl.bind(mainMod .. " + Z", hl.dsp.layout("togglesplit"))    -- dwindle only

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("grimshot copy area"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("hyprpicker"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + shift + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + shift + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + shift + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + shift + down",  hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i, on_current_monitor = true}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + ALT + D", hl.dsp.workspace.toggle_special("Discord"))
hl.bind(mainMod .. " + ALT + SHIFT + D", hl.dsp.window.move({ workspace = "special:Discord" }))
hl.bind(mainMod .. " + ALT + S", hl.dsp.workspace.toggle_special("Spotify"))
hl.bind(mainMod .. " + ALT + SHIFT + S", hl.dsp.window.move({ workspace = "special:Spotify" }))
hl.bind(mainMod .. " + ALT + T", hl.dsp.focus({ workspace = "name:Mail", on_current_monitor = true }))
hl.bind(mainMod .. " + ALT + SHIFT + T", hl.dsp.window.move({ workspace = "name:Mail" }))
hl.bind(mainMod .. " + ALT + G", hl.dsp.focus({ workspace = "name:Steam", on_current_monitor = true }))
hl.bind(mainMod .. " + ALT + SHIFT + G", hl.dsp.window.move({ workspace = "name:Steam" }))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),      { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),           { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),          { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),        { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                       { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                       { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set -d smc::kbd_backlight 5%+"), { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set -d smc::kbd_backlight 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    match = { class = "discord" },
    workspace = "special:Discord",
})
hl.window_rule({
    match = { class = "Spotify" },
    workspace = "special:Spotify",
})
hl.window_rule({
    match = { class = "org.mozilla.Thunderbird" },
    workspace = "name:Mail",
})
hl.window_rule({
    match = { class = "steam" },
    workspace = "name:Steam",
})
hl.window_rule({
    match = { class = "gamescope" },
    workspace = "name:Steam",
})

hl.window_rule({
    match = { class = "Godot", initial_title = "Godot" },
    tile = true,
})
