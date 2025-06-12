function getIconColor(chr) return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray"))) end
function rgbToHex(array) return string.format('%.2x%.2x%.2x', array[1], array[2], array[3]) end
function ghostHit(i,t,s,p)
	gh = p if t == 'GF Sing' or gfSection then gh = 'gf' end
	if not s then
		if _G[gh..'GhostData.strumTime'] == getPropertyFromGroup('notes',i,'strumTime') then createGhost(gh) end
		_G[gh..'GhostData.strumTime'] = getPropertyFromGroup('notes',i,'strumTime')
		updateGData(gh)	
	end
end
function goodNoteHit(i,d,t,s) ghostHit(i,d,s,'boyfriend') end
function opponentNoteHit(i,d,t,s) ghostHit(i,d,s,'dad') end
function createGhost(char)
	ghost = char..'Ghost'..getSongPosition()
    makeAnimatedLuaSprite(ghost, getProperty(char..'.imageFile'),getProperty(char..'.x'),getProperty(char..'.y'))
    addLuaSprite(ghost)
	scaleObject(ghost,getProperty(char..'.scale.x'),getProperty(char..'.scale.y'))
	setProperty(ghost..'.flipX', getProperty(char..'.flipX'))
	setProperty(ghost..'.color', getIconColor(char))
	doTweenAlpha(ghost..'delete', ghost, 0, 0.4)
	setProperty(ghost..'.animation.frameName', _G[char..'GhostData.frameName'])
	setProperty(ghost..'.offset.x', _G[char..'GhostData.offsetX'])
	setProperty(ghost..'.offset.y', _G[char..'GhostData.offsetY'])
	setObjectOrder(ghost, getObjectOrder(char..'Group')-1)
end
function onTweenCompleted(tag) if (tag:sub(#tag- 5, #tag)) == 'delete' then removeLuaSprite(tag:sub(1, #tag - 6), true) end end
function updateGData(char)
	_G[char..'GhostData.frameName'] = getProperty(char..'.animation.frameName')
	_G[char..'GhostData.offsetX'] = getProperty(char..'.offset.x')
	_G[char..'GhostData.offsetY'] = getProperty(char..'.offset.y')
end
-- i like number 45 :thumbs_up: