local levelsBaseDir = "game/levels/"
levels = {} 

for _, filename in ipairs(love.filesystem.getDirectoryItems(levelsBaseDir) ) do
    if (string.find(filename, ".lua")) then
            local lvl = love.filesystem.load(levelsBaseDir .. filename)
            lvl()
    end
end