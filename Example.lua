-- example for the modified linoria lib
-- shows off title splitting, widgets, keybind mobile buttons, etc.

local repo = 'https://raw.githubusercontent.com/christianfbi19/linoria-but-kinda-good/refs/heads/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'SaveManager.lua'))()

-- setup window
-- title can be a string or a table. table lets you color part of it
local Window = Library:CreateWindow({
    Title = { Accent = 'pretty', Rest = '.win' },
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Combat = Window:AddTab('Combat'),
    Visuals = Window:AddTab('Visuals'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- main tab stuff
local GeneralBox = Tabs.Main:AddLeftGroupbox('General')

GeneralBox:AddToggle('SpeedBoost', {
    Text = 'Speed Boost',
    Default = false,
    Tooltip = 'increases your walkspeed',
})

Toggles.SpeedBoost:OnChanged(function()
    local plr = game:GetService('Players').LocalPlayer
    if plr and plr.Character and plr.Character:FindFirstChild('Humanoid') then
        plr.Character.Humanoid.WalkSpeed = Toggles.SpeedBoost.Value and 32 or 16
    end
end)

GeneralBox:AddSlider('WalkSpeed', {
    Text = 'Walk Speed',
    Default = 16,
    Min = 16, Max = 100, Rounding = 0,
    Suffix = ' studs/s',
})

Options.WalkSpeed:OnChanged(function()
    if Toggles.SpeedBoost.Value then
        local plr = game:GetService('Players').LocalPlayer
        if plr and plr.Character and plr.Character:FindFirstChild('Humanoid') then
            plr.Character.Humanoid.WalkSpeed = Options.WalkSpeed.Value
        end
    end
end)

GeneralBox:AddSlider('JumpPower', {
    Text = 'Jump Power',
    Default = 50,
    Min = 50, Max = 200, Rounding = 0,
})

GeneralBox:AddDivider()

GeneralBox:AddDropdown('Gamemode', {
    Values = { 'Legit', 'Rage', 'Custom' },
    Default = 1,
    Text = 'Mode',
    Tooltip = 'how you wanna play',
})

Options.Gamemode:OnChanged(function()
    Library:Notify(('switched to %s mode'):format(Options.Gamemode.Value), 3)
end)

-- keybind toggles. the widget auto-adds mobile tap buttons
local FeaturesBox = Tabs.Main:AddRightGroupbox('Features')

FeaturesBox:AddToggle('AutoSprint', {
    Text = 'Auto Sprint',
    Default = false,
}):AddKeyPicker('AutoSprintKey', {
    Default = 'LeftShift',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Auto Sprint',
})

FeaturesBox:AddToggle('NoClip', {
    Text = 'No Clip',
    Default = false,
    Risky = true,
}):AddKeyPicker('NoClipKey', {
    Default = 'N',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'No Clip',
})

FeaturesBox:AddToggle('Fly', {
    Text = 'Fly',
    Default = false,
    Risky = true,
}):AddKeyPicker('FlyKey', {
    Default = 'F',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Fly',
})

FeaturesBox:AddDivider()

FeaturesBox:AddInput('ChatMessage', {
    Default = '',
    Text = 'Auto Chat Message',
    Placeholder = 'type something...',
})

FeaturesBox:AddLabel('Color'):AddColorPicker('ESPColor', {
    Default = Color3.fromRGB(255, 182, 193),
    Title = 'ESP Color',
    Transparency = 0,
})

-- combat tab
local AimbotBox = Tabs.Combat:AddLeftGroupbox('Aimbot')

AimbotBox:AddToggle('AimbotEnabled', {
    Text = 'Enable Aimbot',
    Default = false,
}):AddKeyPicker('AimbotKey', {
    Default = 'MB2',
    Mode = 'Hold',
    Text = 'Aimbot',
})

AimbotBox:AddSlider('AimbotFOV', {
    Text = 'FOV Radius',
    Default = 120,
    Min = 30, Max = 500, Rounding = 0,
    Suffix = 'px',
})

AimbotBox:AddDropdown('AimbotTarget', {
    Values = { 'Head', 'Torso', 'Closest' },
    Default = 1,
    Text = 'Target Part',
})

AimbotBox:AddSlider('Smoothness', {
    Text = 'Smoothness',
    Default = 5,
    Min = 1, Max = 20, Rounding = 1,
})

local AutoBox = Tabs.Combat:AddRightGroupbox('Automation')

AutoBox:AddToggle('AutoParry', {
    Text = 'Auto Parry',
    Default = false,
}):AddKeyPicker('AutoParryKey', {
    Default = 'P',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Auto Parry',
})

AutoBox:AddToggle('AutoAttack', { Text = 'Auto Attack', Default = false })

AutoBox:AddSlider('AttackDelay', {
    Text = 'Attack Delay',
    Default = 0.1,
    Min = 0, Max = 1, Rounding = 2,
    Suffix = 's',
})

AutoBox:AddDivider()

AutoBox:AddDropdown('MoveSpam', {
    Values = { 'None', 'Combat Roll', 'Dash', 'Geppo' },
    Default = 1,
    Multi = true,
    Text = 'Move Spam',
})

-- visuals tab
local ESPBox = Tabs.Visuals:AddLeftGroupbox('ESP')

ESPBox:AddToggle('ESPEnabled', { Text = 'Enable ESP', Default = false })
ESPBox:AddToggle('ESPBoxes', { Text = 'Bounding Boxes', Default = true })
ESPBox:AddToggle('ESPNames', { Text = 'Player Names', Default = true })
ESPBox:AddToggle('ESPHealth', { Text = 'Health Bars', Default = false })

ESPBox:AddLabel('Box Color'):AddColorPicker('BoxColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Box Color',
})

ESPBox:AddLabel('Name Color'):AddColorPicker('NameColor', {
    Default = Color3.fromRGB(255, 182, 193),
    Title = 'Name Color',
})

-- conditional settings (dependency box showcase)
local DepGroupbox = Tabs.Visuals:AddRightGroupbox('Conditional')
DepGroupbox:AddToggle('AdvancedESP', { Text = 'Advanced ESP' })

local AdvancedDepbox = DepGroupbox:AddDependencyBox()
AdvancedDepbox:AddSlider('TracerWidth', {
    Text = 'Tracer Width',
    Default = 1,
    Min = 1, Max = 5, Rounding = 0,
    Suffix = 'px',
})
AdvancedDepbox:AddDropdown('TracerOrigin', {
    Text = 'Tracer Origin',
    Default = 1,
    Values = { 'Bottom', 'Center', 'Mouse' },
})
AdvancedDepbox:SetupDependencies({
    { Toggles.AdvancedESP, true }
})

-- ui settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton({
    Text = 'Unload',
    Func = function() Library:Unload() end,
    DoubleClick = true,
    Tooltip = 'double-click to unload',
})

MenuGroup:AddLabel('Menu Keybind'):AddKeyPicker('MenuKeybind', {
    Default = 'End',
    NoUI = true,
    Text = 'Menu keybind',
})

-- widgets (leaderboard, chat log, viewmodel)
local WidgetsBox = Tabs['UI Settings']:AddRightGroupbox('Widgets')

WidgetsBox:AddToggle('ShowLeaderboard', {
    Text = 'Leaderboard',
    Default = false,
    Tooltip = 'click the circles to change priority',
})

Toggles.ShowLeaderboard:OnChanged(function()
    Library:SetLeaderboardVisibility(Toggles.ShowLeaderboard.Value)
end)

WidgetsBox:AddToggle('ShowChatLog', {
    Text = 'Chat Log',
    Default = false,
    Tooltip = 'logs all chat messages',
})

Toggles.ShowChatLog:OnChanged(function()
    Library:SetChatLogVisibility(Toggles.ShowChatLog.Value)
end)

WidgetsBox:AddToggle('ShowViewmodel', {
    Text = 'Viewmodel',
    Default = false,
    Tooltip = 'preview your character model',
})

Toggles.ShowViewmodel:OnChanged(function()
    Library:SetViewmodelVisibility(Toggles.ShowViewmodel.Value)
end)

WidgetsBox:AddDivider()

WidgetsBox:AddButton({
    Text = 'Refresh Leaderboard',
    Func = function()
        Library:UpdateLeaderboard()
    end,
})

WidgetsBox:AddButton({
    Text = 'Refresh Viewmodel',
    Func = function()
        Library:RefreshViewmodel()
    end,
})

-- viewmodel chams example (hook it up to your esp system)
-- Library:AddViewmodelHighlight({ FillColor = Color3.new(1,0,0), FillTransparency = 0.5 })
-- Library:ClearViewmodelHighlights()

-- priority system notes:
-- click the colored circle next to a player name to cycle priority
-- None > Low > Med > Friend > Threat > Target > None
-- priorities save to file automatically
-- api: Library:SetPlayerPriority(player, level, label, color)
-- api: Library:GetPlayerPriority(player)
-- api: Library:CyclePlayerPriority(player)

-- watermark
Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1
    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter
        FrameTimer = tick()
        FrameCounter = 0
    end

    Library:SetWatermark(('pretty.win | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ))
end)

-- show keybind widget
Library.KeybindFrame.Visible = true

-- managers
Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('PrettyWin')
SaveManager:SetFolder('PrettyWin/config')

SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()

-- cleanup
Library:OnUnload(function()
    WatermarkConnection:Disconnect()
    print('unloaded')
    Library.Unloaded = true
end)
