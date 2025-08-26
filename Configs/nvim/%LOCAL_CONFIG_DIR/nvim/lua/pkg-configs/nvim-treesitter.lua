local ts = require("nvim-treesitter")

function containsValue(tbl, valueToFind)
    for _, value in pairs(tbl) do
        if value == valueToFind then
            return true
        end
    end
    return false
end

ts.setup()

local ensure_installed = {
    "lua",
    "c",
    "cpp",
    "rust",
    "javascript",
    "zig",
    "python"
}
local installed_langs = ts.get_installed()
local missing_langs = {}

for index, value in ipairs(ensure_installed) do
    if not containsValue(installed_langs, value) then
        table.insert(missing_langs, value)
    end
end

if #missing_langs > 0 then
    ts.install(missing_langs, { summary = true })
end
