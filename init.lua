local modname = "atl_server_messages"
-- Traduction
local S = minetest.get_translator(modname)
-- Configuration des messages
local messages_timer = 180  -- Temps en secondes (note: doit etre au moins 30 sec pour eviter le spam)
local messages_color = "grey"
local message_index = 1

local messages_list = {
    S("Welcome to the server, please respect the rules established there."),
    S("Any form of nuisance, spam, insult and other is prohibited."),
    S("Please respect the players on the server and their administrator."),
    S("Enjoy your time on the server and have fun!"),
    S("If you have any questions, feel free to ask the moderators."),
    S("Remember to report any issues or bugs you encounter."),
    S("Be kind and helpful to new players."),
    S("Cheating and hacking are strictly forbidden and will result in a ban."),
    S("Respect the privacy and personal information of other players."),
    S("Use appropriate language and avoid offensive content."),
    S("Do not share personal or sensitive information on the server."),
    S("Follow the instructions given by the server staff."),
    S("Participate in server events and activities to enhance your experience."),
    S("Help maintain a positive and friendly atmosphere on the server."),
    S("Thank you for being a part of our community!")
}

local function send_next_message()
    local message = messages_list[message_index]
    minetest.chat_send_all(minetest.colorize(messages_color, message))

    message_index = message_index + 1
    if message_index > #messages_list then
        message_index = 1
    end
end

local function start_timer()
    if messages_timer < 30 then
        minetest.log("error", "messages_timer ne peut pas être inférieur à 30 secondes (pour éviter le spam)")
        return
    end

    minetest.after(messages_timer, function()
        if #minetest.get_connected_players() > 0 then
            send_next_message()
            start_timer()
        end
    end)
end

local function stop_timer()
    minetest.clear_after()
end

minetest.register_on_joinplayer(function(player)
    if #minetest.get_connected_players() <= 1 then
        start_timer()
    end
end)

minetest.register_on_leaveplayer(function(player)
    if #minetest.get_connected_players() == 0 then
        stop_timer()
    end
end)
