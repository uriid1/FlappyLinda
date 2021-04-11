
function self_destroy(_tname)
	for i=#_tname, 1, -1 do
		if _tname[i].destroy then
			instance_destroy(_tname, i)
		end
	end
end

local wpcenter_w = sprite.wpcenter:getWidth()
local wall_dist = 180 * ratio
local wall_dist_up_max = global.win_h - (wall_dist + (96*ratio))
local wall_up_count_max = math.ceil(wall_dist_up_max / (32*ratio))
function create_wall()
	math.randomseed(os.time())

	-- Wall UP
	local wall_up = {}
	wall_up.destroy = false
	wall_up.count = math.random(4, wall_up_count_max)
	--
	wall_up.w = wpcenter_w * ratio
	wall_up.h = wall_up.count * wall_up.w
	--
	wall_up.xoffset = wall_up.w * .5
	wall_up.yoffset = wall_up.h * .5
	--
	wall_up.x = global.win_w + (64*ratio)
	wall_up.y = wall_up.yoffset

	local rand_add = {}
	for i = 1, wall_up.count - 1 do
		rand_add[i] = math.random(9)
	end

	function wall_up:draw_self()
		for i = 0, self.count - 1 do
			-- up
			if (i == 0) then love.graphics.draw(sprite.wpdown, self.x + self.xoffset, self.y - self.yoffset + self.w,  math.rad(180), ratio, ratio) end
			-- center
			if (i ~= 0 and i ~= self.count - 1) then
				love.graphics.draw(sprite.wpcenter, self.x - self.xoffset, self.y - self.yoffset + i*self.w, 0, ratio, ratio)
			end
			-- down
			if (i == self.count - 1) then love.graphics.draw(sprite.wpdown, self.x + self.xoffset, self.y + self.yoffset - self.w,  0, -ratio, ratio) end

			-- wall add
			local frames = i%9
			if frames == 0 then frames = 1 end
			if (i ~= self.count - 1) then
				love.graphics.draw(sprite.wadd, sheets.wadd.frames[rand_add[frames]], self.x - self.w, self.y - self.yoffset + (16*ratio)+(32*ratio)*i, math.rad(270), 1, 1, 16*ratio, 16*ratio)
			end
		end

		-- Debug
		if (global.debug == true) then
			love.graphics.rectangle("line", self.x - self.xoffset, self.y - self.yoffset, self.w, self.h)
		end
	end

	function wall_up:step()
		if (global.over ~= true) then
			self.x = self.x - global.world_speed
		end

		if (self.x + self.xoffset < 0) then
			self.destroy = true
			self_destroy(walls)
		end
	end
	table.insert(walls, wall_up)

	-- Wall Down
	local wall_down = {}
	local py = wall_up.y + wall_up.yoffset + wall_dist - (8*ratio)
	local wall_down_dist_max = global.win_h - py
	local wall_down_count_max = round(wall_down_dist_max / (32*ratio))

	wall_down.destroy = false
	wall_down.count = wall_down_count_max
	--
	wall_down.w = wpcenter_w * ratio
	wall_down.h = wall_down.count * wall_down.w
	--
	wall_down.xoffset = wall_down.w * .5
	wall_down.yoffset = wall_down.h * .5
	--
	wall_down.x = global.win_w + (64*ratio)
	wall_down.y = py + wall_down.yoffset --wall_up.h + wall_down.yoffset + wall_dist

	local rand_add = {}
	for i = 1, wall_down.count - 1 do
		rand_add[i] = math.random(9)
	end

	function wall_down:draw_self()
		for i = 0, self.count - 1 do
			-- up
			if (i == 0) then love.graphics.draw(sprite.wpdown, self.x + self.xoffset, self.y - self.yoffset + self.w,  math.rad(180), ratio, ratio) end
			-- center
			if (i ~= 0 and i ~= self.count - 1) then
				love.graphics.draw(sprite.wpcenter, self.x - self.xoffset, self.y - self.yoffset + i*self.w, 0, ratio, ratio)
			end
			-- down
			if (i == self.count - 1) then love.graphics.draw(sprite.wpdown, self.x + self.xoffset, self.y + self.yoffset - self.w,  0, -ratio, ratio) end

			-- wall add
			local frames = i%9
			if frames == 0 then frames = 1 end
			if (i ~= self.count - 1) then
				love.graphics.draw(sprite.wadd, sheets.wadd.frames[rand_add[frames]], self.x - self.w, self.y - self.yoffset + (16*ratio)+(32*ratio)*i, math.rad(270), 1, 1, 16*ratio, 16*ratio)
			end
		end

		-- Debug
		if (global.debug == true) then
			love.graphics.rectangle("line", self.x - self.xoffset, self.y - self.yoffset, self.w, self.h)
		end
	end

	function wall_down:step()
		if (global.over ~= true) then
			self.x = self.x - global.world_speed
		end

		if (self.x + self.xoffset < 0) then
			self.destroy = true
			self_destroy(walls)
		end
	end
	table.insert(walls, wall_down)


	do -- Coin
		for y = 0, 5 do
			local coin = object:new(sprite.coin, 0, 0, 0, 0)
			coin.sprite_sheet = sheets.coin
			coin.image_speed = (9/global.fps)
			coin.image_index = y%sheets.coin.image_number == 0 and 1 or y
			coin.direction = 180

			coin.x = wall_up.x - 3*ratio
			coin.y = (wall_up.y + wall_up.yoffset + mask.coin.w + 10) + y*(25*ratio)
			function coin:step()
				self:move()
				if global.over then
					self.speed = 0
				end
				animation_loop(self)

				-- Collision
				if (global.over == false) then
					self.speed = global.world_speed
					if collision_box_mask(self, obj_linda, mask.coin, mask.linda) then
						sound.money:play()
						self.destroy = true
						stars_alpha_control = stars_alpha_control + (5*ratio) + (global.score*.1)

						global.score = global.score + 1

						fnt_size = 0.5 + ratio
						pt_create_star(sprite.star_particle, self.x, self.y, 1, 5)
						self_destroy(coins)
					end
				else
					self.speed = 0
				end

				-- Outside room
				if (self.x + self.xoffset < 0) then
					self.destroy = true
					self_destroy(coins)
				end
			end -- func

			table.insert(coins, coin)
		end -- for
	end

end

wall_control = {}
local delay = 0.08

local alarm = 0
function wall_control:step()

	if global.start == true and global.over == false then
		alarm = alarm + delay

		if (alarm >= 10) then
			create_wall()
			alarm = 0
		end
	end

end

table.insert(obj, wall_control)