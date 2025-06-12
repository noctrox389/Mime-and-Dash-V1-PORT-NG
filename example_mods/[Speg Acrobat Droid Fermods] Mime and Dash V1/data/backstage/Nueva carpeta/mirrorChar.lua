configuracion = { --no se pq decidi agarrar este script, pero si, es hecho por mi
    tag = 'mBonbon', --el nombre que tiene que tener para que lo uses en tus scripts
    json = 'bonbon-back-mirror', --el json de tu nuevo oponente
}
function onCreate()
    createInstance(configuracion.tag,'objects.Character',{0,0,configuracion.json,false})
    addInstance(configuracion.tag,true)
end
function onCreatePost() setObjectOrder(configuracion.tag,getObjectOrder('M')-1) end
function onCountdownTick(c)if getProperty(configuracion.tag ..'.danceIdle') or (c == 2 or c == 4) then callMethod(configuracion.tag ..'.dance', {''})end end
function onBeatHit()if curBeat % getProperty(configuracion.tag ..'.danceEveryNumBeats') == 0 then callMethod(configuracion.tag ..'.dance',{''})end end
function opponentNoteHit(_,d,t)
    playAnim(configuracion.tag,getProperty('singAnimations')[d+1],true)
    setProperty(configuracion.tag ..'.holdTimer',0)
end
function onUpdatePost()
    if getProperty(configuracion.tag ..'.holdTimer') >= 0.4 and stringStartsWith(getProperty(configuracion.tag ..'.animation.curAnim.name'),'sing') then callMethod(configuracion.tag ..'.dance',{''}) end
end