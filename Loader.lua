--///////////////////////////////////////////////////

-- Created by wasundefined
-- Yes I used ChatGPT to configure some stuff lol
-- Enjoy

--///////////////////////////////////////////////////

-- Misc
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Essentials
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local localPlayer = players.LocalPlayer

-- Function to add highlight to a player
local function addHighlight(player)
    if player.Character then
        if not player.Character:FindFirstChild("Highlight") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = player.Character
            highlight.FillColor = Color3.new(1, 0, 0) -- Red for enemy
            highlight.OutlineColor = Color3.new(1, 1, 1) -- White
        end
    end
end

-- Function to remove highlight from a player
local function removeHighlight(player)
    if player.Character and player.Character:FindFirstChild("Highlight") then
        player.Character.Highlight:Destroy()
    end
end

local connections = {}
local toggleState = false
local enemyToggleState = false

-- Function to update highlights for everyone
local function updateHighlights()
    for _, player in ipairs(players:GetPlayers()) do
        if player ~= localPlayer then
            addHighlight(player)
        end

        -- Listen for character respawns
        if not connections[player] then
            connections[player] = player.CharacterAdded:Connect(function()
                if toggleState then
                    addHighlight(player)
                end
            end)
        end
    end
end

-- Function to update highlights for enemies (opposite team)
local function updateEnemyHighlights()
    for _, player in ipairs(players:GetPlayers()) do
        if player.Team ~= localPlayer.Team then  -- Check if they are on the opposite team
            addHighlight(player)
        end

        -- Listen for character respawns
        if not connections[player] then
            connections[player] = player.CharacterAdded:Connect(function()
                if enemyToggleState then
                    addHighlight(player)
                end
            end)
        end
    end
end

-- Cleanup function for connections
local function cleanConnections()
    for player, conn in pairs(connections) do
        if conn then
            conn:Disconnect()
        end
        connections[player] = nil
    end
end

--///////////////////////////////////////////////////

-- Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Main Window
local Window = OrionLib:MakeWindow({Name = "Legacy | by wasundefined", HidePremium = false, SaveConfig = true, IntroText = "Legacy", ConfigFolder = "OrionTest"})

-- Main Tab
local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://170940873",
	PremiumOnly = false
})

local Section = Main:AddSection({
	Name = "Information"
})

Main:AddParagraph("Message from wasundefined","Hi, Legacy is a script that contains a bunch of other scripts for most of the games on Roblox and it also has bunch of extra universal stuff in it.")
Main:AddParagraph("What is Legacy for?","Its mainly for easy access to everything. I created a single script that contains bunch of scripts and features to easily access them from a single script and before you ask, yes I skidded a bunch of stuff to put in here and easily acces them. I guess you can call me a loser but yeah, I hope you enjoy it.")
Main:AddParagraph("Discord: wasundefined","If you have a script that you want it to be included in Legacy, you can send them to me via discord.")

local Section = Main:AddSection({
	Name = "Miscellaneous"
})

Main:AddButton({
	Name = "Re-Execute Legacy",
	Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/wasundefined/Legacy/refs/heads/main/Loader.lua'))()
  	end    
})

-- Player Tab
local Player = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://12823489098",
	PremiumOnly = false
})

local Section = Player:AddSection({
	Name = "Utilites"
})

Player:AddButton({
	Name = "Fly [ X ]",
	Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/wasundefined/Legacy/refs/heads/main/Essentials/Fly.lua'))()
  	end    
})

Player:AddButton({
	Name = "NoClip [ Z ]",
	Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/wasundefined/Legacy/refs/heads/main/Essentials/NoClip.lua'))()
  	end    
})

Player:AddButton({
	Name = "Click Teleport [ CTRL + LCLICK ]",
	Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/wasundefined/Legacy/refs/heads/main/Essentials/ClickTP.lua'))()
  	end    
})

Player:AddButton({
	Name = "Infinite Jump",
	Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/wasundefined/Legacy/refs/heads/main/Essentials/Infinite%20Jump.lua'))()
  	end    
})

Player:AddButton({
	Name = "Wall Walk",
	Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/wasundefined/Legacy/refs/heads/main/Essentials/Wall%20Walk.lua'))()
  	end    
})

Player:AddToggle({
	Name = "Anti AFK",
	Default = false,
	Callback = function(antiafk1)
		print("1", antiafk1)
		if antiafk1 then
			-- Start
			while antiafk1 do
				antiafkfc()
				wait(2) -- Repeat every 2 seconds
			end
		end
	end    
})

local Section = Player:AddSection({
	Name = "Modifiers"
})

Player:AddSlider({
	Name = "WalkSpeed Changer",
	Min = 16,
	Max = 1000,
	Default = 16,
	Color = Color3.fromRGB(60,60,60),
	Increment = 1,
	ValueName = "WalkSpeed",
	Callback = function(ws1)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = ws1
	end    
})

Player:AddSlider({
	Name = "JumpPower Changer",
	Min = 50,
	Max = 1000,
	Default = 50,
	Color = Color3.fromRGB(60,60,60),
	Increment = 1,
	ValueName = "JumpPower",
	Callback = function(jp1)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = jp1
	end    
})

-- Visuals Tab
local Visuals = Window:MakeTab({
	Name = "Visuals",
	Icon = "rbxassetid://13321848320",
	PremiumOnly = false
})

local Section = Visuals:AddSection({
	Name = "Box ESP"
})

Visuals:AddToggle({
	Name = "Box ESP [ ENEMY ]",
	Default = false,
	Callback = function(Value)
		_G.BoxESP = Value
	end    
})

Visuals:AddToggle({
	Name = "Box ESP [ EVERYONE ]",
	Default = false,
	Callback = function(Value)
		_G.BoxESP2 = Value
	end    
})

local Section = Visuals:AddSection({
	Name = "Highlight ESP"
})

Visuals:AddToggle({
	Name = "Highlight ESP [ EVERYONE ]",
	Default = false,
	Callback = function(Value)
        toggleState = Value
        if Value then
            -- Add highlights to all players
            updateHighlights()

            -- Listen for new players joining
            connections["PlayerAdded"] = players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Wait()
                if toggleState then
                    addHighlight(player)
                end
            end)
        else
            -- Remove all highlights and cleanup
            for _, player in ipairs(players:GetPlayers()) do
                removeHighlight(player)
            end
            cleanConnections()
        end
    end    
})

Visuals:AddToggle({
    Name = "Highlight ESP [ ENEMY ]",
    Default = false,
    Callback = function(Value)
        enemyToggleState = Value
        if Value then
            -- Add highlights to enemies
            updateEnemyHighlights()

            -- Listen for new players joining
            connections["PlayerAdded"] = players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Wait()
                if enemyToggleState and player.Team ~= localPlayer.Team then
                    addHighlight(player)
                end
            end)
        else
            -- Remove all enemy highlights and cleanup
            for _, player in ipairs(players:GetPlayers()) do
                if player.Team ~= localPlayer.Team then
                    removeHighlight(player)
                end
            end
            cleanConnections()
        end
    end    
})

local Section = Visuals:AddSection({
	Name = "FOV"
})

Visuals:AddSlider({
	Name = "Field Of View",
	Min = 0,
	Max = 120,
	Default = 80,
	Color = Color3.fromRGB(60,60,60),
	Increment = 1,
	ValueName = "FOV",
	Callback = function(FOV1)
		game.Workspace.Camera.FieldOfView = FOV1
	end    
})

-- Game Tab
local Game = Window:MakeTab({
	Name = "Game",
	Icon = "rbxassetid://96996641562298",
	PremiumOnly = false
})

local Section = Game:AddSection({
	Name = "Miscellaneous"
})

Game:AddButton({
	Name = "ReJoin",
	Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/wasundefined/Legacy/refs/heads/main/Essentials/ReJoin.lua'))()
  	end    
})

Game:AddButton({
	Name = "Hop Server",
	Callback = function()
        local Http = game:GetService("HttpService") local TPS = game:GetService("TeleportService") local Api = "https://games.roblox.com/v1/games/" local _place = game.PlaceId local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100" function ListServers(cursor) local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or "")) return Http:JSONDecode(Raw) end local Server, Next; repeat local Servers = ListServers(Next) Server = Servers.data[1] Next = Servers.nextPageCursor until Server TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
  	end    
})

-- Useful Scripts Tab
local US = Window:MakeTab({
	Name = "Useful Scripts",
	Icon = "rbxassetid://7414445494",
	PremiumOnly = false
})

local Section = US:AddSection({
	Name = "Scripts"
})

US:AddButton({
	Name = "Chat Spoofer",
	Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/wasundefined/Legacy/refs/heads/main/Scripts/Chat%20Spoofer.lua'))()
  	end    
})

US:AddButton({
	Name = "Chat Bypasser",
	Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/keSD0xcp'))()
  	end    
})

US:AddButton({
	Name = "Anti AFK",
	Callback = function()
        loadstring(game:HttpGet('loadstring(game:HttpGet("https://raw.githubusercontent.com/luca5432/Roblox-ANTI-AFK-SCRIPT/refs/heads/main/Script"))()'))()
  	end    
})

-- Game Scripts Tab
local GS = Window:MakeTab({
	Name = "Game Scripts",
	Icon = "rbxassetid://12684121161",
	PremiumOnly = false
})

local Section = GS:AddSection({
	Name = "Blade Ball Scripts"
})

GS:AddButton({
	Name = "Blade Ball - Auto Parry",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/begula-mqc/Benware/refs/heads/main/benhub"))()
  	end    
})



-- Extra Scripts

-- Box ESP Configuration
_G.BoxESP = false

function BoxESP()
    local lplr = game.Players.LocalPlayer
    local camera = game:GetService("Workspace").CurrentCamera
    local CurrentCamera = workspace.CurrentCamera
    local worldToViewportPoint = CurrentCamera.worldToViewportPoint

    local HeadOff = Vector3.new(0, 0.5, 0)
    local LegOff = Vector3.new(0, 3, 0)

    local function createBoxESP(v)
        local BoxOutline = Drawing.new("Square")
        BoxOutline.Visible = false
        BoxOutline.Color = Color3.new(0, 0, 0)
        BoxOutline.Thickness = 2
        BoxOutline.Transparency = 1
        BoxOutline.Filled = false

        local Box = Drawing.new("Square")
        Box.Visible = false
        Box.Color = Color3.new(1, 1, 1)
        Box.Thickness = 1
        Box.Transparency = 1
        Box.Filled = false

        -- Function to handle box drawing
        local function boxesp()
            game:GetService("RunService").RenderStepped:Connect(function()
                if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                    local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                    local RootPart = v.Character.HumanoidRootPart
                    local Head = v.Character.Head
                    local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                    local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
                    local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

                    if onScreen then
                        BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                        BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)

                        Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                        Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)

                        if v.TeamColor == lplr.TeamColor then
                            BoxOutline.Visible = false
                            Box.Visible = false
                        else
                            -- Check the value of _G.BoxESP to control visibility
                            if _G.BoxESP then
                                BoxOutline.Visible = true
                                Box.Visible = true
                            else
                                BoxOutline.Visible = false
                                Box.Visible = false
                            end
                        end
                    else
                        BoxOutline.Visible = false
                        Box.Visible = false
                    end
                else
                    BoxOutline.Visible = false
                    Box.Visible = false
                end
            end)
        end

        coroutine.wrap(boxesp)()
    end

    -- This will be called when a new player joins
    game.Players.PlayerAdded:Connect(function(v)
        createBoxESP(v)

        -- If the player already has a character, we add the ESP box immediately
        if v.Character then
            createBoxESP(v)
        end
    end)

    -- Initializing the ESP boxes for players already in the game
    for _, v in pairs(game.Players:GetChildren()) do
        createBoxESP(v)
    end
end

BoxESP()

-- BoxESP2 Configuration
_G.BoxESP2 = false

function BoxESP2()
    local lplr = game.Players.LocalPlayer
    local camera = game:GetService("Workspace").CurrentCamera
    local CurrentCamera = workspace.CurrentCamera
    local worldToViewportPoint = CurrentCamera.worldToViewportPoint

    local HeadOff = Vector3.new(0, 0.5, 0)
    local LegOff = Vector3.new(0, 3, 0)

    local function createBoxESP(v)
        local BoxOutline = Drawing.new("Square")
        BoxOutline.Visible = false
        BoxOutline.Color = Color3.new(0, 0, 0)
        BoxOutline.Thickness = 2
        BoxOutline.Transparency = 1
        BoxOutline.Filled = false

        local Box = Drawing.new("Square")
        Box.Visible = false
        Box.Color = Color3.new(1, 1, 1)
        Box.Thickness = 1
        Box.Transparency = 1
        Box.Filled = false

        -- Function to handle box drawing
        local function boxesp2()
            game:GetService("RunService").RenderStepped:Connect(function()
                if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                    local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                    local RootPart = v.Character.HumanoidRootPart
                    local Head = v.Character.Head
                    local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                    local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
                    local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

                    if onScreen then
                        BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                        BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)

                        Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                        Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)

                        -- Check visibility condition for Box ESP
                        if _G.BoxESP2 then
                            BoxOutline.Visible = true
                            Box.Visible = true
                        else
                            BoxOutline.Visible = false
                            Box.Visible = false
                        end
                    else
                        BoxOutline.Visible = false
                        Box.Visible = false
                    end
                else
                    BoxOutline.Visible = false
                    Box.Visible = false
                end
            end)
        end

        coroutine.wrap(boxesp2)()
    end

    -- This will be called when a new player joins
    game.Players.PlayerAdded:Connect(function(v)
        createBoxESP(v)

        -- If the player already has a character, we add the ESP box immediately
        if v.Character then
            createBoxESP(v)
        end
    end)

    -- Initializing the ESP boxes for players already in the game
    for _, v in pairs(game.Players:GetChildren()) do
        createBoxESP(v)
    end
end

BoxESP2()

-- Function for anti afk
local function antiafkfc()
	local mouseLocation = UserInputService:GetMouseLocation()
	local inputObject = Instance.new("InputObject")
	inputObject.UserInputType = Enum.UserInputType.MouseButton2
	inputObject.Position = mouseLocation

	UserInputService.InputBegan:Fire(inputObject, false)
end

--///////////////////////////////////////////////////
