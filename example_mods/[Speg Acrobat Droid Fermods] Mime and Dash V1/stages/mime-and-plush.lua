function onCreate()
    makeLuaSprite('bg','stages/mime-and-plush/bg',-400,-550) addLuaSprite('bg')
	for e,i in pairs({'bonbon','chuchu'}) do
		makeAnimatedLuaSprite(i,'stages/mime-and-plush/'..i,e == 1 and -300 or 1450, -50) addLuaSprite(i)
		for v,t in pairs({{'idle','idle'},{'idle-shift','shift'},{'trans-to-shift','trans-shift'},{'trans-to-idle','transition-idle'}}) do addAnimationByPrefix(i,t[1],t[2],24,stringStartsWith(t[1],'idle') and true or false) end	
		playAnim(i, 'idle', true) scaleObject(i,3.2,3.2) setProperty(i..'.offset.x',-195) setProperty(i..'.offset.y',-150)
	end
end
function onCreatePost() setProperty('camZooming', true) end