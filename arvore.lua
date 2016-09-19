local exports = {}
constantes = require('constantes')

exports.newArvore = function()
    local arvore = {}
    -- Nome: variável "arvore"
    -- Propriedade: Endereço
    -- Binding time: execução
    -- Explicação: dado que "arvore" é uma variável local, seu endereço só pode ser determinado em tempo de execução    

    arvore.img = love.graphics.newImage('Arvore_normal.png')
    arvore.w = arvore.img:getWidth()
    arvore.h =  arvore.img:getHeight()
    arvore.x = (constantes.largura - arvore.w)/2
    arvore.y = constantes.altura - arvore.h
    return arvore
end

return exports