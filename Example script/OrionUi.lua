local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local RaelHubMemeSea = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Laelmano24/Meme-Sea/refs/heads/main/AutoFarm.lua')))()

local Window = OrionLib:MakeWindow({Name = "[Name of your script]", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionMemeSea"})

local Main = Window:MakeTab({
  Name = "Main",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})

local AutoFarm = Main:AddSection({
  Name = "Auto farm"
})
AutoFarm:AddDropdown({
  Name = "Fighting style",
  Default = "Melee",
  Options = {"Melee", "Weapons"},
  Callback = function(Value)
    getgenv().EquipStyle = Value
  end
})

Main:AddSlider({
  Name = "Player height",
  Min = 5,
  Max = 15,
  Default = 7,
  Color = Color3.fromRGB(255,255,255),
  Increment = 1,
  ValueName = "PlayerHeight",
  Callback = function(Value)
    getgenv().HeightPlayer = Value
  end
})

Main:AddToggle({
  Name = "Auto farm",
  Default = false,
  Callback = function(Value)
    RaelHubMemeSea.AutoFarm(Value)
  end
})
Main:AddToggle({
  Name = "Auto click",
  Default = false,
  Callback = function(Value)
    RaelHubMemeSea.AutoClicker(Value)
  end
})