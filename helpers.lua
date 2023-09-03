local M = {}
M.P = function (v)
   print(vim.inspect(v)) 
    return v
end

M.Loop = function (tbl)
    local result = ""
    for _, v in ipairs(tbl) do
    result = result ..v.. "\n"
    end
    return result
end

M.Command_exists = function (cmd)
    local handle = io.popen('command -v' .. cmd)
    if handle then
        local result = handle:read("*a")
        return result ~= ""
    else
        print(cmd, 'unable to rest command')
        return nil
    end
end

M.hi = function (name)
    print(name)
end

M.dmenu = 'echo "  " | dmenu -m 0 -fn VictorMono:size=17 -nf cyan -nb black -nf cyan -sb black'

return M
