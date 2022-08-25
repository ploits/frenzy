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

CasesTab:AddButton({
	Name = "Open Common Cases",
	Callback = function(Value)
	    while true 
	        do
	            opencase("Common")
	    end
	end
})

CasesTab:AddButton({
	Name = "Open Uncommon Cases",
	Callback = function(Value)
	    while true 
	        do
	            opencase("Uncommon")
	    end
	end
})

CasesTab:AddButton({
	Name = "Open Rare Cases",
	Callback = function(Value)
	    while true 
	        do
	            opencase("Rare")
	    end
	end
})

CasesTab:AddButton({
	Name = "Open Epic Cases",
	Callback = function(Value)
	    while wait(0.5) do
	            spawn(opencase("Epic"))
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
