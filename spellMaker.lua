#!/bin/env lua

local status_ok, h = pcall(require, "helpers")
if not status_ok then
    return
end

local parser = function (input)
   os.execute('nvim /home/n0ko/programming/lua_projects/'..input..'.lua')
end

local function spell()
    local handle = io.popen(h.dmenu)
    if not handle then
        print("Could not read dmneu prompt")
        return 1
    else
        local result = handle:read("*a")
        result = string.gsub(result, "\n", "")
        handle:close()
        return result
    end
end

parser( spell() )
