enabled = false
function onCreatePost()
    song = (songName:gsub(' ','-')):lower()
    if checkFileExists('images/poster-credits/'..song..'-poster.png') then
        makeAnimatedLuaSprite('intro','poster-credits/'..song..'-poster',-380,100) addLuaSprite('intro',true) setObjectCamera('intro','camOther')
        addAnimationByPrefix('intro','intro',song..'-poster',24,false)
        setProperty('intro.visible',false)
        enabled = true
    end
end
function onSongStart() if enabled then playAnim('intro','intro',true) setProperty('intro.visible',true) end end
function onUpdatePost() if curStep > 1 and getProperty('intro.animation.curAnim.finished') then removeLuaSprite('intro') close() end end