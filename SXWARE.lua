-- New example script written by wally
-- You can suggest changes with a pull request or something

local License = "KEYAUTH-ljZmqX-gYQzab-di5eZm-FsMpKk-eT7xuA-eId36O" --* Your License to use this script.

local notificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/laagginq/ui-libraries/main/xaxas-notification/src.lua"))();
local notifications = notificationLibrary.new({            
    NotificationLifetime = 3, 
    NotificationPosition = "Middle",
    
    TextFont = Enum.Font.Code,
    TextColor = Color3.fromRGB(255, 255, 255),
    TextSize = 15,
    
    TextStrokeTransparency = 0, 
    TextStrokeColor = Color3.fromRGB(0, 0, 0)
});


print(' KeyAuth Lua Example - https://github.com/mazk5145/')
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local LuaName = "KeyAuth Lua Example"

notifications:BuildNotificationUI();
notifications:Notify("...");

--* Configuration *--
local initialized = false
local sessionid = ""


--* Application Details *--
Name = "w" --* Application Name
Ownerid = "UC4C1Z5vNm" --* OwnerID
APPVersion = "1.0" --* Application Version

local req = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. Name .. '&ownerid=' .. Ownerid .. '&type=init&ver=' .. APPVersion)

if req == "KeyAuth_Invalid" then 
   print(" Error: Application not found.")

   notifications:BuildNotificationUI();
notifications:Notify(" Error: Application not found.");

   return false
end

local data = HttpService:JSONDecode(req)

if data.success == true then
   initialized = true
   sessionid = data.sessionid
   --print(req)
elseif (data.message == "invalidver") then
   print(" Error: Wrong application version..")

   notifications:BuildNotificationUI();
   notifications:Notify(" Error: Wrong Application Version..");

   return false
else
   print(" Error: " .. data.message)
   return false
end

print("\n\n Licensing... \n")
local req = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. Name .. '&ownerid=' .. Ownerid .. '&type=license&key=' .. License ..'&ver=' .. APPVersion .. '&sessionid=' .. sessionid)
local data = HttpService:JSONDecode(req)


if data.success == false then 

    notifications:BuildNotificationUI();
    notifications:Notify(" Error: " .. data.message);

    return false
end

   notifications:BuildNotificationUI();
notifications:Notify("Loading...");


--* Your code here *--

--* Example Code to show user data *-- 
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    -- Set Center to true if you want the menu to appear in the center
    -- Set AutoShow to true if you want the menu to appear when it is created
    -- Position and Size are also valid options here
    -- but you do not need to define them unless you are changing them :)

    Title = ">w< | UwU | SxWare🤑🤑",
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})




-- CALLBACK NOTE:
-- Passing in callback functions via the initial element parameters (i.e. Callback = function(Value)...) works
-- HOWEVER, using Toggles/Options.INDEX:OnChanged(function(Value) ... ) is the RECOMMENDED way to do this.
-- I strongly recommend decoupling UI code from logic code. i.e. Create your UI elements FIRST, and THEN setup :OnChanged functions later.

-- You do not have to set your tabs & groups up this way, just a prefrence.
local Tabs = {
    -- Creates a new tab titled Main
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')

--[[
    NOTE: You can chain the button methods!
    EXAMPLE:

    LeftGroupBox:AddButton({ Text = 'Kill all', Func = Functions.KillAll, Tooltip = 'This will kill everyone in the game!' })
        :AddButton({ Text = 'Kick all', Func = Functions.KickAll, Tooltip = 'This will kick everyone in the game!' })
]]

-- Groupbox:AddLabel
-- Arguments: Text, DoesWrap
-- Groupbox:AddDivider
-- Arguments: None
LeftGroupBox:AddDivider()

--[[
    Groupbox:AddSlider
    Arguments: Idx, SliderOptions

    SliderOptions: {
        Text = string,
        Default = number,
        Min = number,
        Max = number,
        Suffix = string,
        Rounding = number,
        Compact = boolean,
        HideMax = boolean,
    }

    Text, Default, Min, Max, Rounding must be specified.
    Suffix is optional.
    Rounding is the number of decimal places for precision.

    Compact will hide the title label of the Slider

    HideMax will only display the value instead of the value & max value of the slider
    Compact will do the same thing
]]
LeftGroupBox:AddSlider('MySlider', {
    Text = 'This is my slider!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[cb] MySlider was changed! New value:', Value)
    end
})

-- Options is a table added to getgenv() by the library
-- You index Options with the specified index, in this case it is 'MySlider'
-- To get the value of the slider you do slider.Value

local Number = Options.MySlider.Value
Options.MySlider:OnChanged(function()
    print('MySlider was changed! New value:', Options.MySlider.Value)
end)

-- This should print to the console: "MySlider was changed! New value: 3"
Options.MySlider:SetValue(3)

-- Groupbox:AddInput
-- Arguments: Idx, Info
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'My textbox!',
    Numeric = false, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter

    Text = 'This is a textbox',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the textbox

    Placeholder = 'Placeholder text', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text

    Callback = function(Value)
        print('[cb] Text updated. New text:', Value)
    end
})

Options.MyTextbox:OnChanged(function()
    print('Text updated. New text:', Options.MyTextbox.Value)
end)

-- Groupbox:AddDropdown
-- Arguments: Idx, Info

LeftGroupBox:AddDropdown('Material', {
    Values = { 'Metal', 'Air', 'Neon', 'ForceField', 'Basalt'},
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Material',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].ProjectorSight.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["1"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]:GetChildren()[12].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]:GetChildren()[20].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]:GetChildren()[5].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["3.5 Inch Adaptor for Geissele SMR"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["ALG ACT Trigger Group"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["AN PEQ"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["Aimpoint Micro T1"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["B5 Systems SOPMOD STock"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Bolt.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].BufferTube.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["DD 14.5 Government Barrel"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["DDM4 Upper Receiver"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["Dust Cover"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].ForwardAssist.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["Geissele Super Precision T1 Lower Third"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["Inforce WML"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Lower.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["MAGPUL MOE Pistol Grip"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["MAGPUL MOE Trigger Guard"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Mag.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]:GetChildren()[29].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].MeshPart.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["PRI 223 MSTN QCB"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Paracord.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Selector.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["SureFire SOCOM 5.56 QD Suppressor"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Trigger.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["Warsport LVOA-C Handguard (1-2)"].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]:GetChildren()[15].Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].AimPart.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].AimPart3.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Chamber.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].FirePart.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].FlashLight.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Glass.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Grip.Material = Value
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].LaserLight.Material = Value
    end
})

LeftGroupBox:AddDropdown('shoot', {
    Values = { 'Railgun', 'Celeste', 'sicko mode', 'gamesense' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'shoot sound',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        if Value == 'Railgun' then
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Grip.Fire.SoundId = "rbxassetid://7651995800"
        elseif Value == 'Celeste' then
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Grip.Fire.SoundId = "rbxassetid://8223773319"
        elseif Value == 'sicko mode' then
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Grip.Fire.SoundId = "rbxassetid://5711566428"
        elseif Value == 'gamesense' then
            game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Grip.Fire.SoundId = "rbxassetid://4817809188"
        end
    end
})

LeftGroupBox:AddInput('Customshoot', {
    Default = 'custom shoot',
    Numeric = false, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter

    Text = 'custom shoot sounds',
    Tooltip = 'format must be: rbxassetid://number', -- Information shown when you hover over the textbox

    Placeholder = 'rbxassetid://4817809188', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text

    Callback = function(Value)
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Grip.Fire.SoundId = Value
    end
})



LeftGroupBox:AddLabel('22'):AddColorPicker('sightcolor', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'gun color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].ProjectorSight.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["1"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]:GetChildren()[12].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]:GetChildren()[20].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]:GetChildren()[5].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["3.5 Inch Adaptor for Geissele SMR"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["ALG ACT Trigger Group"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["AN PEQ"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["Aimpoint Micro T1"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["B5 Systems SOPMOD STock"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Bolt.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].BufferTube.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["DD 14.5 Government Barrel"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["DDM4 Upper Receiver"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["Dust Cover"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].ForwardAssist.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["Geissele Super Precision T1 Lower Third"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["Inforce WML"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Lower.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["MAGPUL MOE Pistol Grip"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["MAGPUL MOE Trigger Guard"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Mag.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]:GetChildren()[29].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].MeshPart.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["PRI 223 MSTN QCB"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Paracord.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Selector.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["SureFire SOCOM 5.56 QD Suppressor"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Trigger.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["Warsport LVOA-C Handguard (1-2)"].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]:GetChildren()[15].Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].AimPart.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].AimPart3.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Chamber.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].FirePart.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].FlashLight.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Glass.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].Grip.Color = Value
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].LaserLight.Color = Value
    end
})

LeftGroupBox:AddButton({
    Text = 'remove suppressor',
    Func = function()
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"]["SureFire SOCOM 5.56 QD Suppressor"]:Destroy()
    end,
    DoubleClick = false,
    Tooltip = 'yh'
})

LeftGroupBox:AddLabel('22'):AddColorPicker('sightcolor', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'sight color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
        game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].ProjectorSight.SurfaceGui.ClippingFrame.Reticle.ImageColor3 = Value
    end
})

-- game:GetService("ReplicatedFirst").CarbonResource.Models["AR-15"].FirePart.Fire




-- Label:AddColorPicker
-- Arguments: Idx, Info

-- You can also ColorPicker & KeyPicker to a Toggle as well

LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'Some color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
        print('[cb] Color changed!', Value)
    end
})

Options.ColorPicker:OnChanged(function()
    print('Color changed!', Options.ColorPicker.Value)
    print('Transparency changed!', Options.ColorPicker.Transparency)
end)

Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

-- Label:AddKeyPicker
-- Arguments: Idx, Info


-- OnClick is only fired when you press the keybind and the mode is Toggle
-- Otherwise, you will have to use Keybind:GetState()


-- Long text label to demonstrate UI scrolling behaviour.
local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox('Groupbox #2');
LeftGroupBox2:AddLabel('Oh no...\nThis label spans multiple lines!\n\nWe\'re gonna run out of UI space...\nJust kidding! Scroll down!\n\n\nHello from below!', true)

local TabBox = Tabs.Main:AddRightTabbox() -- Add Tabbox on right side

-- Anything we can do in a Groupbox, we can do in a Tabbox tab (AddToggle, AddSlider, AddLabel, etc etc...)
local Tab1 = TabBox:AddTab('Tab 1')
Tab1:AddToggle('Tab1Toggle', { Text = 'Tab1 Toggle' });

local Tab2 = TabBox:AddTab('Tab 2')
Tab2:AddToggle('Tab2Toggle', { Text = 'Tab2 Toggle' });

-- Dependency boxes let us control the visibility of UI elements depending on another UI elements state.
-- e.g. we have a 'Feature Enabled' toggle, and we only want to show that features sliders, dropdowns etc when it's enabled!
-- Dependency box example:
local RightGroupbox = Tabs.Main:AddRightGroupbox('Groupbox #3');
RightGroupbox:AddToggle('ControlToggle', { Text = 'Dependency box toggle' });

local Depbox = RightGroupbox:AddDependencyBox();
Depbox:AddToggle('DepboxToggle', { Text = 'Sub-dependency box toggle' });

-- We can also nest dependency boxes!
-- When we do this, our SupDepbox automatically relies on the visiblity of the Depbox - on top of whatever additional dependencies we set
local SubDepbox = Depbox:AddDependencyBox();
SubDepbox:AddSlider('DepboxSlider', { Text = 'Slider', Default = 50, Min = 0, Max = 100, Rounding = 0 });
SubDepbox:AddDropdown('DepboxDropdown', { Text = 'Dropdown', Default = 1, Values = {'a', 'b', 'c'} });

Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- We can also pass `false` if we only want our features to show when the toggle is off!
});

SubDepbox:SetupDependencies({
    { Toggles.DepboxToggle, true }
});

-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

-- Example of dynamically-updating watermark with common traits (fps and ping)
local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('>w< | SxWare | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

Library.KeybindFrame.Visible = false; -- todo: add a function for this

Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
