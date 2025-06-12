local enableMove = true
function sprite(t,f,x,y,sc,s,fo,a) --tag, file, x, y, scale, foreground, animated
    if a == true then makeAnimatedLuaSprite(t,f,x,y)
    else makeLuaSprite(t,f,x,y) end
    if s ~= nil then scaleObject(t,s,s) end
    addLuaSprite(t,fo) --credits to Speg
    if sc ~= nil then setScrollFactor(t,sc,sc) end
end
function onCreate()
    sprite('sky','stages/crazy-racing/sky',-4970, -2500,2,10)
    for bgs = 0,1 do
        sprite('bg'..bgs,'stages/crazy-racing/clouds',-2893*bgs,-350,0.1,2)
        setProperty('bg'..bgs..'.velocity.x',20)
	end
    for fld = 0,2 do
        sprite('foreground'..fld,'stages/crazy-racing/field',3400*fld,50,0.5)
        setProperty('foreground'..fld..'.velocity.x',4500)
        scaleObject('foreground'..fld,3.6,3)
    end
	for trs = 0,2 do
        sprite('trees1'..trs,'stages/crazy-racing/trees',3400*trs,-170,0.5,2)
        setProperty('trees1'..trs..'.velocity.x',4500)
        scaleObject('trees1'..trs,3.6,3)
    end
	for pla = 0,1 do
        sprite('front'..pla,'stages/crazy-racing/platform',3500*pla,400,0.5)
        scaleObject('front'..pla,6,3.5)
        setProperty('front'..pla..'.velocity.x',9000000)
	end
    for rl = 0,1 do
        sprite('railway'..rl,'stages/crazy-racing/rail',-10*rl - 500,280,0.1,2)
        scaleObject('railway'..rl,3,2)
        setProperty('railway'..rl..'.velocity.x',5000)
    end
	for cn = 0,1 do
        sprite('coin1'..cn,'stages/crazy-racing/coin',-10*cn - -500,270,0.5,2)
        setProperty('coin1'..cn..'.velocity.x',5000)
    end
	sprite('fire', 'stages/crazy-racing/fire', 350, 450,1,1.6,false,true)
    addAnimationByPrefix('fire', 'idle', 'fire', 24, true)
	sprite('humo', 'stages/crazy-racing/humo', 350, 750,1,1.6,false,true)
    addAnimationByPrefix('humo', 'idle', 'humo', 24, true)
end
function onUpdatePost()
    if getProperty('trees11.x') >= 0 then for bgs = 0,2 do setProperty('trees1'..bgs..'.x',getProperty('trees1'..bgs..'.x')-3400) end end
    if getProperty('foreground1.x') >= 0 then for bgs = 0,2 do setProperty('foreground'..bgs..'.x',getProperty('foreground'..bgs..'.x')-3400) end end
end
function onCreatePost() callScript('scripts/Speg camGameRatings', 'editRatingConfig', {5,true}) callScript('scripts/Speg camGameRatings', 'editRatingConfig', {6,{true,-1,'gfGroup'}}) end
function onUpdate()
    if enableMove then
        setProperty('boyfriendGroup.x',-225 + (50*math.sin(getSongPosition()/bpm/2)))
        setProperty('dadGroup.x',-700 + (50*math.sin(getSongPosition()/bpm/2)))
		setProperty('fire.x',470 + (50*math.sin(getSongPosition()/bpm/2)))
		setProperty('humo.x',-1020 + (50*math.sin(getSongPosition()/bpm/2)))
        setProperty('gfGroup.x',-225 + (50*math.sin(getSongPosition()/bpm/2)))		
    end
    for bgs = 0,1 do
        if getProperty('front'..bgs..'.x') >= 1500 then setProperty('front'..bgs..'.x',getProperty('front'..bgs..'.x') - (-13850*1) - 23100) end
		if getProperty('coin1'..bgs..'.x') >= 6600 then setProperty('coin1'..bgs..'.x',getProperty('coin1'..bgs..'.x') - (2500*5) - 6000) end
        if getProperty('railway'..bgs..'.x') >= 6600 then setProperty('railway'..bgs..'.x',getProperty('railway'..bgs..'.x') - (2500*5) - 6000) end
    end
end