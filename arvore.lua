local exports = {}
constantes = require('constantes')

exports.newArvore = function()
    local img = love.graphics.newImage('Arvore_normal.png')    
    local w = img:getWidth()*0.5
    local h = img:getHeight()*0.5
    local arvore = {
        img = img,
        w = w,
        h =  h,
        x = (constantes.largura - w)/2,
        y = constantes.altura - h        
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