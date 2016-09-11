Mira = require('mira')
local exports = {}

exports.newPlayer = function (x, y, nome_imagem)
    local player = {}    
    player.x = x
    player.y = y
    player.speed = 300
    player.img = love.graphics.newImage(nome_imagem)
    player.ground = player.y
    player.y_velocity = 0
    player.jump_height = -300
    player.gravity = -500
    player.w = player.img:getWidth()*0.34
    player.h =  player.img:getHeight()*0.34
    player.mira = Mira.newMira(player.x + player.w, player.y + player.h/3)

    return player
end

return exports