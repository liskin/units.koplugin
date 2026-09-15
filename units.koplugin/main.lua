local Device = require("device")
local InfoMessage = require("ui/widget/infomessage")
local UIManager = require("ui/uimanager")
local WidgetContainer = require("ui/widget/container/widgetcontainer")
local util = require("util")
local xray_units = require("xray_units")
local _ = require("gettext")

local Units = WidgetContainer:extend{
    name = "units",
}

function Units:init()
    if self.document then
        self:addToHighlightDialog()
    end
    if Device:hasClipboard() then
        self.ui.menu:registerToMainMenu(self)
    end
end

local CATEGORIES_EMOJI = {
    length = "📏",
    weight = "⚖",
    temp = "🌡",
    volume = "🥛",
    speed = "🏃",
    area = "🗺",
}

local function convert(text)
    local matches = xray_units.detectMeasurements(text)
    if matches and #matches > 0 then
        local lines = {}
        for _, match in ipairs(matches) do
            local line = CATEGORIES_EMOJI[match.category] .. " " .. match.original .. " = " .. match.converted
            table.insert(lines, line)
        end
        return table.concat(lines, "\n")
    else
        return "Nothing to convert."
    end
end

function Units:addToHighlightDialog()
    self.ui.highlight:addToHighlightDialog("071_units", function(this)
        return {
            text = _("Convert units"),
            callback = function()
                -- 'this' is self.ui.highlight. Do as ReaderHighlight:saveHighlight() does.
                this:highlightFromHoldPos()
                if not this.selected_text  then return end
                local text = util.cleanupSelectedText(text or this.selected_text.text)
                if Device:hasClipboard() then -- let the text to be reused via menu
                    Device.input.setClipboardText(text)
                end

                UIManager:show(InfoMessage:new{ text = convert(text) })
                this:onClose(false)
            end,
        }
    end)
end

function Units:addToMainMenu(menu_items)
    menu_items.qrclipboard = {
        text = _("Convert units from clipboard"),
        callback = function()
            local text = util.cleanupSelectedText(Device.input.getClipboardText())
            UIManager:show(InfoMessage:new{ text = convert(text) })
        end,
    }
end

return Units
