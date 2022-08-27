local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Clicker Frenzy by Ammu", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})


local remotesfolder = game.ReplicatedStorage["Game Objects"].Remotes
local opencaseremote = remotesfolder["Open Case"] -- remotefunction
local sellremote = remotesfolder["Sell"]


local s = game.Players.LocalPlayer.PlayerGui["Game GUI"]["Client Controller"]
local senv = getsenv(s)
local getpasscode = getupvalues(senv.moduleDict.get)[3] -- raw function, AC stripped lol (moduleDict.get.internal1)

local connection = game.Players.LocalPlayer.PlayerGui["Game GUI"]["New Theme"]["Menu Frames"]["Case Win"].Item.Actions.Spin.MouseButton1Click
local spincase = getupvalue(getconnections(connection)[1].Function, 2)

local stat = game.Players.LocalPlayer.leaderstats["Case Bux"]
local startval = stat.Value
local endval = 0
local breakCaseOpening = false;
local continousSelling = false;
local targetPlayer = "";
local stopAnnoy = false;
local stopTeleportFun = false;

function addcomma(num)
    local newstr = ""
    local str = string.split(string.reverse(tostring(num)), "")
    
    for i = 1, #str do
        newstr = newstr .. str[i]
        if i % 3 == 0 and i ~= #str then
            newstr = newstr .. ","
        end
    end
    
    return string.reverse(newstr)
end

function endresults(startval, endval)
    local rate = endval / startval
    rate = math.floor(rate * 100) -- move decimal place, remove extra
    
    print("Before: $" .. addcomma(startval) .. " After: $" .. addcomma(endval))
    print("Profits rate: " .. tostring(rate) .. "%")
end

_G.othershit = getupvalue(spincase, 8)
if not _G.setup then
    _G.passcode = nil -- auto updates
    
    local origfunc
    origfunc = hookfunction(getpasscode, function(unk)
        _G.passcode = origfunc(unk)
        return _G.passcode
    end)
    
    _G.setup = true
end

function opencase(casetype)
    print("Opening...")
    local a, b, c, d = opencaseremote:InvokeServer(
        _G.othershit,
        _G.passcode,
        casetype,
        true
    )
end

function changePlayerSpeed(num)
    local Client = game.Players.LocalPlayer
 	local Character = Client.Character or Client.CharacterAdded:Wait()
 	local Humanoid = Character.Humanoid
    Humanoid.WalkSpeed = num    
end


function changePlayerJumpPower(num)
    local Client = game.Players.LocalPlayer
 	local Character = Client.Character or Client.CharacterAdded:Wait()
 	local Humanoid = Character.Humanoid
    Humanoid.JumpPower = num    
end






















local CasesTab = Window:MakeTab({
	Name = "Cases",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local inventoryTab = Window:MakeTab({
	Name = "Inventory",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local uiTab = Window:MakeTab({
	Name = "UI Unlocks",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local MovementTab = Window:MakeTab({
	Name = "Movements",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
	
local teleportTab = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

function getPlayerNames() 
    local Players = game:GetService("Players")
    local playerInGame = {};
    for _, player in pairs(Players:GetPlayers()) do
    	table.insert(playerInGame,player.Name)
    end   
    return playerInGame
end

function openCases (type) 
    while wait(0.001) do
    	        if breakCaseOpening then 
    	            breakCaseOpening = false
    	            break 
    	        end 
	            spawn(function()
    	                local a, b, c, d = opencaseremote:InvokeServer(
                        _G.othershit,
                        _G.passcode,
                        type,
                        true
                    )
                    
	            end)
				if continousSelling then
					sellremote:FireServer(
						_G.othershit,
						_G.passcode,
						"All"
					)
				end
    	    end    
end


function teleportToPlayer(name)
    local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local HumRoot = Character:WaitForChild("HumanoidRootPart")
    local targetPosition = CFrame.new(6.53019094, 83.5324783, -118.816605, -0.16761826, -2.7051843e-09, 0.985852003, -1.25734907e-08, 1, 6.06214634e-10, -0.985852003, -1.2293988e-08, -0.16761826)
    for _, player in pairs(game.Players:GetPlayers()) do
    	if(player.Name == targetPlayer) then
    	    repeat
    	        targetPosition = player.Character:WaitForChild("HumanoidRootPart").CFrame
    	        Character:SetPrimaryPartCFrame(targetPosition)
    	        wait(0.0001)
    	    until (stopAnnoy)  
    	end
    end    
end


teleportTab:AddDropdown({
	Name = "Players",
	Default = "1",
	Options = getPlayerNames(),
	Callback = function(Value)	
	    targetPlayer = Value
	end    
})	

teleportTab:AddButton({
	Name = "Annoy Player",
	Callback = function(Value)
	    stopAnnoy=false
	    teleportToPlayer(targetPlayer)
	end
})
teleportTab:AddButton({
	Name = "Stop Annoying Player",
	Callback = function(Value)
	    stopAnnoy = true
	end
})

function teleportToPillarTop()
    local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local HumRoot = Character:WaitForChild("HumanoidRootPart")
    local targetPosition = CFrame.new(-21.8308773, 111.808342, -91.2692032, 0.00790419336, -2.60008886e-08, -0.999968767, -4.91700831e-08, 1, -2.63903637e-08, 0.999968767, 4.93771424e-08, 0.00790419336)
    Character:SetPrimaryPartCFrame(targetPosition)
end

function teleportToRoofTop()
    local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local HumRoot = Character:WaitForChild("HumanoidRootPart")
    local targetPosition = CFrame.new(76.962944, 122.746635, -99.2149734, 0.0610461272, -4.72949235e-09, 0.998134971, 7.6494e-10, 1, 4.69154582e-09, -0.998134971, 4.77112683e-10, 0.0610461272)
    Character:SetPrimaryPartCFrame(targetPosition)
end

function teleportToSideWallTop()
    local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local HumRoot = Character:WaitForChild("HumanoidRootPart")
    local targetPosition = CFrame.new(-9.89273167, 130.223404, 7.33558416, 0.998966396, 1.33034623e-08, -0.0454544351, -1.44995065e-08, 1, -2.59833399e-08, 0.0454544351, 2.66155507e-08, 0.998966396)
    Character:SetPrimaryPartCFrame(targetPosition)
end

teleportTab:AddButton({
	Name = "Teleport to Pillar top",
	Callback = function(Value)
	    teleportToPillarTop()
	end
})
teleportTab:AddButton({
	Name = "Teleport to Roof top",
	Callback = function(Value)
	    teleportToRoofTop()
	end
})
teleportTab:AddButton({
	Name = "Teleport to Side Wall top",
	Callback = function(Value)
	    teleportToSideWallTop()
	end
})
teleportTab:AddButton({
	Name = "Teleport Fun",
	Callback = function(Value)
	    stopTeleportFun = false
	    repeat 
    	    teleportToRoofTop()
    	    wait(0.6)
    	    teleportToSideWallTop()
    	    wait(0.6)
    	    teleportToPillarTop()
    	    wait(0.6)
    	until(stopTeleportFun)
	end
})
teleportTab:AddButton({
	Name = "Stop Teleport Fun",
	Callback = function(Value)
	    stopTeleportFun = true
	end
})

MovementTab:AddSlider({
	Name = "Speed Increase",
	Min = 16,
	Max = 100,
	Default = 16,
	Increment = 10,
	ValueName = "walk speed",
	Callback = function(Value)
		changePlayerSpeed(Value)
	end    
})

MovementTab:AddSlider({
	Name = "Jumb Power",
	Min = 30,
	Max = 100,
	Default = 30,
	Increment = 10,
	ValueName = "jumb power",
	Callback = function(Value)
		changePlayerJumpPower(Value)
	end    
})

CasesTab:AddButton({
	Name = "Open Common Cases",
	Callback = function(Value)
	    while wait(0.001) do
    	        if breakCaseOpening then 
    	            print("exiting loop")
    	            breakCaseOpening = false
    	            break 
    	        end 
	            spawn(function()
    	                local a, b, c, d = opencaseremote:InvokeServer(
                        _G.othershit,
                        _G.passcode,
                        "Common",
                        true
                    )
                    
	            end)
				if continousSelling then
					sellremote:FireServer(
						_G.othershit,
						_G.passcode,
						"All"
					)
				end
    	    end
	end
})

CasesTab:AddButton({
	Name = "Open Uncommon Cases",
	Callback = function(Value)
	    while wait(0.001) do
    	        if breakCaseOpening then 
    	            print("exiting loop")
    	            breakCaseOpening = false
    	            break 
    	        end 
	            spawn(function()
    	                local a, b, c, d = opencaseremote:InvokeServer(
                        _G.othershit,
                        _G.passcode,
                        "Uncommon",
                        true
                    )
                    
	            end)
				if continousSelling then
					sellremote:FireServer(
						_G.othershit,
						_G.passcode,
						"All"
					)
				end
    	    end
	end
})

CasesTab:AddButton({
	Name = "Open Rare Cases",
	Callback = function(Value)
	    while wait(0.001) do
    	        if breakCaseOpening then 
    	            print("exiting loop")
    	            breakCaseOpening = false
    	            break 
    	        end 
	            spawn(function()
    	                local a, b, c, d = opencaseremote:InvokeServer(
                        _G.othershit,
                        _G.passcode,
                        "Rare",
                        true
                    )
                    
	            end)
				if continousSelling then
					sellremote:FireServer(
						_G.othershit,
						_G.passcode,
						"All"
					)
				end
    	    end
	end
})

CasesTab:AddButton({
	Name = "Open Epic Cases",
	Callback = function(Value)
	    while wait(0.001) do
    	        if breakCaseOpening then 
    	            print("exiting loop")
    	            breakCaseOpening = false
    	            break 
    	        end 
	            spawn(function()
    	                local a, b, c, d = opencaseremote:InvokeServer(
                        _G.othershit,
                        _G.passcode,
                        "Epic",
                        true
                    )
                    
	            end)
				if continousSelling then
					sellremote:FireServer(
						_G.othershit,
						_G.passcode,
						"All"
					)
				end
    	    end
	end
})

uiTab:AddButton({
	Name = "Open 1B Area",
	Callback = function(Value)
        workspace.Doors:Destroy();
	end
})


uiTab:AddButton({
	Name = "Open Premium Hangout Area",
	Callback = function(Value)
        workspace.GamePassDoor:Destroy();
	end
})



CasesTab:AddButton({
	Name = "Open God Cases",
    	Callback = function(Value)
    	    while wait(0.001) do
    	        if breakCaseOpening then 
    	            print("exiting loop")
    	            breakCaseOpening = false
    	            break 
    	        end 
	            spawn(function()
    	                local a, b, c, d = opencaseremote:InvokeServer(
                        _G.othershit,
                        _G.passcode,
                        "God",
                        true
                    )
                    
	            end)
				if continousSelling then
					sellremote:FireServer(
						_G.othershit,
						_G.passcode,
						"All"
					)
				end
    	    end
	    end
})

CasesTab:AddButton({
	Name = "Stop opening Cases",
    	Callback = function(Value)
    	    print("Stopping to open cases")
    	    breakCaseOpening = true;
	    end
})

CasesTab:AddButton({
	Name = "Sell Everything for CASE BUX",
    	Callback = function(Value)
    	    local a, b, c, d = sellremote:FireServer(
                _G.othershit,
                _G.passcode,
                "All"
            )
	    end
})

OrionLib:MakeNotification({
	Name = "Welcome!",
	Content = "Clicker Frenzy is ready to be exploited",
	Image = "rbxassetid://4483345998",
	Time = 5
})

inventoryTab:AddParagraph("Delete/Sell","Please select from the below list, the type of items you want to sell")
inventoryTab:AddDropdown({
	Name = "Type to sell",
	Default = "1",
	Options = {"all", "common", "uncommon","epic", "legendory"},
	Callback = function(Value)
		print(Value)
	end    
})

inventoryTab:AddToggle({
	Name = "Sell Items Continously",
	Default = false,
	Callback = function(Value)
		continousSelling = Value
	end    
})





Tab:AddButton({
	Name = "Button!",
	Callback = function()
      		print("button pressed")
  	end    
})
Tab:AddToggle({
	Name = "This is a toggle!",
	Default = false,
	Callback = function(Value)
		print(Value)
	end    
})
Tab:AddColorpicker({
	Name = "Colorpicker",
	Default = Color3.fromRGB(255, 0, 0),
	Callback = function(Value)
		print(Value)
	end	  
})
-- ColorPicker:Set(Color3.fromRGB(255,255,255))
Tab:AddSlider({
	Name = "Slider",
	Min = 0,
	Max = 20,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "bananas",
	Callback = function(Value)
		print(Value)
	end    
})

 --Slider:Set(2)
 Tab:AddLabel("Label")
--CoolLabel:Set("Label New!")
Tab:AddParagraph("Paragraph","Paragraph Content")
-- CoolParagraph:Set("Paragraph New!")

Tab:AddTextbox({
	Name = "Textbox",
	Default = "default box input",
	TextDisappear = true,
	Callback = function(Value)
		print(Value)
	end	  
})


Tab:AddBind({
	Name = "Bind",
	Default = Enum.KeyCode.E,
	Hold = false,
	Callback = function()
		print("press")
	end    
})
-- Bind:Set(Enum.KeyCode.E)
Tab:AddDropdown({
	Name = "Dropdown",
	Default = "1",
	Options = {"1", "2"},
	Callback = function(Value)
		print(Value)
	end    
})
-- Dropdown:Refresh(List<table>,true)
--Dropdown:Set("dropdown option")
OrionLib:Init()
-- destroying the interface: OrionLib:Destroy()
