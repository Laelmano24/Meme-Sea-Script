local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local RaelHubMemeSea = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Laelmano24/Meme-Sea/refs/heads/main/AutoFarm.lua')))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
  Title = "[Name of your script]",
  SubTitle = "",
  TabWidth = 160,
  Size = UDim2.fromOffset(500, 320),
  Acrylic = true,
  Theme = "Darker",
  MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
  Main = Window:AddTab({ Title = "Main", Icon = "main" }),
  Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Tabs.Main:AddSection("Auto farm")

Tabs.Main:AddDropdown("Fighting style", {
  Title = "Fighting style",
  Values = {"Melee", "Weapons"},
  Multi = false,
  Default = "Melee",
  Callback = function(Value)
    
    getgenv().EquipStyle = Value
    
  end
})

Tabs.Main:AddSlider("Player height", {
  Title = "Player height",
  Description = "",
  Default = 7,
  Min = 5,
  Max = 15,
  Rounding = 7,
  Callback = function(Value)
    getgenv().HeightPlayer = Value
  end
})

Tabs.Main:AddToggle("Auto farm", {
  Title = "Auto farm", 
  Default = false,
  Callback= function(Value)
    
    RaelHubMemeSea.AutoFarm(Value)
    
  end
})

Tabs.Main:AddToggle("Auto click", {
  Title = "Auto click", 
  Default = false,
  Callback= function(Value)
    
    RaelHubMemeSea.AutoClicker(Value)
    
  end
})

InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)

Window:SelectTab(1)