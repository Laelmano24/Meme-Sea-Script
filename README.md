<h1 align="center">Meme Sea script Opensource 🔥</h1>
<h3 align="center">Create your own Meme sea script with Rael Hub features 🗿</h3>

<strong>Number of views</strong>
<br>
![View Counter](https://hits.dwyl.com/Laelmano24/Meme-Sea-Script.svg?style=flat-square)
<br></br>
<strong>Import modules from Rael Hub</strong>
<br>
```lua
-- Import the modules
local RaelHubMemeSea = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Laelmano24/Meme-Sea-Script/refs/heads/main/Modules.lua')))()
```
<br></br>
<strong>Global variable to store the attack mode</strong>
```lua
-- Value for choosing fighting style
getgenv().EquipStyle = "Melee"

-- Value for choosing weapons
getgenv().EquipStyle = "Weapons"
```
<br></br>
<strong>Auto farm</strong>
```lua
-- Auto farm function

-- Enable auto farm
RaelHubMemeSea.AutoFarm(true)
-- Disable auto farm
RaelHubMemeSea.AutoFarm(false)
```
<br></br>
<strong>Auto clicker</strong>
```lua
-- Auto clicker function

-- Enable auto clicker
RaelHubMemeSea.AutoClicker(true)
-- Disable auto clicker
RaelHubMemeSea.AutoClicker(false)
```
<br></br>
<strong>Auto Farm selected monster</strong>
```lua

local MonsterName = "Floppa"
local Value = true -- false (Only for you to disable the function)

RaelHubMemeSea.AutoFarmMonsterSelected(MonsterName, Value)
```
<br></br>
<strong>Auto boss summoner</strong>
```lua

local BossSummonerName = "Giant Pumpkin" -- You can add other values: "Evil Noob" "Lord Sus"
local Value = true -- false (Only for you to disable the function)

RaelHubMemeSea.AutoFarmBoss(BossSummonerName, Value)
```
<br></br>
<strong>Auto clicker cat</strong>
```lua
-- Auto clicker cat

-- Enable auto clicker cat
RaelHubMemeSea.AutoClickCat(true)
-- Disable auto clicker cat
RaelHubMemeSea.AutoClickCat(false)
```