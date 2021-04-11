obj_ff = object:new(sprite.ff, 0, 0, 0, 0)
local frame = 0

function obj_ff:create()
	
	frame = math.random(10)
	self.x = global.win_w + (32*ratio)
	self.y = global.win_h - (48*ratio)
	self.sprite_sheet = sheets.ff
	self.image_speed = 8/global.fps
end

local go = false
local timer = true
local delay = 0.083
local alarm = 0
local timing = math.random(100)
local ceil = math.ceil
function obj_ff:step()
	if global.menu == false and self.x < global.win_w + 24 then
		animation_loop(self)
		self.x = self.x - ceil(global.world_speed*.5) - 2*ratio
		if (self.x < -(84*ratio)) then
			self.x = global.win_w + (48 * ratio)
		end -- if outside lvl
	end

	if (global.menu == true) then 
		alarm = alarm + delay
		animation_loop(self)

		if (timer == true) then
			if alarm >= timing then
				go = true
				timer = false
			end
		end

		if (go == true) then
			math.randomseed(os.time())
			self.x = self.x - ceil(global.world_speed*.5) - 1*ratio
			if (self.x < -(84*ratio)) then
				self.x = global.win_w + 48

				alarm = 0
				timing = math.random(100)
				frame =  math.random(10)
				timer = true

				go = false
			end -- if outside lvl
		end -- if go
	end -- if global
end -- func

function obj_ff:cool_quotes()
	love.graphics.draw(sprite.db, sheets.db.frames[frame], self.x + (16*ratio), self.y - (94*ratio))
end

table.insert(obj, obj_ff)