-- Made by Speg | Don't stole or i'll kidnap you
local combo = 0
local combont = ''
local comboList = nil
local rat = 0
local textRating = {['sick'] = {0,'Sick'},['good'] = {0,'Good'},['bad'] = {0,'Bad'},['shit'] = {0,'Shit'},['hit'] = 0}
local options = {1,{1,-450,-300},{0.7,-425,-100,60},'',false,{false,0,'dadGroup'}}
--[[
    Ejemplitos:
    callScript('scripts/hud', 'editCountdownConfig', {4,''})
    callScript('scripts/hud', 'editCountdownConfig', {6,{true,0,'dadGroup'}})
    callScript('scripts/hud', 'editRatingConfig', {4,''})
    callScript('scripts/hud', 'editRatingConfig', {6,{true,0,'dadGroup'}})
]]
function editRatingConfig(num,conf)
    local n = 3
    if num == 'order' then n = 6
    elseif num == 'slide' then n = 5
    elseif num == 'folder' then n = 4
    elseif num == 'number' then n = 2
    elseif num == 'rating' then n = 3
    elseif num == 'scale' then n = 1 end
    if type(num) == 'number' then
        if num >= 1 and num <= 6 then n = num end
    end
    options[n] = conf
end
function goodNoteHit(i,_,_,s)
    if not s then
        local ra = getPropertyFromGroup('notes',i,'rating')
        createRating(ra,options[2][2],options[2][3],options[2][1])
        combo = getProperty('combo')
        if combo >= 10 then comboList = nil
            if combo >= 1000 then
                combont = tostring(combo)
                comboList = stringSplit(combont)
            else
                combont = tostring(combo)
                if combo < 10 then comboList = {'0','0',combont}
                elseif combo < 100 then comboList = {'0',tostring(stringSplit(combont)[1]),tostring(stringSplit(combont)[2])}
                else comboList = stringSplit(combont) end
            end
            for i, nums in pairs(comboList) do createRating('num'..nums,(((options[3][4]*options[1])*i-1))+options[3][2],options[3][3],options[3][1]) end
        end
    end
end
function onCreate() for _,i in pairs({'Combo','ComboNum','Rating'}) do setProperty('show'..i,false) end end
function onTimerCompleted(t) if stringEndsWith(t,',timer') then doTweenAlpha(stringSplit(t, ',')[1]..',tween',stringSplit(t, ',')[1],0,0.2,'linear') end end
function onTweenCompleted(t) if stringEndsWith(t,',tween') then removeLuaSprite(stringSplit(t,',')[1]) end end
function getCam(ty) return (ty == 'x' and getMidpointX('boyfriend') or getMidpointY('boyfriend'))+(getProperty('boyfriend.cameraPosition['..(ty == 'x' and 0 or 1)..']')*(ty == 'x' and -1 or 1))+getProperty('boyfriendCameraOffset['..(ty == 'x' and 0 or 1)..']')-100 end
function createRating(image,offX,offY,scale)
    makeLuaSprite('RatingGraphic'..rat,options[4]..image,getCam('x')+(offX*options[1]),getCam('y')+(offY*options[1]))
    addLuaSprite('RatingGraphic'..rat,true)
    scaleObject('RatingGraphic'..rat,scale*options[1],scale*options[1])
    setProperty('RatingGraphic'..rat..'.acceleration.y', 600)
    setProperty('RatingGraphic'..rat..'.velocity.y',-150 + math.random(1, 10))
    if options[5] == true then
        setProperty('RatingGraphic'..rat..'.acceleration.x',1200)
        setProperty('RatingGraphic'..rat..'.velocity.x',300+math.random(1,10))
    end
    if options[6][1] == true then setObjectOrder('RatingGraphic'..rat,getObjectOrder(options[6][3])+options[6][2]) end
    runTimer('RatingGraphic'..rat..',timer', crochet * 0.001)
    rat = rat+1
end