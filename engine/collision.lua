-- Collision BOX <-> BOX
function collision_box(box1, box2)
	return box1.x - box1.xoffset < box2.x + box2.xoffset and
		   box1.x + box1.xoffset > box2.x - box2.xoffset and
		   box1.y - box1.yoffset < box2.y + box2.yoffset and
		   box1.y + box1.yoffset > box2.y - box2.yoffset
end

-- Collision BOX <-> BOX using 2 MASKS
function collision_box_mask(box1, box2, mask1, mask2)
	return (box1.x + mask1.x) - mask1.xoffset < (box2.x + mask2.x) + mask2.xoffset and
		   (box1.x + mask1.x) + mask1.xoffset > (box2.x + mask2.x) - mask2.xoffset and
		   (box1.y + mask1.y) - mask1.yoffset < (box2.y + mask2.y) + mask2.yoffset and
		   (box1.y + mask1.y) + mask1.yoffset > (box2.y + mask2.y) - mask2.yoffset
end

-- Collision BOX <-> BOX using 1 MASKS
function collision_box_1mask(box1, box2, mask1)
	return (box1.x + mask1.x) - mask1.xoffset < box2.x + box2.xoffset and
		   (box1.x + mask1.x) + mask1.xoffset > box2.x - box2.xoffset and
		   (box1.y + mask1.y) - mask1.yoffset < box2.y + box2.yoffset and
		   (box1.y + mask1.y) + mask1.yoffset > box2.y - box2.yoffset
end

-- Collision BOX <-> BOX (vsp & hsp)
function collision_box_spd(box1, box2, hsp, vsp)
	return (box1.x + box1.xoffset) + hsp > box2.x - box2.xoffset and
		   (box1.x - box1.xoffset) + hsp < box2.x + box2.xoffset and
           (box1.y + box1.yoffset) + vsp > box2.y - box2.yoffset and
           (box1.y - box1.yoffset) + vsp < box2.y + box2.yoffset
end

-- Collision BOX <-> POINT ratated
function collision_angle_box(px, py, r_x, r_y, r_ox, r_oy, r_w, r_h, r_angle)
	local cos_angle = math.cos(-r_angle)
	local sin_angle = math.sin(-r_angle)
	local diff_px = px - r_x
	local diff_py = py - r_y
    return cos_angle * diff_px - sin_angle * diff_py >= -r_ox        and
     	   cos_angle * diff_px - sin_angle * diff_py <= r_w - r_ox   and
           sin_angle * diff_px + cos_angle * diff_py >= -r_oy        and
           sin_angle * diff_px + cos_angle * diff_py <= r_h - r_oy
end

-- Collision CIRCLE <-> BOX (vsp & hsp)
function collision_circle_rect(_circle, _rect, hsp, vsp)
    local DeltaX = _circle.x - math.max( (_rect.x - _rect.xoffset*_rect.xscale) - hsp, math.min(_circle.x, (_rect.x + _rect.xoffset*_rect.xscale) - hsp ))
    local DeltaY = _circle.y - math.max( (_rect.y - _rect.yoffset*_rect.yscale) - vsp, math.min(_circle.y, (_rect.y + _rect.yoffset*_rect.yscale) - vsp ))
    return (DeltaX^2 + DeltaY^2) < (_circle.r^2)
end

-- Collision CIRCLE <-> CIRCLE
function collision_circle_cirlce(x1, y1, x2, y2, cr, cr2)
	return math.sqrt( (x1 - x2)^2 + (y1 - y2)^2 ) < cr + cr2
end

--- Points
-- Collision BOX <-> POINT
function point_in_box(px, py, box)
	return math.abs(px - box.x) < box.w and
		   math.abs(py - box.y) < box.h
end

-- Collision POINT <-> CIRCLE
function point_in_circle(px, py, cy, cy, cr)
	return math.sqrt( (px - cx)^2 + (py - cy)^2 ) < cr
end