constantes =  require('constantes')

local exports = {}

exports.pular = function (y0, v0, t)
    local g = constantes.fisica.gravidade
    return y0 + v0*t + g*t*t/2
end

exports.colide = function (o1, o2)
     return (o1.x+o1.w >= o2.x) and (o1.x <= o2.x+o2.w) and
           (o1.y+o1.h >= o2.y) and (o1.y <= o2.y+o2.h)
end

return exports