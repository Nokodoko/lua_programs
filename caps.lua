#!/bin/env lua

local status_ok, h = pcall(require, "helpers")
if not status_ok then
    return
end

local t = {}

local function xset()
   local command = io.popen('xset q')
    if not command then
        Check(1, "Could not run xset command")
    else
        local output = command:read("*all")
        local state = string.match(output, "Caps Lock:%s*(%a*)")
        if state == "on" then
            table.insert(t, state)
            h.check(1, "Caps Lock is On!!")
            return nil
        else
            os.exit(0, true)
        end
    end
end

xset()
