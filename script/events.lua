minetest.register_on_joinplayer(function(player)
    if #minetest.get_connected_players() <= 1 then
        atl_server_messages.start_timer()
    end
end)

minetest.register_on_leaveplayer(function(player)
    if #minetest.get_connected_players() == 0 then
        atl_server_messages.stop_timer()
    end
end)