---------------- RESOURSE ----------------
-- instance count
instances = 0

-- Game Global par
--[[
if global.device == "pc" then
	global.win_w = love.graphics.getWidth()
	global.win_h = love.graphics.getHeight()
	global.win_xoffset = global.win_w*.5
	global.win_yoffset = global.win_h*.5
end
]]

global.score = 0
global.best_score = 0

-- Load best score
if love.filesystem.getInfo("love.me") then
	file = love.filesystem.read("love.me")
	data = lume.deserialize(file)
	global.best_score = data.best_score
end

-- Music
music = {}
music.game = audio:newSource("assets/snd/snd_X_Ray_Vision_-_Slynk.ogg", "static")

-- Sounds
sound = {}
sound.jump   = audio:newSource("assets/snd/snd_jump.wav", "static")
sound.die    = audio:newSource("assets/snd/snd_die.wav", "static")
sound.money  = audio:newSource("assets/snd/snd_money.wav", "static")

-- Spites
sprite = {}
sprite.dot 		     = love.graphics.newImage("assets/spr/spr_dot.png") -- DEBUG
sprite.logo 	     = love.graphics.newImage("assets/spr/spr_logo.png")
sprite.linda 	  	 = love.graphics.newImage("assets/spr/spr_linda_sheet.png")
sprite.linda_over 	 = love.graphics.newImage("assets/spr/spr_linda_over.png")
sprite.coin 		 = love.graphics.newImage("assets/spr/spr_coin.png")
sprite.moon 		 = love.graphics.newImage("assets/spr/spr_moon.png")
sprite.star_particle = love.graphics.newImage("assets/spr/spr_pt_star.png")
sprite.ff 		     = love.graphics.newImage("assets/spr/spr_fox_fun.png")
sprite.db 		     = love.graphics.newImage("assets/spr/spr_dialog_box.png")
sprite.slice 	     = love.graphics.newImage("assets/spr/spr_slice.png")
-- wall
sprite.wadd          = love.graphics.newImage("assets/spr/spr_wall_add.png")
sprite.wpcenter      = love.graphics.newImage("assets/spr/spr_part_wall_center.png")
sprite.wpdown        = love.graphics.newImage("assets/spr/spr_part_wall_down.png")


-- Sprites masks
sprite.linda_mask = love.graphics.newImage("assets/spr/spr_mask_linda.png")
sprite.coin_mask  = love.graphics.newImage("assets/spr/spr_mask_coin.png")

-- Tiles
sprite.ground = love.graphics.newImage("assets/spr/spr_ground.png")
sprite.veg    = love.graphics.newImage("assets/spr/spr_vegetation.png")
sprite.stars  = love.graphics.newImage("assets/spr/spr_stars.png")

-- Quad, Sprite sheets
sheets = {}
sheets.linda 	  = cut_sheet(sprite.linda, 54, 48, 4)
sheets.linda_over = cut_sheet(sprite.linda_over, 54, 48, 1)
sheets.coin 	  = cut_sheet(sprite.coin, 14, 14, 5)
sheets.veg 		  = cut_sheet(sprite.veg, 128, 128, 13)
sheets.stars 	  = cut_sheet(sprite.stars, 600, 1080, 3)
sheets.ff 		  = cut_sheet(sprite.ff, 30, 32, 4)
sheets.db 		  = cut_sheet(sprite.db, 64, 68, 10)
sheets.wadd       = cut_sheet(sprite.wadd, 32, 32, 3)
sheets.slice      = cut_sclice(sprite.slice, 8, 8, 3)

-- Fonts
font = {}
font.score = love.graphics.newFont('assets/fnt/fnt_gamer.ttf', 120)
font.large = love.graphics.newFont('assets/fnt/fnt_gamer.ttf', 73)
font.small = love.graphics.newFont('assets/fnt/fnt_gamer.ttf', 22)

-- Collision masks
mask = {}
mask.linda = add_mask(sprite.linda_mask, 10) -- PLayer
mask.coin = add_mask(sprite.coin_mask) 		 -- Coin

mask.walls = add_mask(sprite.wpcenter)		 -- Wall

-- Pixel filter
for key, val in pairs(sprite) do val:setFilter('nearest', 'nearest') end
for key, val in pairs(font) do val:setFilter('nearest', 'nearest') end