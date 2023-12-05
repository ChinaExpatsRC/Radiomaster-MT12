local hue = 0
local fadeSpeed = 1
local counter = 0

local function init()
end

local function run()
  counter = (counter + 1) % 8 -- Increment the counter and reset at 7

  if counter == 7 then
    for i = 0, LED_STRIP_LENGTH - 1, 1 do
      -- Set the LED color based on the current hue
      local r, g, b = hsvToRgb(hue, 1, 1)
      setRGBLedColor(i, r * 255, g * 255, b * 255)

      -- Increment the hue for the next LED with a smooth fade
      hue = (hue + fadeSpeed) % 360
    end
    applyRGBLedColors()
  end
end

local function background()
  -- Called periodically while the Special Function switch is off
end

-- Helper function to convert HSV to RGB
function hsvToRgb(h, s, v)
  local r, g, b

  local i = math.floor(h / 60) % 6
  local f = h / 60 - i
  local p = v * (1 - s)
  local q = v * (1 - f * s)
  local t = v * (1 - (1 - f) * s)

  if i == 0 then
    r, g, b = v, t, p
  elseif i == 1 then
    r, g, b = q, v, p
  elseif i == 2 then
    r, g, b = p, v, t
  elseif i == 3 then
    r, g, b = p, q, v
  elseif i == 4 then
    r, g, b = t, p, v
  else
    r, g, b = v, p, q
  end

  return r, g, b
end

return { run = run, background = background, init = init }

