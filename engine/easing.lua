-- Region ease function
function ease_in_back(t) return t * t * (2.70158 * t - 1.70158) end

-- 1
function ease_in_bounce(t) return math.pow(2, 6 * (t - 1)) * math.abs(math.sin(t * math.pi * 3.5)) end

-- 2
function ease_in_circ(t) return 1 - math.sqrt(math.abs(1 - t)) end

-- 3
function ease_in_cubic(t) return t * t * t end

-- 4
function ease_in_elastic(t)
  local t2 = t * t
  return t2 * t2 * math.sin(t * math.pi * 4.5)
end

-- 5
function ease_in_expo(t) return (math.pow(2, 8 * t) - 1) / 255 end

-- 6
function ease_in_out_back(t)
  if (t < 0.5) then
    return t * t * (7 * t - 2.5) * 2
  else
    local _t = (1-t)
    return 1 + _t * t * 1 * (1 * t)
  end
end

-- 7
function ease_in_out_bounce(t)
  if (t < 0.5) then
    return 8 * math.pow(2, 8 * (t - 1)) * math.abs(math.sin( t * math.pi * 7))
  else
    return 1 - 8 * math.pow(2, -8 * t) * math.abs(math.sin( t * math.pi * 7))
  end
end

-- 8
function ease_in_out_circ(t)
  if (t < 0.5) then
    return (1 - math.sqrt(math.abs(1 - 2 * t))) * 0.5
  else
    return (1 + math.sqrt(math.abs(2 * t - 1))) * 0.5
  end
end

-- 9
function ease_in_out_cubic(t) return t < 0.5 and 4 * t * t * t or 1 - math.pow(-2 * t + 2, 3) / 2 end

-- 10
function ease_in_out_elastic(t)
  if (t < 0.45) then
    t2 = t * t;
    return 8 * t2 * t2 * math.sin(t * math.pi * 9)
  elseif t < 0.55 then
    return 0.5 + 0.75 * math.sin(t * math.pi * 4)
  else
    t2 = (t - 1) * (t - 1)
    return 1 - 8 * t2 * t2 * math.sin(t * math.pi * 9)
  end
end

-- 11
function ease_in_out_expo(t)
  if (t < 0.5) then
    return (math.pow(2, 16 * t) - 1) / 510
  else
    return 1 - 0.5 * math.pow(2, -16 * (t - 0.5))
  end
end

-- 12
function ease_in_out_quad(t) return t < 0.5 and 2 * t * t or t * (4 - 2 * t) - 1 end

-- 13
function ease_in_out_quart(t)
  if(t < 0.5) then
    t = t * t;
    return 8 * t * t
  else
    local _t = t - 1
    t = (_t) * t
    return 1 - 8 * t * t
  end
end

-- 14
function ease_in_out_quint(t)
  if t < 0.5 then
    t2 = t * t
    return 16 * t * t2 * t2
  elseif t > 0.5 then
    local _t = (1 - t)
    t2 = _t * t
    return 1 - 16 * t * t2 * t2
  end
end

-- 15
function ease_in_out_sine(t) return 0.5 * (1 + math.sin(math.pi * (t - 0.5))) end

-- 17
function ease_in_quad(t) return t * t end

-- 18
function ease_in_quart(t)
  t = t * t
  return t * t
end

-- 19
function ease_in_quint(t)
  local t2 = t * t
  return t * t2 * t2
end

-- 20
function ease_in_sine(t) return math.sin((math.pi/2) * t) end

-- 21
function ease_out_back(t)
  local _t = (1 - t) - 1
  return 1 + (_t) * t * (2.70158 * t - math.pi/2);
end

-- 22
function ease_out_bounce(t) return 1 - math.pow(2, -6 * t) * math.abs(math.cos(t * math.pi * 3.5)) end

-- 23
function ease_out_circ(t) return math.sqrt(math.abs(t)) end

-- 24
function ease_out_cubic(t)
  local _t = (1 - t) - 1
  return 1 + (_t) * t * t
end

-- 25
function ease_out_elastic(t)
  local t2 = (t - 1) * (t - 1)
  return 1 - t2 * t2 * math.cos(t * math.pi * 4.5)
end

-- 26
function ease_out_elxpo(t) return 1 - math.pow(2, -8 * t) end

-- 27
function ease_out_quad(t) return t * (2 - t) end

-- 28
function ease_out_quart(t)
  local _t = (1 - t) - 1
  t = (_t) * t;
  return 1 - t * t;
end

-- 29
function ease_out_quint(t)
  local _t = (1 - t) - 1
  local t2 = (_t) * t
  return 1 - t * t2 * t2
end

-- 30
function ease_out_sine(t) return 1 + math.sin((math.pi/2) *  (t-1)) end