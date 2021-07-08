function love.load()
    local compressedData = love.data.compress( "string", "lz4", "Hello World")
    love.filesystem.write("data.txt", compressedData)
end
