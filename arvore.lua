local exports = {}
constantes = require('constantes')

exports.newArvore = function()
    local arvore = {}
    arvore.img = love.graphics.newImage('Arvore_normal.png')
    arvore.w = arvore.img:getWidth()
    arvore.h =  arvore.img:getHeight()
    arvore.x = (constantes.largura - arvore.w)/2
    arvore.y = constantes.altura - arvore.h
    return arvore
end

return exports