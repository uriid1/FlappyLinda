-- lvl 0
-- Это костыль для решения проблемы с почетом высоты устройств.
levels[0] = function()
		
	-- load res
	local spr_micro = love.graphics.newImage("assets/spr/spr_loading.png")
	spr_micro:setFilter('nearest', 'nearest')

	-- debug resolution
	local i = 0
	local debug_lvl = false
	function love.update()
		i = i + 1
		if i >= 10 then debug_lvl = true end 

		if (debug_lvl == true) then
			require "resource"
			level = 1
			levels[level]()
		end
	end

	local fnt_small = love.graphics.newFont('assets/fnt/fnt_gamer.ttf', 30)
	function love.draw()
		-- Parse screen resolution
		global.win_w = love.graphics.getWidth()
		global.win_h = love.graphics.getHeight()
		global.win_xoffset = global.win_w*.5
		global.win_yoffset = global.win_h*.5

		-- Parse Img main loadind
		local w_offset = spr_micro:getWidth() * .5
		local h_offset = spr_micro:getHeight() * .5
		
		local sx = math.ceil(global.win_w / (spr_micro:getWidth()+20) )

		local mw = spr_micro:getWidth() * sx
		local mh = spr_micro:getHeight() * sx

		love.graphics.setBackgroundColor(hex("68386cff"))
		love.graphics.draw(spr_micro, global.win_xoffset - mw/2, global.win_yoffset - mh/2, 0, sx, sx)
		love.graphics.setFont(fnt_small)
		love.graphics.print("Loading...", 25, global.win_h - 50)
	end

end