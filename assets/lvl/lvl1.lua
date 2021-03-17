--- Lvl 1
levels[1] = function()
	
	-- Set local func
	local set_bg_color = love.graphics.setBackgroundColor
	local draw_text = love.graphics.print
	local set_font = love.graphics.setFont
	local set_color = love.graphics.setColor
	local draw_sprite = love.graphics.draw
	local ceil = math.ceil
	local floor = math.floor
	local random = math.random

	-- Save best score
	function save_score()
		data = {}
		data.best_score = global.best_score

		serialized = lume.serialize(data)
    	love.filesystem.write("love.me", serialized)
	end

	-- Restart room
	function room_restart()
		obj_linda:create()
		global.score = 0
		global.menu = true

		for i=#walls, 1, -1 do
			instance_destroy(walls, i)
		end

		for i=#coins, 1, -1 do
			instance_destroy(coins, i)
		end
	end
	
	function level_load()
		
		-- Effects
		sin_value, sin = 0, 0
		fnt_size = 1
		stars_alpha = 0
		stars_alpha_control = 0

		-- Globals
		global.fps = 60
		global.debug = false
		global.world_speed = 3 * ratio
		global.start = false
		global.over = false
		global.menu = true
		global.night = false
		global.score_board = false

		-- Parse resolution
		success = love.window.setMode(global.win_w, global.win_h)

		if (3 * ratio)%2 == 0 then
			global.world_speed = global.world_speed + 1
		end

		-- Tables
		obj = {}
		walls = {}
		coins = {}

		-- Load obj		
		require "assets/obj/obj_ff"
		require "assets/obj/obj_linda"
		require "assets/obj/obj_wall_control"

		-- Create obj
		obj_linda:create()
		obj_ff:create()

		-- Particls
		pt_star = require "assets/obj/obj_particle"

		-- Music
		music.game:setVolume(.1)
  		music.game:play()
  		music.game:setLooping(true)

  		local ground_w = sprite.ground:getWidth() * ratio
		do -- Create floor
			grounds = {}
			local tile_x = global.win_w / ground_w

			for x = 0, tile_x + 2 do
				local tile_ground = {}
				tile_ground.x = ground_w*x
				tile_ground.y = global.win_h - ground_w
				tile_ground.speed = ceil(global.world_speed*.5)

				function tile_ground:draw()
					if (global.over == false) then
						self.x = self.x - self.speed
					end
					if (self.x < -ground_w) then
						self.x = global.win_w
					end
					draw_sprite(sprite.ground, self.x, self.y, 0, ratio, ratio)
				end
				table.insert(grounds, tile_ground)
			end
		end -- floor

		do -- Create veg
			vegs = {}
			local spr_cut =  sheets.veg
			local veg_w = sprite.veg:getWidth() / spr_cut.image_number
			local tile_x = global.win_w / veg_w

			local veg_h = spr_cut.frame_yoffset
			for x = 0, tile_x + 5 do
				local tile_veg = {}
				tile_veg.x = random(64*ratio, veg_w*x)
				tile_veg.y = global.win_h - (veg_h + ground_w)
				tile_veg.speed = ceil(global.world_speed*.5)
				tile_veg.frame = random(1, 13)
				tile_veg.xscale = 1

				function tile_veg:draw()
					if (global.over == false) then
						self.x = self.x - self.speed
					end
					if (self.x < -veg_w) then
						self.x = global.win_w + veg_w
						self.frame = random(1, 13)
						tile_veg.xscale = random(-1, 1) > 0 and 1 or -1
					end
					draw_sprite(sprite.veg, spr_cut.frames[self.frame], self.x, self.y, 0, self.xscale, 1, spr_cut.frame_xoffset, spr_cut.frame_yoffset)
				end
				table.insert(vegs, tile_veg)
			end
		end -- veg

		do -- Create stars
			stars = {}
			local spr_cut = sheets.stars
			local stars_w = (sprite.stars:getWidth()*ratio) / spr_cut.image_number
			
			for i = 1, 3 do
				local stars_i = sheets.stars.frames[i]
				for x = 0, 1 do
					local tile_stars = {}
					tile_stars.x = x*(600*ratio)
					tile_stars.y = 0
					tile_stars.speed = i * .5

					function tile_stars:draw()
						--
						if (global.over == false) then
							self.x = self.x - self.speed
						end
						--
						if (self.x < -stars_w) then
							self.x = global.win_w + 50
						end
						--
						set_color(rgba(255,255,255,stars_alpha))
						draw_sprite(sprite.stars, spr_cut.frames[i], self.x, self.y)
						set_color(1,1,1,1)
					end
					table.insert(stars, tile_stars)
				end
			end
		end -- Stars

	end
	-- load func
	level_load()

	function key_or_not_key_press()
		if global.score_board == false then
			if (global.over) then
				room_restart()
			end

			if (global.start == false) and (global.over == false) then
				global.menu = false
				obj_linda.vspeed = -8
				global.start = true
			end

			if (global.start == false) and (global.over == true) then
				global.over = false
			end
		end
	end

	function love.update(dt)

		function love.keypressed(key, scancode, isrepeat)
		   if key == "space" then
		      key_or_not_key_press()
		   end

		   if key == "d" then
		   	global.debug = not global.debug 
		   end

		end

		-- effects
		sin_value = sin_value + ((math.pi*2) / 60)
		sin = .5 + math.sin(sin_value) - .5
		fnt_size = lerp(fnt_size, ratio, 0.075)

		do -- Movement
			function love.mousepressed(x, y, button, istouch)
				if (button == 1) or (istouch == 1) then
					key_or_not_key_press()
				end
			end
		end
		
		-- Objects steps (move, collsion..)
		for i = 1, #obj, 1 do
			obj[i]:step()
		end

		for i=#walls, 1, -1 do
			walls[i]:step()
		end

		for i=#coins, 1, -1 do
			coins[i]:step()
		end

	end -- Love Update

	function debug_outline(_obj, _check, _spr, _mask)
		if (global.debug == true) then
			if (_mask ~= nil) then
				draw_mask_outline(_mask, _obj)
			end

			if (_check == true) then
				draw_sprite_outline(_spr, _obj)
			else
				draw_sheet_outline(_spr, _obj)
			end
		end
	end
	
	local moon_x = -sprite.moon:getWidth() * ratio
	local moon_y = -sprite.moon:getHeight() * ratio
	--

	local logo_y = -100
	local logo_ratio = 0
	local slice_border_w = 0
	--
	if global.win_h > global.win_w then
		slice_border_w = 20
		logo_ratio = global.win_w / (sprite.logo:getWidth() + 15)
	else
		slice_border_w = global.win_w / 2
		logo_ratio = math.ceil(global.win_w / (sprite.logo:getWidth()*2))
	end
	local logo_h = sprite.logo:getHeight() * logo_ratio

	-- Menu text
	local text_start_rotate = 0
	local text_start_alpha = 0
	local text_start_alpha_shadow = 0
	local text_start_size = 0
	local text_start = "Tap to start"
	local text_start_w = font.large:getWidth( text_start )
	local text_start_h = font.large:getHeight( text_start )

	-- Slice
	local slice_speed = 0

	-- Score
	local to_score = 0
	local to_score_spd = 0

	local score_y = -100
	local score_w = font.large:getWidth( global.score ) * .5
	local score_h = font.large:getHeight( global.score ) * .5

	function love.draw()

		do -- Tiles
			-- Stars
			if global.night == false then
				set_bg_color(rgba(31 + (50 - stars_alpha_control), 88 + (50 - stars_alpha_control), 135 + (50 - stars_alpha_control) , 100))
				if global.menu == true then
					stars_alpha_control = lerp(stars_alpha_control, 50, 0.01)
				else
					stars_alpha_control = lerp(stars_alpha_control, 0, 0.01)
				end
				stars_alpha_control = clamp(stars_alpha_control, 0, 100)
				stars_alpha = lerp(stars_alpha, stars_alpha_control, 0.1)
				if stars_alpha_control >= 100 then
					global.night = true
				end

				moon_x = lerp(moon_x, -sprite.moon:getWidth()*ratio, 0.01)
				moon_y = lerp(moon_y, -sprite.moon:getHeight()*ratio, 0.01)
			else
				moon_x = lerp(moon_x, ((-sprite.moon:getWidth()*.5) + 100)*ratio, 0.02)
				moon_y = lerp(moon_y, ((-sprite.moon:getHeight()*.5) + 100)*ratio, 0.02)
			end

			-- Stars BG
			for i=#stars, 1, -1 do
				stars[i]:draw()
			end

			-- Ground
			for i=#grounds, 1, -1 do
				grounds[i]:draw()
			end

			-- Vegs
			for i=#vegs, 1, -1 do
				vegs[i]:draw()
				debug_outline(vegs[i], false, sheets.veg, nil)
			end

			-- Moon
			set_color(rgba(255,255,255,stars_alpha_control))
			draw_sprite(sprite.moon, moon_x, moon_y, 0, ratio, ratio)
			set_color(1, 1, 1, 1)

		end

		do -- Coins
			for i=#coins, 1, -1 do
				coins[i]:draw_strip()
				debug_outline(coins[i], false, sheets.coin, mask.coin)
			end
		end

		do -- Walls
			for i=#walls, 1, -1 do
				walls[i]:draw_self()
				--debug_outline(walls[i], true, sprite.wpcenter, mask.walls)
			end
		end

		do -- Obj
			-- FF (Fox Fun)
			obj_ff:draw_strip()
			obj_ff:cool_quotes()

			-- PLayer
			obj_linda:draw_strip()
			debug_outline(obj_linda, false, sheets.linda, mask.linda)
		end

		do -- Paticls
			for i=#particls, 1, -1 do
				particls[i]:draw()
			end
		end

		do -- GUI
			set_font(font.large)
			if global.score_board == false then
				-- Text Start
				if (global.start == false) then
					text_start_rotate = sin/10
					text_start_size = lerp(text_start_size, ratio, 0.1)
					text_start_alpha_shadow = lerp(text_start_alpha_shadow, 25, 0.1)
					text_start_alpha = lerp(text_start_alpha, 100, 0.1)
				else
					text_start_rotate = text_start_rotate + .5
					text_start_size = lerp(text_start_size, 0, 0.05)
					text_start_alpha_shadow = lerp(text_start_alpha_shadow, 0, 0.1)
					text_start_alpha = lerp(text_start_alpha, 0, 0.1)
				end

				-- Draw text start
				if (text_start_size > 0.1) then
					set_color(rgba(0,0,0,text_start_alpha_shadow))
					draw_text(text_start, global.win_xoffset+5, global.win_yoffset + 235, text_start_rotate, text_start_size, text_start_size, text_start_w*.5, text_start_h*.5)				
					set_color(rgba(255,255,255,text_start_alpha))
					draw_text(text_start, global.win_xoffset, global.win_yoffset + 230, text_start_rotate/2, text_start_size, text_start_size, text_start_w*.5, text_start_h*.5)
				end
			end

			if (global.over == true) and (global.start == false) then
				set_color(rgba(255,255,255,100))
				global.night = false

				-- Score board
				slice_speed = slice_speed + 0.01
				slice_speed = clamp(slice_speed, 0, 1)
				local size = ease_out_elastic(slice_speed)
				local max_w = global.win_w - slice_border_w
				local max_h = math.abs(global.win_h - (global.win_yoffset + global.win_h/3 - score_h))
				local w = size * max_w
				local h = size * max_h
				local x1 = global.win_xoffset
				local y1 = global.win_yoffset
				local x2 = x1 + w
				local y2 = y1 + h

				logo_y = lerp(logo_y, y1 - h, 0.1)
				score_y = lerp(score_y, -(score_h*2), 0.15)

				draw_sclice(sprite.slice, sheets.slice, x1 - w/2, y1 - h/2, x2 - w/2, y2 - h/2, ratio)
				set_font(font.large)
				if (slice_speed >= 0.5) then
					to_score_spd = lerp(to_score_spd, 2, 0.0075)
					to_score = to_score + to_score_spd
					to_score = clamp(to_score, 0, global.score)
					love.graphics.print("score: "..ceil(to_score), x1 - w/2 + 20*ratio, y1 - ((score_h*2) + 10*ratio), 0, ratio, ratio)
					
					if to_score == global.score then
						love.graphics.print("best: "..global.best_score, x1 - w/2 + 20*ratio, y1, 0, ratio, ratio)
					end

					global.score_board = false
					-- save best score
					if global.best_score < global.score then
						global.best_score = global.score
						save_score()
					end
				end
				
			end

			-- Menu
			if (global.menu == true) then
				to_score = 0
				to_score_spd = 0
				slice_speed = 0
				logo_y = lerp(logo_y, logo_h + (logo_h/4), 0.1)
			else
				if (global.over == false) then
					logo_y = lerp(logo_y, -logo_h, 0.1)
				end
			end
			-- draw logo
			if (logo_y > -logo_h/2) then
				draw_sprite(sprite.logo, global.win_xoffset - (sprite.logo:getWidth()*.5)*logo_ratio, logo_y, 0, logo_ratio, logo_ratio)
			end

			-- Text Score
			if (global.menu == false) and (global.over == false) then
				score_y = lerp(score_y, 10+score_h, 0.1)
			end

			-- draw text score
			if (score_y > 0) then
				set_font(font.score)
				score_w = font.large:getWidth( global.score ) * .5
				score_h = font.large:getHeight( global.score ) * .5
				set_color(rgba(0,0,0,25))
				draw_text(global.score, global.win_xoffset + 5, score_y + 5, -sin*.1, fnt_size, fnt_size, score_w, score_h)
				
				set_color(rgba(255,255,255,100))
				draw_text(global.score, global.win_xoffset, score_y, sin*.1, fnt_size, fnt_size, score_w, score_h)
			end
	
			-- debug monitor
			if (global.debug == true) then
				set_font(font.small)
				draw_text("Fps: "..tostring(love.timer.getFPS()), 10, 10)
			
				draw_text("particls: "..#particls, 10, 25)
				draw_text("Walls: "..#walls, 10, 40)
				draw_text("Instances: "..instances, 10, 55)
				draw_text("start: "..tostring(global.start), 10, 70)
				draw_text("over: "..tostring(global.over), 10, 85)
				draw_text("ratio: "..ratio, 10, 100)
				draw_text("global.w: "..global.win_w, 10, 115)
				draw_text("global.h: "..global.win_h, 10, 130)

				local pw = love.graphics.getWidth()
				draw_text("parse w: "..pw, 10, 145)
				local ph = love.graphics.getHeight()
				draw_text("parse h: "..ph, 10, 160)
			end
		end

	end

	--function level_unload() end

end