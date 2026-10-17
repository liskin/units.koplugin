local xray_units = require("xray_units")

local M = {}

local CATEGORIES_EMOJI = {
    length = "📏",
    weight = "⚖",
    temp = "🌡",
    volume = "🫗",
    speed = "🏎",
    area = "🗺",
}

function M.convert(text, has_emoji_font)
    local matches = xray_units.detectMeasurements(text)
    if matches and #matches > 0 then
        local lines = {}
        for _, match in ipairs(matches) do
            local category = has_emoji_font and CATEGORIES_EMOJI[match.category] or "[" .. match.category .. "]"
            local line = category .. " " .. match.original .. " = " .. match.converted
            table.insert(lines, line)
        end
        return table.concat(lines, "\n")
    else
        return "Nothing to convert."
    end
end

return M
