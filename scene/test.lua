local gc=love.graphics
local ins,rem=table.insert,table.remove

local scene={}

local backCounter
local list,timer
local function _push(mes)
    ins(list,{mes,120})
    timer=1
end

function scene.enter()
    backCounter=5
    list={}
    timer=0
end

function scene.gamepadDown(key)
    _push("[gamepadDown] <"..key..">")
end
function scene.gamepadUp(key)
    _push{COLOR.LD,"[gamepadUp] <"..key..">"}
end
function scene.keyDown(key,isRep)
    if isRep then return end
    _push("[keyDown] <"..key..">")
    if key=='escape'then
        backCounter=backCounter-1
        if backCounter==0 then
            SCN.back()
        else
            MES.new('info',backCounter,2.6)
        end
    end
end
function scene.keyUp(key)
    _push{COLOR.LD,"[keyUp] <"..key..">"}
end
function scene.mouseClick(x,y)
    SYSFX.new('ripple',.5,x,y,50)
    _push("[mouseClick]")
end
function scene.mouseDown(x,y,k)
    SYSFX.new('rect',.5,x-10,y-10,20,20)
    _push(("[mouseDown] <%d: %d, %d>"):format(k,x,y))
end
function scene.mouseMove(x,y)
    SYSFX.new('rect',.5,x-3,y-3,6,6)
end
function scene.mouseUp(x,y,k)
    SYSFX.new('rectRipple',1,x-10,y-10,20,20)
    _push{COLOR.LD,"[mouseUp] <"..k..">"}
end
function scene.touchClick(x,y)
    SYSFX.new('ripple',.5,x,y,50)
    _push("[touchClick]")
end
function scene.touchDown(x,y)
    SYSFX.new('rect',.5,x-10,y-10,20,20)
    _push(("[touchDown] <%d, %d>"):format(x,y))
end
function scene.touchMove(x,y)
    SYSFX.new('rect',.5,x-3,y-3,6,6)
end
function scene.touchUp(x,y)
    SYSFX.new('rectRipple',1,x-10,y-10,20,20)
    _push{COLOR.LD,"[touchUp]"}
end
function scene.wheelMoved(dx,dy)
    _push(("[wheelMoved] <%d, %d>"):format(dx,dy))
end
function scene.fileDropped(file)
    _push(("[fileDropped] <%s>"):format(file:getFilename()))
end
function scene.directoryDropped(path)
    _push(("[directoryDropped] <%s>"):format(path))
end

function scene.update(dt)
    if timer>0 then
        timer=timer-dt/.526
    end
    for i=#list,1,-1 do
        list[i][2]=list[i][2]-1
        if list[i][2]==0 then
            rem(list,i)
        end
    end
end

function scene.draw()
    gc.replaceTransform(SCR.xOy_ul)
    FONT.set(15,'_basic')
    local l=#list
    for i=1,l do
        gc.setColor(1,1,1,list[i][2]/30)
        gc.print(list[i][1],20,20*(l-i+1))
    end
end

return scene
