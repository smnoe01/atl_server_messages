atl_server_messages = {}
atl_server_messages.modpath = minetest.get_modpath("atl_server_messages")
atl_server_messages.messages_timer = 300 -- 5 minutes | Min 30 For avoid spam
atl_server_messages.messages_color = "#32bc39" -- Green
atl_server_messages.message_index = 1

function atl_server_messages.load_file(path)
    local status, err = pcall(dofile, path)
    if not status then
        minetest.log("error", "-!- Failed to load file: " .. path .. " - Error: " .. err)
    else
        minetest.log("action", "-!- Successfully loaded file: " .. path)
    end
end

if atl_server_messages.modpath then
    local files_to_load = {
        "script/api.lua",
        "script/messages_list.lua",
        "script/events.lua",
    }

    for _, file in ipairs(files_to_load) do
        atl_server_messages.load_file(atl_server_messages.modpath .. "/" .. file)
    end
else
    minetest.log("error", "-!- Files in " .. atl_server_messages.modpath .. " mod are not set or valid.")
end
