function opponentNoteHit(_,d,t)
    playAnim('gf',getProperty('singAnimations')[d+1],true)
    setProperty('gf.holdTimer',0)
end
function onCreate()
    makeLuaSprite('M','stages/backstage/mirror',-300,-550)
	setProperty('M.alpha', 0.5)
	scaleObject('M',2, 2)
    addLuaSprite('M')
	makeLuaSprite('bg','stages/backstage/bg',-330,-730)
    scaleObject('bg',2.4, 2.4)
    addLuaSprite('bg')
end
function onCreatePost()
    setObjectOrder('gfGroup',getObjectOrder('M'))
end