off,cha,realChar,canUhAnimFollowIg,lc = 25,nil,nil,false,nil
customCam,offC,zooms = {},{{0,0},{0,0}},{}
chu = {['boyfriend'] = 'boyfriend',['gf'] = 'gf',['dad'] = 'dad'}
-- no lo roben porfis
--script hecho por Speg
function onEvent(n,v1,v2)
    if n == 'Set Camera Pos' then
        cho = valBF(v1)
        if v2 == '' then splito = {nil,nil}
        else
            splito = stringSplit(v2,',')
            for i = 1,2 do
                if splito[i] == '' then splito[i] = nil end
            end
        end
        customCam[cho] = {splito[1],splito[2]}
    elseif n == 'Set Camera Offset' then off = tonumber(v1)
    elseif n == 'Set Camera Target' then
        v,fv2 = valBF(v1),v2
        if v1:find('0') or v1:find('1') or v1:find('2') then
            vn = math.floor(tonumber(v1))
            if vn >= 0 and vn <= 2 then v = (vn == 0 and 'boyfriend' or vn == 1 and 'gf' or 'dad') end
        end
        if fv2 == '' then
            if v == 'gf' then fv2 = 'gf' elseif v == 'dad' then fv2 = 'dad' else fv2 = 'boyfriend' end
        end
        if v == 'boyfriend' or v == 'dad' or v == 'gf' then chu[v] = fv2 end
    elseif n == 'Set Camera Zoom' then
        chalo = valBF(v1)
        zooms[chalo] = tonumber(v2)
        if chalo == realChar then setProperty('defaultCamZoom',tonumber(v2)) end
    elseif n == 'Tween Cam Pos' then
        valosos = stringSplit(v1,',')
        twinthings = stringSplit(v2,',')
        for i = 1,2 do
            if valosos[i] == nil or valosos[i] == 'nil' then valosos[i] = getProperty('camFollow.'..(i == 1 and 'x' or 'y')) end
        end
        makeLuaSprite('nulmove',nil,getProperty('camFollow.x'),getProperty('camFollow.y'))
        addLuaSprite('nulmove',true)
        doTweenX('nulomoveekis','nulmove',tonumber(valosos[1]),tonumber(twinthings[1]),twinthings[2])
        doTweenY('nulomoveigriega','nulmove',tonumber(valosos[2]),tonumber(twinthings[1]),twinthings[2])
        setProperty('nulmove.alpha',0)
    end
end
function getCam(c,ty)
    pos = ty == 'x' and getMidpointX(realChar) or getMidpointY(realChar)
    ofC = (getProperty(realChar..'.cameraPosition['..(ty == 'x' and 0 or 1)..']')*(ty == 'x' and (realChar == 'boyfriend' and -1 or 1) or 1))
    of = getProperty((realChar == 'gf' and 'girlfriend' or (getProperty(realChar..'.isPlayer') == false and 'opponent' or 'boyfriend'))..'CameraOffset['..(ty == 'x' and 0 or 1)..']')
    return pos+ofC+of+(ty == 'x' and (realChar == 'boyfriend' and -100 or realChar == 'gf' and 0 or  150) or (realChar == 'gf' and 0 or -100))
end
function camPos(ch,type)
    if customCam[realChar] == nil then return getCam(ch,type) 
    else
        if customCam[realChar][type == 'y' and 2 or 1] == nil then return getCam(ch,type)
        else return customCam[realChar][type == 'y' and 2 or 1] end
    end
end
function setZoom()
    if lc ~= realChar then
        if zooms[realChar] ~= nil then setProperty('defaultCamZoom',zooms[realChar]) end
        lc = realChar
    end
end
function onUpdatePost()
    if not inGameOver and not getProperty('isCameraOnForcedPos') then
        realChar = chu[cha]
        setZoom()
        if luaSpriteExists('nulmove') then
            setProperty('camFollow.x',getProperty('nulmove.x'))
            setProperty('camFollow.y',getProperty('nulmove.y'))
        else
            setProperty('camFollow.x',camPos(cha,'x')+checkOff('x'))
            setProperty('camFollow.y',camPos(cha,'y')+checkOff('y'))
        end
    end
end
function onMoveCamera(f) cha = f end
function checkOff(typ)
    ano = getProperty(realChar..'.animation.curAnim.name')
    if stringStartsWith(ano,'idle') or stringStartsWith(ano,'dance') then
        offC[mustHitSection and 1 or 2] = {0,0}
        return 0
    else
        canUhAnimFollowIg = false
        for i, siga in pairs({'left','down','up','right'}) do
            if ano:find((siga)) then canUhAnimFollowIg = true end
        end
        if stringStartsWith(ano,'sing') then canUhAnimFollowIg = true end
        if canUhAnimFollowIg == true then
            if typ == 'y' then return off*((ano:lower()):find('up') and -1 or (ano:lower()):find('down') and 1 or 0)
            else return off*((ano:lower()):find('left') and -1 or (ano:lower()):find('right') and 1 or 0) end
        else return offC[mustHitSection and 1 or 2][typ == 'y' and 2 or 1] end
    end
end
function goodNoteHit(i,d) offC[1] = {(d == 0 and -off or d == 3 and off or 0),(d == 1 and off or d == 2 and -off or 0)} end
function opponentNoteHit(i,d) offC[2] = {(d == 0 and -off or d == 3 and off or 0),(d == 1 and off or d == 2 and -off or 0)} end
function onCreate()
    for _, cg in pairs({'boyfriend','gf','dad'}) do
        triggerEvent('Set Camera Pos',cg,'')
        triggerEvent('Set Camera Target',cg,cg)
    end
end
function valBF(valo)
    vulo = stringTrim(valo):lower()
    if vulo == nil or vulo == '' or vulo == 'bf' then return 'boyfriend'
    else return vulo end
end