-- Конструктор основных объектов
object = {}
object.__index = object;
function object:new(_spr, _x, _y, _dir, _spd)
	
	-- init
	local obj = setmetatable({}, self);
	instances = instances + 1
	obj.index = instances

	-- Свойства взаимодействия
	obj.x = _x
	obj.y = _y
	obj.xstart = _x
	obj.ystart = _y
	obj.speed = _spd
	obj.direction = _dir
	obj.hspeed = 0
	obj.vspeed = 0
	obj.destroy = false

	-- Drawing
	obj.sprite_index = _spr
	obj.w, obj.h = _spr:getDimensions()
	obj.xoffset = obj.w * .5
	obj.yoffset = obj.h * .5
	obj.image_angle = 0
	obj.image_alpha = 1
	obj.xscale = 1
	obj.yscale = 1
	obj.blend = {1, 1, 1, self.image_alpha}

	-- Anim
	obj.image_index = 1
	obj.image_speed = 0
	obj.sprite_sheet = obj.sprite_sheet or nil
	obj.animation_end = false
	obj.stripping = false

	return obj

end -- func


-- Step
local cos = math.cos
local sin = math.sin
function object:move()
	if (self.speed ~= 0) then
		local dir = self.direction * _D2R
		self.hspeed = self.speed * cos(dir)
		self.vspeed = self.speed * sin(dir)
		self.x = self.x + self.hspeed
		self.y = self.y + self.vspeed
	end
end

-- Sprite draw
local draw = love.graphics.draw
local set_color = love.graphics.setColor
function object:draw_self()
	set_color(self.blend)
	draw(self.sprite_index, self.x, self.y, self.image_angle * _D2R, self.xscale, self.yscale, self.xoffset, self.yoffset)
end

-- Sheet draw
function object:draw_strip()
	if (self.stripping == false) then
		self.xoffset = self.sprite_sheet.frame_xoffset
		self.yoffset = self.sprite_sheet.frame_yoffset
		self.w = self.sprite_sheet.w
		self.h = self.sprite_sheet.h
		stripping = true
	end
	set_color(1, 1, 1, self.image_alpha)
	draw(self.sprite_index, self.sprite_sheet.frames[math.floor(self.image_index)], self.x, self.y, self.image_angle * _D2R, self.xscale, self.yscale, self.sprite_sheet.frame_xoffset, self.sprite_sheet.frame_yoffset)
end
