local gears = require("gears")
local lain  = require("lain")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
-- local beautiful = require("beautiful")
local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
-- beautiful.wibar_height:(10)
-- Constants
TERMINAL                                        = "kitty"
--BROWSER                                         = "chromium"

-- Nord theme colorscheme
local colors                                    = {}

--
---- Aurora Nord Scheme
colors.green                                    = "#D8EFCFFA"
colors.alpha_zero                               = "#00000000"
colors.red                                      = "#3f5dff"
colors.orange                                   = "#c44dff"          --"#F3cbb8"
colors.yellow                                   = "#ccccff"
colors.pink                                     = "#c94c4c"

---- Frost
colors.frost                                    = {}
colors.frost.darkest                            = "#222529"
colors.frost.lightest                           = "#b4d9e3"
colors.frost.aqua                               = "#41454c"
colors.frost.light_green                        = "#8FBCBB"

---- Snow Storm
colors.light                                    = {}
colors.light.lighter                            = "#ECEFF4"
colors.light.darker                             = "#D8DEE9"
colors.light.medium                             = "#eea29a"
--
---- Polar night
colors.polar                                    = {}
colors.polar.darkest                            = "#000000"
colors.polar.lightest                           = "#0e1111"
colors.polar.darker                             = "#221F1F"
colors.polar.lighter                            = "#00022F"
colors.bg                                       = "#0e1111"
local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/nordish"

-- Sets up the wallpaper 
theme.wallpaper                                 = theme.dir .. "/wallpaper.jpg"

-- Font
theme.font                                      = "FiraCode Nerd Font Mono 11"
theme.taglist_font                              = "JetBrainsMono Nerd Font 13"

-- Gaps between windows
-- Otherwise you can change them by using:
--      altkey + ctrl + j           = Increment gaps
  --    altkey + ctrl + h           = Decrement gaps
theme.useless_gap                               = 3

--  Foreground variables  --
theme.fg_normal                                 = "#ffffff" -- White
theme.fg_focus                                  = colors.green
theme.fg_urgent                                 = "#000000" -- Black
--  Background variables  --
theme.bg_normal                                 = colors.bg
theme.bg_focus                                  = theme.bg_normal
theme.bg_urgent                                 = colors.red

-- Systray background color
-- theme.bg_systray                	        = colors.polar.darkest

-- Systray icon spacing 
theme.systray_icon_spacing		        = 10

-- Taglist configuration --
theme.taglist_bg_occupied                       = colors.polar.darkest
theme.taglist_fg_occupied                       = colors.yellow
theme.taglist_bg_empty                          = colors.polar.darkest 
theme.taglist_fg_empty                          = colors.green
theme.taglist_bg_urgent                         = colors.polar.darkest
theme.taglist_fg_urgent                         = colors.pink
theme.taglist_fg_volatile                       = colors.frost.lightest
theme.taglist_bg_volatile                       = colors.polar.darkest
-- Colors
theme.taglist_fg_focus                          = colors.light.medium
theme.taglist_bg_focus                          = colors.polar.darkest
-- Taglist shape, refer to awesome wm documentation if you have 
-- any doubt about this!
theme.taglist_shape                             = gears.shape.rounded_rect

-- Icon spacing between workspace icons 
theme.taglist_spacing				= 0

-- Sets the border to zero
theme.border_width                              = 2

-- If the border is not zero, it'll show 
-- These colors 
theme.border_normal                             = colors.polar.lightest 
theme.border_focus                              = colors.polar.lightest
theme.border_marked                             = colors.polar.lightest

-- Titlebar variables, dont care about theme,
-- In this configuration file we wont use it!
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus


theme.layout_fairh                       = "/usr/share/awesome/themes/zenburn/layouts/fairh.png"
theme.layout_fairv                       = "/usr/share/awesome/themes/zenburn/layouts/fairv.png"
theme.layout_floating                    = "/usr/share/awesome/themes/zenburn/layouts/floating.png"
theme.layout_magnifier                   = "/usr/share/awesome/themes/zenburn/layouts/magnifier.png"
theme.layout_max                         = "/usr/share/awesome/themes/zenburn/layouts/max.png"
theme.layout_fullscreen                  = "/usr/share/awesome/themes/zenburn/layouts/fullscreen.png"
theme.layout_tilebottom                  = "/usr/share/awesome/themes/zenburn/layouts/tilebottom.png"
theme.layout_tileleft                    = "/usr/share/awesome/themes/zenburn/layouts/tileleft.png"
theme.layout_tile                        = "/usr/share/awesome/themes/zenburn/layouts/tile.png"
theme.layout_tiletop                     = "/usr/share/awesome/themes/zenburn/layouts/tiletop.png"
theme.layout_spiral                      = "/usr/share/awesome/themes/zenburn/layouts/spiral.png"
theme.layout_dwindle                     = "/usr/share/awesome/themes/zenburn/layouts/dwindle.png"
theme.layout_cornernw                    = "/usr/share/awesome/themes/zenburn/layouts/cornernw.png"
theme.layout_cornerne                    = "/usr/share/awesome/themes/zenburn/layouts/cornerne.png"
theme.layout_cornersw                    = "/usr/share/awesome/themes/zenburn/layouts/cornersw.png"
theme.layout_cornerse                    = "/usr/share/awesome/themes/zenburn/layouts/cornerse.png"

-- Menu variables
theme.menu_height                               = dpi(25)
theme.menu_width                                = dpi(260)

local markup = lain.util.markup

local clock = awful.widget.watch(
    "date +' %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

function theme.at_screen_connect(s)
    
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end

    gears.wallpaper.maximized(wallpaper, s, true)

    -- All tags open with layout 1
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    
    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing_widget = {
                {
                    forced_width  = 10,
                    forced_height = 10,
                    thickness     = 10,
                    color         = '#77777700',
                    widget        = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 5,
            layout  = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = 2,
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
                {
                  {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                  },
                  top = 1,
                  left = 5, 
                  right = 5,
                  widget = wibox.container.margin,
                },
                shape = gears.shape.rounded_rect,
                -- bg = colors.polar.darkest,
                widget  = wibox.container.background
            },
            nil,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
            end,
            layout = wibox.layout.align.vertical,
        },
    }
    -- Custom rounded background widget
    -- You can modify however you want
    -- Syntax:
    --  round_bg_widget(widget, background_colour, foreground)
    function round_bg_widget(widget, bg, fg)
      local widget = wibox.widget {
            
            -- Set up 
            {
                widget,
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 3,
                bottom = 3,
                right  = 10,
                widget = wibox.container.margin,
            },
            bg         = bg,
            fg         = fg,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
		
		return widget
    end
    -- The function ends
    
    function add_app(app, text, fg, bg, desc)     
            -- Set up 
        local popup = awful.popup {
          widget = {
              {
                text = desc,
                widget = wibox.widget.textbox
              },
              margins = 30,
              widget = wibox.container.margin
          },
          bg = theme.bg_normal,
          fg = theme.fg_normal,
          ontop=true,
          shape        = gears.shape.rounded_rect,
          visible      = false,
        }
        local widget = wibox.widget {
            {
                {
                text = text,
                font = "JetBrainsMono Nerd Font 14",
                widget = wibox.widget.textbox
                },
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 4,
                bottom = 4,
                right  = 10,
                widget = wibox.container.margin,
            },
            
            bg         = bg,
            fg         = fg,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
        -- When pressed the widget, it will
        -- change its color and spawn the app
        widget:connect_signal("button::press",
            function()
                widget.fg = colors.frost.lightest
                awful.spawn.with_shell(app)
            end
        )

        -- This function will be called when the button  is 
        -- released
        widget:connect_signal("button::release",
            function()
                widget.fg = fg
            end
        )

        -- When its on hover, it will change its color
        widget:connect_signal("mouse::enter",
            function()
                popup:move_next_to(mouse.current_widget_geometry)
                popup.visible = true
                widget.fg = colors.light.lighter
            end
        )
        
        widget:connect_signal("mouse::leave",
            function()
                widget.fg = fg
                popup.visible = false
            end
        )
        return widget
    end
    ---------- Simple widget separator ----------
    local sep   = wibox.widget.textbox("  ")
    
    ---------- If you want to change the size of the spacing,
    --         change the font size, instead of 5. Just play with it!
    sep.font    = "JetBrainsMono Nerd Font 5"
    
    function on_hover_msg(widget, message)
      local popup = awful.popup {
          widget = {
              {
                text = message,
                widget = wibox.widget.textbox
              },
              margins = 20,
              widget = wibox.container.margin
          },
          bg = theme.bg_normal,
          fg = theme.fg_normal,
          ontop=true,
          shape        = gears.shape.rounded_rect,
          visible      = false,
      }
      widget:connect_signal("mouse::enter",
        function()
          popup:move_next_to(mouse.current_widget_geometry)
          popup.visible = true
        end
      )

      widget:connect_signal("mouse::leave",
        function()
          popup.visible = false
        end
      )

      return widget
    end


    local menu = wibox.widget {
            {
                {
                    image  = theme.dir .. "/awesome.svg",
                    resize = true,
                    widget = wibox.widget.imagebox
                },
                --Margin 
                left   = 5,
                spacing = 10, 
                right  = 5,
                widget = wibox.container.margin,
            },
            
            bg         = colors.polar.darkest .. "AF",
            fg         = theme.bg_normal,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
    
    -- When pressed the widget, it will
    -- change its color and spawn the menu
    menu:connect_signal("button::press",
        function()
          awful.util.mymainmenu:toggle()
        end
    )

    local appsep= wibox.widget.textbox("  ")
    appsep.font = "JetBrainsMono Nerd Font 10"
    
    -- Systray -- 
    local systray = round_bg_widget(
      wibox.widget.systray()
      -- colors.polar.darkest,
      -- colors.green
    )

    --
    -- Volume widget
    --
    vol = wibox.widget{
            -- Set up 
           {
                {
                     
                    layout=wibox.layout.fixed.horizontal,
                    {
                        {
                          text="",
                          font="JetBrainsMono Nerd Font 15",
                          widget=wibox.widget.textbox
                        },
                        fg = colors.pink,
                        widget = wibox.container.background,
                    },

                    {
                        {
                          {
                            volume_widget{
                              main_color=colors.pink,
                              widget_type = 'horizontal_bar',
                              width = 50,
                              shape = gears.shape.rounded_rect,
                              bg_color=colors.polar.lighter
                            },
                            top = 1, right = 2,
                            bottom=2, left = 2,
                            widget = wibox.container.margin
                          },
                          
                          bg = colors.polar.darkest,
                          shape  = gears.shape.rounded_bar,
                          shape_clip = true,
                          widget = wibox.container.background
                        },
                        widget = wibox.container.margin,
                    },
                    widget = wibox.container.background
                },
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 0,
                bottom = 0,
                right  = 10,
                widget = wibox.container.margin,
            },

            bg         = colors.polar.darkest,
            fg         = colors.green,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
    }
    
    function fetch_popup(app, text, fg, bg)
      local widget = wibox.widget {
            {
                {
                text = text,
                font = "JetBrainsMono Nerd Font 12",
                widget = wibox.widget.textbox
                },
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 4,
                bottom = 4,
                right  = 10,
                widget = wibox.container.margin,
            },
            
            bg         = bg,
            fg         = fg,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
      }
      -- Popup   
      local popup = awful.popup{
          widget = {
              {
                {
                  {
                    image          = theme.dir .. "/awesome.svg",
                    resize         = true,
                    forced_width   = 140,
                    forced_height  = 140,
                    widget         = wibox.widget.imagebox
                  },
                  margins = 4,
                  widget = wibox.container.margin
                },
                {
                  {
                    awful.widget.watch(
                    [[bash -c "neofetch --stdout | python3 $HOME/.config/awesome/match.py -pipe -p '.+\[3\dm(.+)\n'"]], 16
                    ),
                    margins = 20,
                    widget = wibox.container.margin
                  },
                  shape = gears.shape.rounded_rect,
                  widget = wibox.container.background,
                  bg = colors.polar.darkest .. "ea"
                },
                shape = gears.shape.rounded_rect,
                widget = wibox.container.background,
                layout = wibox.layout.fixed.horizontal
              },
              margins = 10,
              widget = wibox.container.margin
          },
          bg = theme.bg_normal,
          fg = theme.fg_normal,
          ontop=true,
          shape        = gears.shape.rounded_rect,
          visible      = true,
      }

      -- When pressed the widget, it will
      -- change its color and spawn the app
      widget:connect_signal("button::press",
          function()
              widget.fg = colors.frost.lightest
              awful.spawn.with_shell(app)
          end
      )

      -- This function will be called when the button  is 
      -- released
      widget:connect_signal("button::release",
          function()
              widget.fg = fg
          end
      )

      -- When its on hover, it will change its color
      widget:connect_signal("mouse::enter",
          function()
              popup:move_next_to(mouse.current_widget_geometry)
              popup.visible = true
              widget.fg = colors.light.lighter
          end
      )
      
      widget:connect_signal("mouse::leave",
          function()
              widget.fg = fg
              popup.visible = false
          end
      )

      return widget
    end

    -- Creates the wibox 
    s.mywibox = awful.wibar(
      { 
        position = "top",
        screen = s, 
        width = dpi(s.workarea.width-40-theme.border_width-7),
        bg = theme.bg_normal,
        fg = theme.fg_normal,
        border_width = 5,
        border_color = colors.polar.lightest,
      }
    )

    local time = round_bg_widget(wibox.container.margin(clock,
               dpi(4),
               dpi(8)),
               colors.polar.darkest,
               colors.yellow
            )
    
    function calendar(widget)
      local popup = awful.popup {
          widget = {
            {
              {
                text = "── Calendar ──",
                align="center",
                widget = wibox.widget.textbox
              },
              widget = wibox.container.background
            },
            {
              {
                {
                  text = "",
                  align = "center",
                  font = "JetBrainsMono Nerd Font 60",
                  widget = wibox.widget.textbox
                },
                right = 20,
                left = 30,
                widget = wibox.container.margin
              },
              {
                {
                  {
                    
                    {
                      {
                        text = "Nyanpasu!",
                        widget = wibox.widget.textbox
                      },
                      {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.red,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %B",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                     {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.green,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %d",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                     {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.pink,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %Y",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                      {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.yellow,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %A",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                      {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.frost.lightest,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %H:%M%p ",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },                    
                      expand = 'none',
                      widget = wibox.container.background,
                      layout = wibox.layout.fixed.vertical
                    },

                    margins = 10,
                    widget = wibox.container.margin,
                  },

                  bg = colors.polar.darkest.."5a",
                  shape = gears.shape.rounded_rect,
                  widget = wibox.container.background
                },
                margins = 10,
                widget = wibox.container.margin
              },
              layout = wibox.layout.fixed.horizontal,

            },
            layout = wibox.layout.fixed.vertical,
            widget = wibox.container.margin
          },
          bg = theme.bg_normal,
          fg = theme.fg_normal,
          ontop=true,
          shape        = gears.shape.rounded_rect,
          visible      = false,
      }
      widget:connect_signal("mouse::enter",
        function()
          popup:move_next_to(mouse.current_widget_geometry)
          popup.visible = true
        end
      )

      widget:connect_signal("mouse::leave",
        function()
          popup.visible = false
        end
      )

      return widget
    end 
    local time = calendar(time)
    s.mywibox.y = 10
    
---------------------------------------
--                                    --
--            Widget setup            --
--                                    --
----------------------------------------
    
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand='none',

        { -- Left widgets
            appsep, appsep, appsep,
            menu, appsep, appsep, appsep,
            s.mypromptbox,
            -- Workspaces
            wibox.widget{
                {
                    awful.widget.taglist{
                      screen = s,
                      filter = awful.widget.taglist.filter.all,
                      buttons = awful.util.taglist_buttons
                    },

                    left   = 3,
                    top    = 2,
                    bottom = 2,
                    right  = 3,
                    widget = wibox.container.margin
                },
                shape = gears.shape.rounded_bar,
                -- bg = colors.polar.darkest,
                
                widget = wibox.container.background
            },
            
            layout = wibox.layout.fixed.horizontal,    

            
        },
        { -- center widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytasklist
        },
        
       -- { -- center widgets
       --     layout = wibox.layout.fixed.horizontal,
       --     wibox.widget.textbox("")
       -- },

        {
          -- right widgets
          layout = wibox.layout.fixed.horizontal,
          appsep,
          on_hover_msg(systray),
          appsep,
          on_hover_msg(vol, "System volume\nWheel up to increase volume\nWheel down to decrease volume\nClick to mute"),
          appsep,
          time,
          -- appsep,appsep,
          -- add_app(
          --     TERMINAL .." -e nmtui",
          --     "",
          --     colors.yellow,
          --     colors.polar.darkest,
          --     "Internet configuration"
          -- ),
          -- appsep,
          --  fetch_popup(
          --      TERMINAL .."flameshot",
          --      "",
          --      colors.green,
          --      colors.polar.darkest
          --      --"Prueba"
          --  ),
          appsep, appsep,
          
          on_hover_msg(round_bg_widget(
             {
              layout = wibox.layout.fixed.horizontal,
              awful.widget.layoutbox(s)
              
             }
            --  colors.polar.darkest,
            --  colors.frost.lightest
          ), "Current layout"),
          appsep
        }
    }
    awful.screen.padding(screen[s], {top = 20, left = 20,
                                    right = 20, bottom = 5})
end

-- Returns the theme 
return theme
