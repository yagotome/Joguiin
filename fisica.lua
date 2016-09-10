constantes =  require('constantes')

local exports = {}

exports.pular = function (y0, v0, t)
    local g = constantes.fisica.gravidade
    return y0 + v0*t + g*t*t/2
end

return exports