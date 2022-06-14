function love.conf(t)
    t.window.title = "Micro Metroidvania Prototype"
    t.window.width = 320 
    t.window.height = 180 
    t.window.vsync = 1
    t.window.fullscreen = true
    t.window.fullscreentype = "desktop"
    
    t.console = false
    t.modules.physics = false
end