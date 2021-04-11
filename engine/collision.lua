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
