constantes =  require('constantes')

local exports = {}

exports.mu_s = function (s0, v, t) 
    return s0 + v*t
end

exports.muv_s = function (s0, v0, ac)
    local s_inicial = s0
    local vi = v0
    local a = ac
    local t = 0
    return function (dt)
        t = t + dt
        return s_inicial + vi*t + a*t*t/2        
    end
-- trabalho-04
-- Nome: Funcao anonima 
-- Propriedade: Endereço
-- Binding time: Execução
-- Explicação: Como a funcao anonima é definida no retorno da função muv_s, então o endereço só pode ser determinado em tempo de execução
end

exports.colide = function (o1, o2)
    return (o1.x+o1.w >= o2.x) and (o1.x <= o2.x+o2.w) and
            (o1.y+o1.h >= o2.y) and (o1.y <= o2.y+o2.h)
end

return exports