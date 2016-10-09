local exports = {}
-- trabalho-04
-- Nome: palavra reservada "local"
-- Propriedade: semantica
-- Binding time: desenho
-- Explicação: dado que "local" é uma palavra reservada para definir o escopo de uma variável, ela só pode ter sido amarrada no desenho da linguagem.

exports.largura = 1024
exports.altura = 600

exports.fisica = {}
exports.fisica.gravidade = 1200

exports.ground = {}
exports.ground.y = 513

return exports