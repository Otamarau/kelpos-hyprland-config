-- Hyprland 0.57+ configuration.
-- Migrated from hyprland.conf; the legacy file is retained as a reference.

local terminal = "kitty"
local fileManager = "nautilus"
local menu = "rofi -show drun"
local mainMod = "SUPER"

----------------
-- Monitors --
----------------

hl.monitor({
    output = "DP-1",
    mode = "2560x1440@239.97",
    position = "1440x709",
    scale = 1.0,
})

hl.monitor({
    output = "DP-2",
    mode = "2560x1440@170.0",
    position = "0x0",
    scale = 1.0,
    transform = 3,
})

-----------------
-- Environment --
-----------------

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GTK_CSD", "1")
hl.env("GDK_BACKEND", "wayland")
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-------------------
-- Look and feel --
-------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = { top = 10, right = 15, bottom = 15, left = 15 },
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgba(183D24FF)", "rgba(183D24FF)" },
                angle = 45,
            },
            inactive_border = "rgba(0b2118ff)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.95,
        fullscreen_opacity = 1.0,
        dim_around = 0.20,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
    cursor = {
        no_hardware_cursors = false,
    },
})

----------------
-- Animations --
----------------

hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 } } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint",  style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",        style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint",  style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",        style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

--------------------------
-- Workspaces and rules --
--------------------------

-- Subtle backdrop while the rofi menu is open.
hl.layer_rule({
    name = "rofi-dim-backdrop",
    match = { namespace = "^rofi$" },
    dim_around = true,
})

hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })

hl.window_rule({
    name = "spotify-workspace",
    match = { class = "^Spotify$" },
    workspace = "2 silent",
})

hl.window_rule({
    name = "cava-workspace",
    match = { class = "^kitty$", title = "^cava$" },
    workspace = "2 silent",
})

hl.window_rule({
    name = "kitty-no-fullscreen",
    match = { class = "^kitty$" },
    fullscreen_state = "0 0",
    suppress_event = "fullscreen",
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------
-- Autostart --
---------------

hl.on("hyprland.start", function()
    hl.exec_cmd("greenclip daemon")
    hl.exec_cmd("python3 ~/.config/waybar/scripts/responsive-waybar.py & hyprpaper")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("mako")
    hl.exec_cmd("nm-applet --indicator")

    hl.exec_cmd("kitty -T cava -e cava")
    hl.exec_cmd("kitty -T asciiquarium -e asciiquarium")
    hl.exec_cmd(terminal)
    hl.exec_cmd("discord")
    hl.exec_cmd("spotify")
    -- Wait for all startup tiles; Spotify and Discord can take time to map.
    -- Use the Lua dispatcher; the legacy hyprctl syntax fails in Lua mode.
    local attempts, ready = 0, 0
    local mediaLayoutTimer
    mediaLayoutTimer = hl.timer(function()
        attempts = attempts + 1
        local cava = hl.get_window("title:^cava$")
        local spotify = hl.get_window("class:^Spotify$")
        local discord = hl.get_window("class:^(discord|Discord)$")
        if cava and cava.class == "kitty" and cava.mapped and spotify and spotify.mapped
            and discord and discord.mapped
            and cava.workspace and spotify.workspace
            and cava.workspace.id == spotify.workspace.id then
            ready = ready + 1
        else
            ready = 0
        end
        if ready >= 3 then
            local previous = hl.get_active_window()
            -- Remove Discord from its initial tile, then insert below Spotify.
            hl.dispatch(hl.dsp.window.float({ window = discord, action = "set" }))
            hl.dispatch(hl.dsp.window.move({ window = discord, workspace = "2", follow = false }))
            hl.dispatch(hl.dsp.focus({ window = spotify }))
            hl.dispatch(hl.dsp.layout("preselect d"))
            hl.dispatch(hl.dsp.window.float({ window = discord, action = "unset" }))
            if previous and previous.mapped then
                hl.dispatch(hl.dsp.focus({ window = previous }))
            end
            hl.dispatch(hl.dsp.window.resize({ x = 1396, y = 327, window = cava }))
            mediaLayoutTimer:set_enabled(false)
        elseif attempts >= 90 then
            mediaLayoutTimer:set_enabled(false)
        end
    end, { timeout = 1000, type = "repeat" })
    -- hl.exec_cmd("steam")

    hl.exec_cmd("/usr/lib/xdg-desktop-portal-gnome &")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal &")
    hl.exec_cmd("copyq --start-server")

    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland.service")
end)

-----------------
-- Keybindings --
-----------------

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("SUPER + Print", hl.dsp.exec_cmd([=[grim -g "$(slurp)" - | wl-copy]=]))
hl.bind("Print", hl.dsp.exec_cmd([=[grim ~/Pictures/$(date +'%Y-%m-%d_%H-%M-%S').png]=]))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("~/.local/bin/rofi-toggle.sh"))
-- Rofi 2.0 cannot detect outside clicks on Wayland itself.
-- Layer and cursor coordinates are both in the global monitor layout.
local function close_rofi_on_outside_click()
    local cursor = hl.get_cursor_pos()
    if not cursor then return end

    local pids = {}
    for _, layer in ipairs(hl.get_layers()) do
        if layer.mapped and layer.namespace == "rofi" then
            if cursor.x >= layer.x and cursor.x < layer.x + layer.w
                and cursor.y >= layer.y and cursor.y < layer.y + layer.h then
                return
            end
            if layer.pid and layer.pid > 0 then
                pids[layer.pid] = true
            end
        end
    end
    for pid in pairs(pids) do
        hl.exec_cmd("kill -TERM " .. string.format("%d", pid))
    end
end
hl.bind("mouse:272", close_rofi_on_outside_click, {
    non_consuming = true,
    ignore_mods = true,
})
-- Super + A opens the Wi-Fi / Bluetooth / Power quick menu.
hl.bind("SUPER + A", hl.dsp.exec_cmd("~/.config/waybar/scripts/quick-controls-rofi.sh"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("~/.config/hypr/Scripts/albumart.sh >/dev/null 2>&1; ~/.config/hypr/Scripts/lock-with-cava.py"))
hl.bind("ALT + TAB", hl.dsp.exec_cmd("rofi -show window"))

-- Keep the original percentage-based resize behavior; the native Lua resize
-- dispatcher currently accepts pixel values only.
hl.bind("SUPER + R", hl.dsp.exec_cmd("hyprctl dispatch resizeactive '50% 50%'"))

-- Temporarily remove gaps, borders, rounding, and opacity differences.
hl.bind(mainMod .. " + F", function()
    hl.config({
        general = {
            gaps_in = 0,
            gaps_out = 0,
            border_size = 0,
        },
        decoration = {
            rounding = 0,
            active_opacity = 1.0,
            inactive_opacity = 1.0,
        },
    })
    hl.exec_cmd("~/.config/waybar/scripts/set-background.sh opaque")
end)

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("~/.config/waybar/scripts/set-background.sh transparent; hyprctl reload"))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
