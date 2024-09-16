function atl_server_messages.send_next_message()
    local message = atl_server_messages.messages_list[atl_server_messages.message_index]
    minetest.chat_send_all(minetest.colorize(atl_server_messages.messages_color, message))

    atl_server_messages.message_index = atl_server_messages.message_index + 1
    if atl_server_messages.message_index > #atl_server_messages.messages_list then
        atl_server_messages.message_index = 1
    end
end

function atl_server_messages.start_timer()
    if atl_server_messages.messages_timer < 30 then
        minetest.log("error", "atl_server_messages.messages_timer cannot be less than 30 seconds. (Spam Reason)")
        return
    end

    minetest.after(atl_server_messages.messages_timer, function()
        if minetest.get_connected_players() and #minetest.get_connected_players() > 0 then
            atl_server_messages.send_next_message()
            atl_server_messages.start_timer()
        end
    end)
end

function atl_server_messages.stop_timer()
    minetest.clear_after()
end