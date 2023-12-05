local function init()
    larson_position = 0
    larson_direction = 1  -- 1 for forward, -1 for backward
end

local function run()
    local red_intensity = 255
    local off_intensity = 0
    local on_time = 10  -- Time in seconds for each LED to be on
    local off_time = 10  -- Time in seconds for each LED to be off

    for i = 0, LED_STRIP_LENGTH - 1, 1 do
        local intensity = off_intensity

        if i == larson_position then
            intensity = red_intensity
        end

        setRGBLedColor(i, intensity, 0, 0)
    end

    applyRGBLedColors()
    sleep(on_time)

    for i = 0, LED_STRIP_LENGTH - 1, 1 do
        setRGBLedColor(i, 0, 0, 0)
    end

    applyRGBLedColors()
    sleep(off_time)

    larson_position = larson_position + larson_direction

    if larson_position == LED_STRIP_LENGTH - 1 or larson_position == 0 then
        larson_direction = -larson_direction  -- Reverse direction at the ends
    end
end

local function background()
    -- Called periodically while the Special Function switch is off
end

-- Function to pause execution for a given amount of time
function sleep(seconds)
    local start_time = getTime()
    while getTime() - start_time < seconds do
        -- Do nothing, just wait
    end
end

return { run = run, background = background, init = init }

