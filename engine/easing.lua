-- 25
function ease_out_elastic(t)
  local t2 = (t - 1) * (t - 1)
  return 1 - t2 * t2 * math.cos(t * math.pi * 4.5)
end
