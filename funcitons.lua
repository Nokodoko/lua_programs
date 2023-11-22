function edit()
    local tmpfile = os.getenv("TMPDIR") or "/tmp"
    tmpfile = tmpfile .. "/insta_script_" .. os.time() .. ".lua"
    os.execute("nvim " .. tmpfile)
    local file = io.open(tmpfile, 'r')
    if file then
        local handler = file:read("*a")
        file:close()
        os.remove(tmpfile)
        local chunk, error_message = load(handler)
        if chunk then
            return chunk()
        else
            error(error_message)
        end
    else
        error("Could not find the tmp file")
    end
end

