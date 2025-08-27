local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})

function dumpTable(t, indent_level)
    indent_level = indent_level or 0
    local indent = string.rep("  ", indent_level) -- Two spaces per indent level

    if type(t) ~= "table" then
        print(indent .. tostring(t))
        return
    end

    print(indent .. "{")
    for k, v in pairs(t) do
        print(indent .. "  [" .. tostring(k) .. "] = ")
        if type(v) == "table" then
            dumpTable(v, indent_level + 1)
        else
            print(tostring(v))
        end
    end
    print(indent .. "}")
end

-- Package update/build hooks
local packages_group = augroup("PackageUpdates", { clear = true })
autocmd("PackChanged", {
    pattern = "*",
    callback = function(ev)
        local kind = ev.data.kind
        local spec = ev.data.spec
        local path = ev.data.path
        print(spec.data.build)

        if not (kind == "install" or kind == "update") then
            return
        end

        local on_exit = function(obj)
            if not obj.code == 0 then
                vim.notify("Failed to run build command!\n" .. obj.stdout .. "\n" .. obj.stderr)
            end
        end

        vim.schedule(function()
            vim.system(spec.data.build, { cwd = path }, on_exit)
        end)

        vim.notify(path .. " was " .. kind)
    end,
    group = packages_group
})
