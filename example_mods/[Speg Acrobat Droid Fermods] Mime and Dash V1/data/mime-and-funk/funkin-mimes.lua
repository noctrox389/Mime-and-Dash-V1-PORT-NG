local getDefaultCamZoom = getProperty('defaultCamZoom') - 0.1
function onUpdate()
	if curStep == 1216 then if isBackviewSection == false then triggerEvent('Set Camera Zoom','boyfriend',getDefaultCamZoom+0.05) triggerEvent('Set Camera Zoom','dad',getDefaultCamZoom) triggerEvent('Set Camera Zoom','gf',getDefaultCamZoom) end end
	if curStep >= 1984 and curStep <= 2000 then triggerEvent('Set Camera Zoom','boyfriend',getDefaultCamZoom+0.05) triggerEvent('Set Camera Zoom','dad',getDefaultCamZoom) triggerEvent('Set Camera Zoom','gf',getDefaultCamZoom) end
end 