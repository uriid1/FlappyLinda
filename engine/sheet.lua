-- Cut Sprite sheet
function cut_sheet(_spr, _sheetW, _sheetH, _num, _x, _y)
	--
	local sheet = {}
	sheet.sprite = _spr

	local w = _spr:getWidth()*ratio or 0
	local h = _spr:getHeight()*ratio or 0

	sheet.image_number = _num
	--
	sheet.frame_w = _sheetW*ratio
	sheet.frame_h = _sheetH*ratio
	sheet.frame_xoffset = (_sheetW*ratio) * .5
	sheet.frame_yoffset = (_sheetH*ratio) * .5
	-- 
	local quad = love.graphics.newQuad
	local __x = _x or _num
	local __y = _y or _num
	
	sheet.frames = {}
	for x = 0, __x - 1 do
		for y = 0, __y -1 do
	   		table.insert(sheet.frames,
	   			quad(y * sheet.frame_w, x * sheet.frame_h, sheet.frame_w, sheet.frame_h, w, h)
	   		)
	   	end
	end

	return sheet
end


function cut_sclice(_spr, _sheetW, _sheetH, _num, _x, _y)
	--
	local sheet = {}
	sheet.sprite = _spr

	local w = _spr:getWidth() or 0
	local h = _spr:getHeight() or 0

	sheet.image_number = _num
	--
	sheet.frame_w = _sheetW
	sheet.frame_h = _sheetH
	sheet.frame_xoffset = _sheetW * .5
	sheet.frame_yoffset = _sheetH * .5
	-- 
	local quad = love.graphics.newQuad
	local __x = _x or _num
	local __y = _y or _num
	
	sheet.frames = {}
	for x = 0, __x - 1 do
		for y = 0, __y -1 do
	   		table.insert(sheet.frames,
	   			quad(y * sheet.frame_w, x * sheet.frame_h, sheet.frame_w, sheet.frame_h, w, h)
	   		)
	   	end
	end

	return sheet
end

