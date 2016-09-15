constantes =  require('constantes')

local exports = {}

exports.mu_s = function (s0, v, t) 
    return s0 + v*t
end

exports.muv_s = function (s0)
    local s_inicial = s0
    return function (v0, t, a)
        return s_inicial + v0*t + a*t*t/2        
    end
end

exports.colide = function (o1, o2)
    return (o1.x+o1.w >= o2.x) and (o1.x <= o2.x+o2.w) and
            (o1.y+o1.h >= o2.y) and (o1.y <= o2.y+o2.h)
end

return exports