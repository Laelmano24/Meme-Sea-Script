local RaelHubMemeSea = {}
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local PlayerGui = LocalPlayer.PlayerGui
local CharacterPlayer = workpace.Character
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local QuestScreen = PlayerGui.QuestGui.Holder.QuestSlot1
local ScreenGuiBossTime = workspace.Leaderboard.Time.Model.ScoreBlock.SurfaceGui
local QuestLocaion = workspace.Location.QuestLocaion
local QuestsNpc = workspace.NPCs.Quests_Npc
local Monsters = workspace.Monster

getgenv().EquipStyle = "Melee" -- or Weapons
getgenv().MonsterName = ""
getgenv().NpcQuest = ""
getgenv().HeightPlayer = 7
getgenv().RaelHubGetLevel = true
getgenv().RaelHubAutoFarm = false
getgenv().RaelHubAutoFarmSelected = false
getgenv().RaelHubAutoFarmBossSelected = false
getgenv().AutoMemeBeast = false
getgenv().RaelHubAutoClicker = false
getgenv().RaelHubAutoClickCat = false
getgenv().ActiveCheckDistance = true
getgenv().GetQuestValue = true
getgenv().AutoRollFruitMoney = false
getgenv().AutoRollFruitGem = false
getgenv().DelayRollFruit = 1
getgenv().AutoAimBot = false
getgenv().PlayerAimBot = CharacterPlayer:GetChildren()[1].HumanoidRootPart.Position
-- Auto Farm

local GetFightingStyle = loadstring(game:HttpGet("https://raw.githubusercontent.com/Laelmano24/Meme-Sea/refs/heads/main/Equip%20Style.lua"))()

local GetListMonsters = loadstring(game:HttpGet("https://raw.githubusercontent.com/Laelmano24/Meme-Sea/refs/heads/main/MemeSea%20Monsters%20List.lua"))()
local GetListQuest = loadstring(game:HttpGet("https://raw.githubusercontent.com/Laelmano24/Meme-Sea-Script/refs/heads/main/GetListQuest.lua"))()


LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
end)

_G.MonitorSkill = nil

_G.MonitorSkill = hookmetamethod(game, "__namecall", function(self, ...)
  local args = {...}
  local method = getnamecallmethod()
    
  if method == "FireServer" and tostring(self) == "Server_Skills" and getgenv().AutoAimBot then
    if args[5] and type(args[5]) == "table" then
      if args[5]["Hit_Position"] then
        args[5]["Hit_Position"] = getgenv().PlayerAimBot
      elseif args[5]["Mouse_Position"] then
        args[5]["Mouse_Position"] = getgenv().PlayerAimBot
      end
    end
  end

  return _G.MonitorSkill(self, unpack(args))
end)

function RaelHubMemeSea.GetLevelAndQuest(value)
  
  getgenv().RaelHubGetLevel = value
  
  task.spawn(function()
    while getgenv().RaelHubGetLevel and getgenv().RaelHubAutoFarmSelected == false do
  
      local QuestFloppas = PlayerGui.GameGui.Compass.Main.Container.Quest.Container
  
      local function GetNumberFromString(text)
    
      local numero = text:match("%d+")
        return tonumber(numero)
      end
  
      for _, FloppasQuest in ipairs(QuestFloppas:GetChildren()) do
        local Trackframe = FloppasQuest:FindFirstChild("TrackFrame")
    
        if Trackframe then
          local recommended = Trackframe.Track.Recommended
      
          if recommended and recommended.Visible then
            local Number =  GetNumberFromString(FloppasQuest.Name)
        
            for i, valor in ipairs(GetListMonsters) do
              if tostring(Number) == "23" or tostring(Number) == "29" or tostring(Number) == "32" then
              
                local NewNumber = Number - 1
              
                local NewFloppaQuest = "Floppa Quest " .. NewNumber
              
                if i == NewNumber then
                
                  getgenv().MonsterName = valor
                  getgenv().NpcQuest = NewFloppaQuest
                  break
                end
              else
                if i == Number then
                  getgenv().MonsterName = valor
                  getgenv().NpcQuest = FloppasQuest.Name
                  break
                end
              end
            end
            break
          end
        end
      end
      task.wait(2)
    end
  end)
end

function CheckQuest()
  local questgiver = QuestScreen:FindFirstChild("QuestGiver")
  if questgiver and QuestScreen.Visible and questgiver.Text == getgenv().NpcQuest then
    return true
  else
    if questgiver and QuestScreen.Visible and questgiver.Text ~= getgenv().NpcQuest then
      task.wait(0.3)
      local args = {
        [1] = "Abandon_Quest",
        [2] = {
          ["QuestSlot"] = "QuestSlot1"
        }
      }

      game:GetService("ReplicatedStorage").OtherEvent.QuestEvents.Quest:FireServer(unpack(args))
    end
    return false
  end
end

function GetQuest(npcquest)
  while getgenv().RaelHubAutoFarm and not CheckQuest() do
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and QuestsNpc:FindFirstChild(npcquest) then
      Character:MoveTo(QuestLocaion[npcquest].Position)
      task.wait()
      if QuestsNpc:FindFirstChild(npcquest) then
        fireproximityprompt(QuestsNpc[npcquest].Block.QuestPrompt)
      end
    end
    task.wait()
  end
end

function TeleportToMonster(monster)
  while monster.Parent and getgenv().RaelHubAutoFarm and CheckQuest() do
    if monster then
      local HumanoidRootPart = monster:FindFirstChild("HumanoidRootPart")
      if HumanoidRootPart then
        local position = HumanoidRootPart.Position
        local altura = position + Vector3.new(0, getgenv().HeightPlayer, 0)
        local rotation = Vector3.new(-90, 0, 180)

        if Character and Character:FindFirstChild("HumanoidRootPart") then
          Character.HumanoidRootPart.CFrame = CFrame.new(altura) * CFrame.Angles(math.rad(rotation.X), math.rad(rotation.Y), math.rad(rotation.Z))
        end
      end
      task.wait()
    end
  end
end

function CheckDistance()
  
 local humanoidrootpart = Character:FindFirstChild("HumanoidRootPart")
  local MonsterPart = workspace.Location.Enemy_Location:FindFirstChild(getgenv().MonsterName)
  
  if MonsterPart and humanoidrootpart then
    local PlayerPosition = humanoidrootpart.Position
    local MonsterPosition = MonsterPart.Position
    
    local Distance = (PlayerPosition - MonsterPosition).Magnitude
    
    if Distance >= 500 and getgenv().ActiveCheckDistance then
      humanoidrootpart.CFrame = CFrame.new(MonsterPosition)
    end
  end
end

function Function_EquipStyle()
  local BackPack = LocalPlayer:FindFirstChild("Backpack")
  local Humanoid = Character:FindFirstChild("Humanoid")
  if BackPack and Humanoid then
    if getgenv().EquipStyle == "Weapons" then
      for _, Style in ipairs(GetFightingStyle.weapons()) do
        local Tool = BackPack:FindFirstChild(Style)
        if Tool then
          Humanoid:EquipTool(Tool)
        end
      end
    elseif getgenv().EquipStyle == "Melee" then
      
      for _, Style in ipairs(GetFightingStyle.melee()) do
        local Tool = BackPack:FindFirstChild(Style)
        if Tool then
          Humanoid:EquipTool(Tool)
        end
      end
    end
  end
end

function RaelHubMemeSea.AutoFarm(value)
  
  getgenv().RaelHubAutoFarm = value
  
  task.spawn(function()
    while getgenv().RaelHubAutoFarm do
      CheckDistance()
      Function_EquipStyle()
      task.wait()
    end
  end)
 
  task.spawn(function()
    while getgenv().RaelHubAutoFarm do
      GetQuest(getgenv().NpcQuest)
      for _, Monster in ipairs(Monsters:GetChildren()) do
        if Monster.Name == getgenv().MonsterName then
          TeleportToMonster(Monster)
        end
      end
      task.wait()
    end
  end)
end

function RaelHubMemeSea.AutoClicker(value)
  
  function autoClick()
    VirtualUser:CaptureController()
    VirtualUser:Button1Down(Vector2.new(1e4, 1e4))
    task.wait(0.05)
  end
  
  getgenv().RaelHubAutoClicker = value
  
  task.spawn(function()
    while getgenv().RaelHubAutoClicker do
      autoClick()
    end
  end)
end

RaelHubMemeSea.GetLevelAndQuest(false)

-- Auto farm with the selected monster

function GetQuestSelected(npcquest)
  while getgenv().RaelHubAutoFarmSelected and getgenv().GetQuestValue and not CheckQuest() do
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and QuestsNpc:FindFirstChild(npcquest) then
      Character:MoveTo(QuestLocaion[npcquest].Position)
      task.wait()
      if QuestsNpc:FindFirstChild(npcquest) then
        fireproximityprompt(QuestsNpc[npcquest].Block.QuestPrompt)
      end
    end
    task.wait()
  end
end

function TeleportToMonsterSelected(monster)
  while monster.Parent and getgenv().RaelHubAutoFarmSelected do
    if monster then
      local HumanoidRootPart = monster:FindFirstChild("HumanoidRootPart")
      if HumanoidRootPart then
        local position = HumanoidRootPart.Position
        local altura = position + Vector3.new(0, getgenv().HeightPlayer, 0)
        local rotation = Vector3.new(-90, 0, 180)

        if Character and Character:FindFirstChild("HumanoidRootPart") then
          Character.HumanoidRootPart.CFrame = CFrame.new(altura) * CFrame.Angles(math.rad(rotation.X), math.rad(rotation.Y), math.rad(rotation.Z))
        end
      end
      task.wait()
    end
  end
end

function RaelHubMemeSea.AutoFarmMonsterSelected(monster, value)
  getgenv().RaelHubAutoFarmSelected = value
  task.spawn(function()
    while getgenv().RaelHubAutoFarmSelected do
      for indexMonster, ValueMonster in ipairs(GetListMonsters or {}) do
        if ValueMonster == monster then
          for indexQuest, ValueQuest in ipairs(GetListQuest or {}) do
            if indexMonster == indexQuest then
              getgenv().MonsterName = ValueMonster
              getgenv().NpcQuest = ValueQuest
              task.spawn(function()
                while getgenv().RaelHubAutoFarmSelected do
                  Function_EquipStyle()
                  CheckDistance()
                  task.wait()
                end
              end)

              GetQuestSelected(getgenv().NpcQuest)

              for _, Monstro in ipairs(Monsters:GetChildren()) do
                if Monstro and Monstro.Name == ValueMonster then
                  TeleportToMonsterSelected(Monstro)
                  break
                end
              end
              break
            end
          end
          break
        end
      end
      task.wait()
    end
  end)
end
-- Auto farm boss summmon selected

function GetQuestBossSelected(npcquest)
  while getgenv().RaelHubAutoFarmBossSelected and not CheckQuest() do
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and QuestsNpc:FindFirstChild(npcquest) then
      Character:MoveTo(QuestLocaion[npcquest].Position)
      task.wait()
      if QuestsNpc:FindFirstChild(npcquest) then
        fireproximityprompt(QuestsNpc[npcquest].Block.QuestPrompt)
      end
    end
    task.wait()
  end
end

function TeleportToBossSelected(monster)
  pcall(function()
  while monster.Parent and getgenv().RaelHubAutoFarmBossSelected and CheckQuest() do
    if monster then
      local HumanoidRootPart = monster:FindFirstChild("HumanoidRootPart")
      if HumanoidRootPart then
        local position = HumanoidRootPart.Position
        local altura = position + Vector3.new(0, getgenv().HeightPlayer, 0)
        local rotation = Vector3.new(-90, 0, 180)

        if Character and Character:FindFirstChild("HumanoidRootPart") then
          Character.HumanoidRootPart.CFrame = CFrame.new(altura) * CFrame.Angles(math.rad(rotation.X), math.rad(rotation.Y), math.rad(rotation.Z))
        end
      end
      task.wait()
    end
  end
  end)
end

function CheckItemSummon(item)
  local ItemSummon = LocalPlayer.Items.ItemStorage:FindFirstChild(item)
  if ItemSummon and ItemSummon.Value == 0 then
  
  
    if item == "Sussy Orb" then
      getgenv().MonsterName = "Sus Duck"
      getgenv().NpcQuest = "Floppa Quest 31"
      
      GetQuestBossSelected(getgenv().NpcQuest)
      for _, Monster in ipairs(Monsters:GetChildren()) do
        if Monster.Name == "Sus Duck" then
          TeleportToBossSelected(Monster)
          local BossLordSusText = ScreenGuiBossTime["Lord Sus"].Text
          if ItemSummon.Value > 0 then
            break
          elseif BossLordSusText:find("✅") then
            break
          end
        end
      end
      
      
    elseif item == "Flame Orb" then
      getgenv().MonsterName = "Scary Skull"
      getgenv().NpcQuest = "Floppa Quest 22"
      
      GetQuestBossSelected(getgenv().NpcQuest)
      for _, Monster in ipairs(Monsters:GetChildren()) do
        if Monster.Name == "Scary Skull" then
          TeleportToBossSelected(Monster)
          local BossGiantPumpkinText = ScreenGuiBossTime["Giant Pumpkin"].Text

          if ItemSummon.Value > 0 then
            break
          elseif BossGiantPumpkinText:find("✅") then
            break
          end
        end
      end
      
      
      
    elseif item == "Noob Head" then
      getgenv().MonsterName = "Moai"
      getgenv().NpcQuest = "Floppa Quest 28"
      
      GetQuestBossSelected(getgenv().NpcQuest)
      for _, Monster in ipairs(Monsters:GetChildren()) do
        if Monster.Name == "Moai" then
          TeleportToBossSelected(Monster)
          local BossEvilNoobText = ScreenGuiBossTime["Evil Noob"].Text
          if ItemSummon.Value > 0 then
            break
          elseif BossEvilNoobText:find("✅") then
            break
          end
        end
      end
    end
      
  elseif ItemSummon and ItemSummon.Value > 0 then
  
  
    if item == "Sussy Orb" then
      local Summon = workspace.Island.ForgottenIsland.Summon3.Summon
      local humanoidrootpart = Character:FindFirstChild("HumanoidRootPart")
      if humanoidrootpart then
        humanoidrootpart.CFrame = CFrame.new(Summon.Position)
        task.wait(0.5)
        fireproximityprompt(Summon.SummonPrompt)
        return true
      end
      
      
      
    elseif item == "Flame Orb" then
      local Summon = workspace.Island.PumpkinIsland.Summon1.Summon
      local humanoidrootpart = Character:FindFirstChild("HumanoidRootPart")
      if humanoidrootpart then
        humanoidrootpart.CFrame = CFrame.new(Summon.Position)
        task.wait(0.5)
        fireproximityprompt(Summon.SummonPrompt)
        return true
      end
      
      
    elseif item == "Noob Head" then
      getgenv().ActiveCheckDistance = false
      local Summon = workspace.Island.MoaiIsland.Summon2.Summon
      local humanoidrootpart = Character:FindFirstChild("HumanoidRootPart")
      if humanoidrootpart then
        humanoidrootpart.CFrame = CFrame.new(Summon.Position)
        task.wait(0.5)
        fireproximityprompt(Summon.SummonPrompt)
        task.wait(0.3)
        getgenv().ActiveCheckDistance = true
        return true
      end
    end
  end
end

function CheckBossLordSus()
  local BossLordSusText = ScreenGuiBossTime["Lord Sus"].Text
  local BossModel = Monsters:FindFirstChild("Lord Sus")
  
  if BossLordSusText:find("✅") then
    getgenv().MonsterName = "Lord Sus"
    getgenv().NpcQuest = "Floppa Quest 32"
    GetQuestBossSelected(getgenv().NpcQuest)
    if BossModel then
      TeleportToBossSelected(BossModel)
    end
  else
    local FunctionCheck = CheckItemSummon("Sussy Orb")
    if FunctionCheck then
      
      getgenv().MonsterName = "Lord Sus"
      getgenv().NpcQuest = "Floppa Quest 32"
      GetQuestBossSelected(getgenv().NpcQuest)
      if BossModel then
        TeleportToBossSelected(BossModel)
      end
    end
  end
end

function CheckBossPumpkin()
  local BossPumpkinText = ScreenGuiBossTime["Giant Pumpkin"].Text
  local BossModel = Monsters:FindFirstChild("Giant Pumpkin")
  if BossPumpkinText:find("✅") then
    getgenv().MonsterName = "Giant Pumpkin"
    getgenv().NpcQuest = "Floppa Quest 23"
    GetQuestBossSelected(getgenv().NpcQuest)
    if BossModel then
      TeleportToBossSelected(BossModel)
    end
  else
    local FunctionCheck = CheckItemSummon("Flame Orb")
    if FunctionCheck then
      
      getgenv().MonsterName = "Giant Pumpkin"
      getgenv().NpcQuest = "Floppa Quest 23"
      GetQuestBossSelected(getgenv().NpcQuest)
      if BossModel then
        TeleportToBossSelected(BossModel)
      end
    end
  end
end

function CheckBossEvilNoob()
  
  local BossEvilNoobText = ScreenGuiBossTime["Evil Noob"].Text
  local BossModel = Monsters:FindFirstChild("Evil Noob")
  if BossEvilNoobText:find("✅") then
    getgenv().MonsterName = "Evil Noob"
    getgenv().NpcQuest = "Floppa Quest 29"
    GetQuestBossSelected(getgenv().NpcQuest)
    if BossModel then
      TeleportToBossSelected(BossModel)
    end
  else
    local FunctionCheck = CheckItemSummon("Noob Head")
    if FunctionCheck then
      
      getgenv().MonsterName = "Evil Noob"
      getgenv().NpcQuest = "Floppa Quest 29"
      GetQuestBossSelected(getgenv().NpcQuest)
      if BossModel then
        TeleportToBossSelected(BossModel)
      end
    end
  end
end

function RaelHubMemeSea.AutoFarmBoss(boss, value)
  
  getgenv().RaelHubAutoFarmBossSelected = value
  task.spawn(function()
    while getgenv().RaelHubAutoFarmBossSelected do
      Function_EquipStyle()
      CheckDistance()
      task.wait()
    end
  end)
  while getgenv().RaelHubAutoFarmBossSelected do
    if boss == "Lord Sus" then
      CheckBossLordSus()
    elseif boss == "Giant Pumpkin" then
      CheckBossPumpkin()
    elseif boss == "Evil Noob" then
      CheckBossEvilNoob()
    end
    task.wait()
  end
  
end
-- Auto click cat

function RaelHubMemeSea.AutoClickCat(value)
  
  getgenv().RaelHubAutoClickCat = value
  
  while getgenv().RaelHubAutoClickCat do
    
    fireclickdetector(workspace.Island.FloppaIsland.Popcat_Clickable.Part.ClickDetector)
    task.wait(0.005)
    
  end
  
end

function RaelHubMemeSea.ShowClickCat()
  
  local FloppaIsland = workspace.Island:FindFirstChild("FloppaIsland")
  
  if FloppaIsland then
    local Popcat_Clickable = FloppaIsland:FindFirstChild("Popcat_Clickable")
    
    if Popcat_Clickable then
      return Popcat_Clickable.Part.BillboardGui.Textlabel.Text
    end
  end
end

-- Auto stats

function RaelHubMemeSea.AutoPutStats(value, melee, health, weapon, power)
  getgenv().AutoPutStats = value

  task.spawn(function()
    while getgenv().AutoPutStats do
      local TabArgs = {
        {
          ["Target"] = "MeleeLevel",
          ["Action"] = "UpgradeStats",
          ["Amount"] = melee
        },
        {
          ["Target"] = "DefenseLevel",
          ["Action"] = "UpgradeStats",
          ["Amount"] = health
        },
        {
          ["Target"] = "SwordLevel",
          ["Action"] = "UpgradeStats",
          ["Amount"] = weapon
        },
        {
          ["Target"] = "MemePowerLevel",
          ["Action"] = "UpgradeStats",
          ["Amount"] = power
        }
      }

      for _, Args in ipairs(TabArgs) do
        ReplicatedStorage.OtherEvent.MainEvents.StatsFunction:InvokeServer(Args)
        task.wait(0.3)
      end
      task.wait(1)
    end
  end)
end

-- Auto Meme beast

function TeleportToMemeSea(monster)
  while monster.Parent and getgenv().AutoMemeBeast do
    if monster then
      local HumanoidRootPart = monster:FindFirstChild("HumanoidRootPart")
      if HumanoidRootPart then
        local position = HumanoidRootPart.Position
        local altura = position + Vector3.new(0, getgenv().HeightPlayer, 0)
        local rotation = Vector3.new(-90, 0, 180)

        if Character and Character:FindFirstChild("HumanoidRootPart") then
          Character.HumanoidRootPart.CFrame = CFrame.new(altura) * CFrame.Angles(math.rad(rotation.X), math.rad(rotation.Y), math.rad(rotation.Z))
        end
      end
      task.wait()
    end
  end
end

function RaelHubMemeSea.AutoMemeBeast(value, callback, callback2)
  getgenv().AutoMemeBeast = value
  task.spawn(function()
    while getgenv().AutoMemeBeast do
      
      for _, Monster in ipairs(Monsters:GetChildren()) do
        
        if Monster.Name == "Meme Beast" then
        
          task.spawn(function()
            while getgenv().AutoMemeBeast do
              Function_EquipStyle()
              task.wait()
            end
          end)
          if callback then
            callback()
          end
          TeleportToMemeSea(Monster)
          if callback2 then
            callback2()
          end
        end
      end
      task.wait()
    end
  end)
end

-- Auto roll fruit

function RaelHubMemeSea.AutoRollFruitMoney(value)
  getgenv().AutoRollFruitMoney = value
  while getgenv().AutoRollFruitMoney do
    local args = {
      [1] = "Random_Power",
      [2] = {
        ["Type"] = "Once",
        ["NPCName"] = "Floppa Gacha",
        ["GachaType"] = "Money"
      }
    }

    game:GetService("ReplicatedStorage").OtherEvent.MainEvents.Modules:FireServer(unpack(args))
    task.wait(getgenv().DelayRollFruit)
  end
end

function RaelHubMemeSea.AutoRollFruitGem(value)
  getgenv().AutoRollFruitGem = value
  while getgenv().AutoRollFruitGem do
    local args = {
      [1] = "Random_Power",
      [2] = {
        ["Type"] = "Once",
        ["NPCName"] = "Doge Gacha",
        ["GachaType"] = "Gem"
      }
    }

    game:GetService("ReplicatedStorage").OtherEvent.MainEvents.Modules:FireServer(unpack(args))
    task.wait(getgenv().DelayRollFruit)
  end
end

-- Auto Aimbot player 

function RaelHubMemeSea.AutoAimbotPlayer(value)
  getgenv().AutoAimBot = value
  while getgenv().AutoAimBot do
    task.wait()
    local humanoidrootpart = Character:FindFirstChild("HumanoidRootPart")
    if humanoidrootpart then
      local closestPlayer = nil
      local closestDistance = math.huge

      for _, player in ipairs(CharacterPlayer:GetChildren()) do
        if player ~= LocalPlayer then
          local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
          if targetRoot then
            local distance = (humanoidrootpart.Position - targetRoot.Position).Magnitude
            if distance < closestDistance then
              closestDistance = distance
              closestPlayer = player
            end
          end
        end
      end

      if closestPlayer then
        
        local humanoidrootpart = closestPlayer:FindFirstChild("HumanoidRootPart")
        if humanoidrootpart then
          
          getgenv().PlayerAimBot = humanoidrootpart.Position
          
        end
      end
    end
  end
end

warn("All functions have been loaded")
warn("Thank you for using Rael's modules (Laelmano24)")

return RaelHubMemeSea