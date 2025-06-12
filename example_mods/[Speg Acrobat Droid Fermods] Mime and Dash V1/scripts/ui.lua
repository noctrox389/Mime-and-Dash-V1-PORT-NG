function onCreate()
    if songName ~= 'crazy-racing' then
        sprite('overlay2','vignette',0,0)
	    sprite('stains','stains',0,0,2.75,nil,true)
        addAnimationByPrefix('stains', 'stains', 'stains', 14, true) 
        playAnim('stains', 'stains', true)
    end
    sprite('logoDerpixon','UI/derpixon',0,0,0.75)
    setProperty('logoDerpixon.alpha', 0.5)
    setProperty('logoDerpixon.x', screenWidth - getProperty('logoDerpixon.width') - 30)
    setProperty('logoDerpixon.y', screenHeight - getProperty('logoDerpixon.height') - 15)
    if version > '0.6.3' then setPropertyFromClass('states.PlayState','SONG.disableNoteRGB',true) end
end
function getTimeText()
    timeType = getPropertyFromClass('backend.ClientPrefs', 'data.timeBarType')
    if timeType == 'Disabled' then return ''
    elseif timeType == 'Song Name' then return '• '..songName..' •'
    else time = math.floor(getSongPosition()/1000)
        if timeType == 'Time Elapsed' then return '• '..formatTime(time)..' •'
        else return '• '..formatTime((songLength/1000)-time)..' •' end
    end
end
function formatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d", minutes, secs)
end
function onGameOver() setProperty('camGame.bgColor',getColorFromHex('313131')) end
function onCreatePost()
    setProperty('camGame.bgColor',getColorFromHex('000000'))
    sprite('hp','UI/healthbar',getProperty('healthBar.x')-45,getProperty('healthBar.y')-40,1,'camHUD')
    setProperty('timeBar.y',not downscroll and 0 or screenHeight-16) setTimeBarColors('AF004B','000000')
    setPropertyFromClass(version <= '0.6.3' and 'GameOverSubstate' or 'substates.GameOverSubstate','characterName','game-over')
    setScrollFactor('gf',1,1) for i = 1,2 do setProperty('iconP'..i..'.visible',false) end setTextString('botplayTxt', 'CUM-PLAY') end
function onUpdate() setProperty('camZooming', true) end
function onUpdatePost()
    setTextString('scoreTxt','Points: '..score.." • Wrong Guess's: "..misses..' • Accuracy: '..(ratingName == '?' and 'N/A' or (math.floor(rating*10000))/100 ..'%'))
    setTextString('timeTxt',getTimeText())
end
function sprite(t,f,x,y,s,c,a)
    if a == true then makeAnimatedLuaSprite(t,f,x,y) else makeLuaSprite(t,f,x,y) end
    addLuaSprite(t,true)
    setObjectCamera(t,c or 'camOther')
    if s ~= nil then scaleObject(t,s,s) end
end