if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
   lldebugger=require('lldebugger')
   lldebugger.start()
end

-- Import Zenitha and other modules
           require('Zenitha')
CHAR      =require('assets.char')
BlackCover=require('assets.blackCover')


STRING.install()
SCR.resize(1280,720)
Zenitha.setMaxFPS(50) -- Enough
-- Zenitha.setShowFPS(false)
-- Zenitha.setVersionText('')
Zenitha.setOnGlobalKey('f11',function()
    love.window.setFullscreen(not love.window.getFullscreen())
    love.resize(love.graphics.getWidth(),love.graphics.getHeight())
end)

-- Add scene file and set default scene to main
SCENE_PATH='assets/scene'
for _,f in next,love.filesystem.getDirectoryItems(SCENE_PATH) do
    if FILE.isSafe(SCENE_PATH..'/'..f) then
        local sceneName=f:sub(1,-5)
        SCN.add(sceneName,require(SCENE_PATH..'/'..sceneName))
    end
end
Zenitha.setFirstScene('main')

-- Load font
FONT.load{
    main='assets/fonts/RHDisplayGalaxy-Medium.otf',
    symbols='assets/fonts/symbols.otf'
}
FONT.setDefaultFont('main')

-- Load image
IMG.init{
    placeholder ='assets/image/placeholder.png',
}

Zenitha.setOnFnKeys{
    function()
        if WIDGET.getSelected() then
            MSG.new('info',WIDGET.getSelected():getInfo())
        end
    end
}

--- For debugging
function REQUEST_BREAK()
    if lldebugger and love.keyboard.isDown('f12') then
        lldebugger.requestBreak()
    end
end