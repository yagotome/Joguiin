local exports = {}

exports.newMira = function (x, y)
    local mira = {}    
    mira.x = x
    mira.y = y
    mira.img = love.graphics.newImage('mira_esquerda.png')
    mira.w = mira.img:getWidth()*0.34
    mira.h =  mira.img:getHeight()*0.34
    

    return mira
end

return exports