local M = {
	_data = {
		dimension_units = "metric",
	}
}

function M:readSetting(s)
	return M._data[s]
end

_G.G_reader_settings = M
return M
