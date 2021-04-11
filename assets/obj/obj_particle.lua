--- Particle
particls = {}
function pt_create_star(_img, _x, _y, _spd, _count)
		local random = math.random
		local cos = math.cos
		local sin = math.sin
		local set_color = love.graphics.setColor
		local draw = love.graphics.draw
		--
		for i = 0, _count do
			local part = {}
			part.destroy = false
			--
			local x = _x
			local y = _y
			local speed = _spd + i*.1
			local xoff, yoff = _img:getDimensions() * .5
			--
			local obj_dir = random(360) * _D2R
			local image_angle = 0
			local angle_spd = random()*.1
			local scale = random() + random(ratio) - 1 --+ ratio/2
			local alpha = 1
			--
			local move_x = 0
			--

			function part:draw()

		    	alpha = alpha - .035

				image_angle = (image_angle + angle_spd)%360

				move_x = global.over == false and global.world_speed or 0

				x = x + speed * cos(obj_dir) - move_x
				y = y + speed * sin(obj_dir)

				set_color(1, 1, 1, alpha)
				draw(_img, x, y, image_angle, scale, scale, xoff, yoff)
				set_color(1, 1, 1, 1)

				if (alpha <= 0) then
					self.destroy = true
					self_destroy(particls)
				end
			end -- draw
			table.insert(particls, part)
		end -- for
end -- func