function love.conf(t)
  t.identity = "org.flauschhaus.controller_launcher"
  t.version = "0.10.2"
  -- unused modules
  t.modules.physics = false
  t.modules.video = false
  t.modules.thread = false
  -- desktop window with ratio of full hd portrait
  t.window.width = 1280
  t.window.height = 720
end
