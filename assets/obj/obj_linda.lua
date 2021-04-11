-- гг
obj_linda = object:new(sprite.linda, 0, 0, 0, 0)

function obj_linda:create()
	self.image_angle = 0
	self.sprite_index = sprite.linda
	self.sprite_sheet = sheets.linda
	self.image_speed = 8/global.fps

	self.x = global.win_xoffset
	self.y = global.win_yoffset

	self.vspeed = 1
end

function obj_linda:over()
	self.sprite_index = sprite.linda_over
	self.image_index = 1
	self.sprite_sheet = sheets.linda_over
end

function flay()
	if (global.over == false) then
		sound.jump:play()
		obj_linda.vspeed = -(8 + ratio)
	end
end


function obj_linda:step(dt)
	local grav = 25*dt
	animation_loop(self)

	if (global.start == true) then
		function love.mousepressed(x, y, button, istouch)
			if (button == 1) or (istouch == 1) then
				flay()
			end
		end
		function love.keypressed(key, scancode, isrepeat)
		   if key == "space" then
		      flay()
		   end
		end

		self.image_angle = self.image_angle - self.vspeed
		self.image_angle = clamp(self.image_angle, -90, 30)

		self.vspeed = self.vspeed + grav
		self.y = self.y + self.vspeed
		self.y = clamp(self.y, self.yoffset, global.win_h - self.yoffset)

		if global.over == false then
			for i=#walls, 1, -1 do
				if collision_box_1mask(self, walls[i], mask.linda) then
					sound.die:play()
					global.over = true
					self:over()
				end
			end
		end

		if self.y >= global.win_h - self.yoffset - (32*ratio) then
			self:over()
			global.over = true
			global.start = false
			global.score_board = true
			sound.die:play()
		end
		
	end

	if global.menu == true then
		self.y = self.y - sin
	end

end

table.insert(obj, obj_linda)