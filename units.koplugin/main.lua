local Device = require("device")
local InfoMessage = require("ui/widget/infomessage")
local UIManager = require("ui/uimanager")
local WidgetContainer = require("ui/widget/container/widgetcontainer")
local util = require("util")
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

                -- TODO: convert

                UIManager:show(InfoMessage:new{ text = text })
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

            -- TODO: convert

            UIManager:show(InfoMessage:new{ text = text })
        end,
    }
end

return Units
