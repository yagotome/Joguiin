local exports = {}
constantes = require('constantes')

exports.newArvore = function()
    local arvore = {
        arvore.img = love.graphics.newImage('Arvore_normal.png'),
        arvore.w = arvore.img:getWidth()*0.5,
        arvore.h =  arvore.img:getHeight()*0.5,
        arvore.x = (constantes.largura - arvore.w)/2,
        arvore.y = constantes.altura - arvore.h        
    }
    -- trabalho-04
    -- Nome: variável "arvore"
    -- Propriedade: Endereço
    -- Binding time: execução
    -- Explicação: dado que "arvore" é uma variável local, seu endereço só pode ser determinado em tempo de execução    

    return arvore
    -- trabalho-06
    -- table 'arvore' é usada como registro
end
-- trabalho-04
-- Nome: palavra reservada "end"
-- Propriedade: Nome
-- Binding time: desenho
-- Explicação: A escolha do nome de uma palavra chave para fechar um bloco é feita em tempo de design.
return exports