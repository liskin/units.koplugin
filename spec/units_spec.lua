describe("units", function()
    require("settings")
    local units = require("units")

    it("converts one unit", function()
        local r = units.convert("1 pint", false)
        assert.equals(r, "[volume] 1 pint = 473.18 ml")
    end)

    it("converts multiple units", function()
        local r = units.convert("1 pint; 1 inch", false)
        assert.equals(r, "[volume] 1 pint = 473.18 ml\n[length] 1 inch = 2.54 cm")
    end)
end)
