function onCreatePost()
    -- Crear un cuadro negro de 1000x1000 en el HUD
    makeLuaSprite('blackBox', '') -- Nombre del sprite
    makeGraphic('blackBox', 10, 300, '000000') -- Ancho: 1000, Alto: 1000, Color negro (#000000)
   -- screenCenter('blackBox', 'xy') -- Centrar en pantalla (opcional)
    setObjectCamera('blackBox', 'camOther') -- Asignar al HUD (cámara de UI)
    addLuaSprite('blackBox', false) -- 'false' = se dibuja encima de otros elementos del HUD
setProperty('blackBox.x', 1279.6) -- Mover 200 píxeles a la derecha
setProperty('blackBox.y', 200) -- Mover 150 píxeles hacia abajo
setProperty('blackBox.scale.y',2.5)
end