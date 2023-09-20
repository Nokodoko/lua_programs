#!/bin/env lua

print(package.path)

local modules = {"dkjson", "socket.http" , "ltn12"}
local json, http, ltn12

for i, module in ipairs( modules ) do
    local ok, required_module = pcall(require, module)
    if not ok then
        print("Could not import module: " .. module)
    else
        if i == 1 then
            json = required_module
        elseif i == 2 then
            http = required_module
        elseif i == 3 then
            ltn12 = required_module
        end
    end
end

local url = 'https://api.chucknorris.io/jokes/random'
local response_body = {}

local _, status_code = http.request{
    url = url,
    sink = ltn12.sink.table(response_body)
}

if status_code ~= 200 then
    print("Status_Code: " .. status_code)
    return
end

response_body = table.concat(response_body)

local jokes, pos, err = json.decode(response_body, 1, nil)
if err then
    print("Status_Code: " .. err)
else
    print(jokes.value)
end

