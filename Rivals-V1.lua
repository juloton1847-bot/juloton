function ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB(code)res=''for i in ipairs(code)do res=res..string.char(code[i]/105)end return res end 

local Players = game:GetService(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8400,11340,10185,12705,10605,11970,12075}))
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

Arcane = {}
drawings = {}
local tabs = {}
ActiveKeybinds = {}
ActiveNotifications = {}
local OpenDropdown = nil

local themes = {
    Default = {
        Background = Color3.fromRGB(10, 10, 13),
        Section = Color3.fromRGB(16, 16, 22),
        Accent = Color3.fromRGB(0, 230, 170),
        Outline = Color3.fromRGB(35, 35, 45),
        Text = Color3.fromRGB(245, 245, 250),
        TextDark = Color3.fromRGB(110, 115, 130),
        Button = Color3.fromRGB(24, 24, 32)
    }
}

local function lerp(a, b, t) if not a or not b or not t then return 0 end return a * (1 - t) + b * t end
local function clamp(x, a, b) if x > b then return b elseif x < a then return a else return x end end
local function lerpColor(c1, c2, t) return Color3.new(lerp(c1.R, c2.R, t), lerp(c1.G, c2.G, t), lerp(c1.B, c2.B, t)) end
local function Insert(t, v) table.insert(t, v) end

local function Draw(t, props)
    local o = Drawing.new(t)
    for k, v in pairs(props) do o[k] = v end
    Insert(drawings, o)
    return o
end

local function createGlow(obj, size, pos, corner, spread, color)
    local layers = {}
    for i = 1, spread do
        local glow = Drawing.new(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}))
        glow.Visible = obj.Visible
        glow.Filled = false
        glow.Thickness = 1
        glow.Transparency = 0.15 * (1 - (i / spread))
        glow.Color = color
        glow.Size = size + Vector2.new(i * 2, i * 2)
        glow.Position = pos - Vector2.new(i, i)
        glow.Corner = corner + i
        layers[i] = glow
        Insert(drawings, glow)
    end
    return layers
end

local function getMousePos() return Vector2.new(Mouse.X, Mouse.Y) end
local function isMouseOver(pos, size)
    local m = getMousePos()
    return m.X >= pos.X and m.X <= pos.X + size.X and m.Y >= pos.Y and m.Y <= pos.Y + size.Y
end

local KeyCodeNames = {
    [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8190,11655,11550,10605})] = 0, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7245,11550,12180,10605,11970})] = 0x0D, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11760,10185,10395,10605})] = 0x20, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6930,10185,10395,11235,12075,11760,10185,10395,10605})] = 0x08,
    [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({5040})] = 0x30, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({5145})] = 0x31, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({5250})] = 0x32, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({5355})] = 0x33, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({5460})] = 0x34, 
    [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({5565})] = 0x35, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({5670})] = 0x36, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({5775})] = 0x37, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({5880})] = 0x38, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({5985})] = 0x39,
    [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6825})] = 0x41, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6930})] = 0x42, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7035})] = 0x43, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140})] = 0x44, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7245})] = 0x45, 
    [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350})] = 0x46, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7455})] = 0x47, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7560})] = 0x48, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7665})] = 0x49, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7770})] = 0x4A, 
    [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7875})] = 0x4B, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7980})] = 0x4C, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8085})] = 0x4D, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8190})] = 0x4E, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8295})] = 0x4F, 
    [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8400})] = 0x50, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8505})] = 0x51, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8610})] = 0x52, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715})] = 0x53, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820})] = 0x54, 
    [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8925})] = 0x55, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({9030})] = 0x56, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({9135})] = 0x57, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({9240})] = 0x58, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({9345})] = 0x59, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({9450})] = 0x5A,
    [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7665,11550,12075,10605,11970,12180})] = 0x2D, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,10605,11340,10605,12180,10605})] = 0x2E, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7560,11655,11445,10605})] = 0x24, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7245,11550,10500})] = 0x23, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8400,10185,10815,10605,8925,11760})] = 0x21, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8400,10185,10815,10605,7140,11655,12495,11550})] = 0x22,
    [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5145})] = 0x70, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5250})] = 0x71, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5355})] = 0x72, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5460})] = 0x73, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5565})] = 0x74, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5670})] = 0x75, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5775})] = 0x76, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5880})] = 0x77, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5985})] = 0x78, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5145,5040})] = 0x79, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5145,5145})] = 0x7A, [ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350,5145,5250})] = 0x7B
}
local ReverseKeyCodeNames = {}
for k, v in pairs(KeyCodeNames) do ReverseKeyCodeNames[v] = k end
local function GetKeyName(kc) return ReverseKeyCodeNames[kc] or ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7875,10605,12705,6090,3360}) .. tostring(kc) end

local function notify(text, title, duration) Arcane:Notify(title or ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,12705,12075,12180,10605,11445}), text, duration or 5) end

function Arcane:Notify(title, text, duration)
    spawn(function()
        local theme = themes.Default
        local duration = duration or 4
        local id = {}
        
        local function wrapText(str, limit)
            local res = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({})
            for i = 1, #str do res = res .. str:sub(i, i); if i > 0 and i % limit == 0 then res = res .. ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({9660,11550}) end end
            return res
        end
        local processedText = wrapText(text, 35)
        
        local elements = {
            Background = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Size = Vector2.new(220, 56), Color = theme.Section, Filled = true, Corner = 6, ZIndex = 2001, Visible = true}),
            Indicator = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Size = Vector2.new(3, 56), Color = theme.Accent, Filled = true, ZIndex = 2002, Visible = true}),
            Title = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = title:upper(), Size = 13, Color = theme.Accent, Font = 2, ZIndex = 2003, Visible = true}),
            Text = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = processedText, Size = 13, Color = theme.Text, Font = 2, ZIndex = 2003, Visible = true}),
            Bar = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Size = Vector2.new(220, 2), Color = theme.Accent, Filled = true, Transparency = 0.6, ZIndex = 2004, Visible = true})
        }

        table.insert(ActiveNotifications, {ID = id, Elements = elements})
        local elapsed = 0
        while elapsed < duration do
            local dt = task.wait(0.02) or 0.02
            elapsed = elapsed + dt
            local percent = clamp(1 - (elapsed / duration), 0, 1)
            
            local index = 0
            for i, v in ipairs(ActiveNotifications) do if v.ID == id then index = i break end end

            if index > 0 then
                local targetY = 1080 - 70 - ((index - 1) * 68)
                local targetPos = Vector2.new(1920 - 240, targetY)

                elements.Background.Position = targetPos
                elements.Indicator.Position = targetPos
                elements.Title.Position = targetPos + Vector2.new(12, 6)
                elements.Text.Position = targetPos + Vector2.new(12, 24)
                elements.Bar.Position = targetPos + Vector2.new(0, 54)
                elements.Bar.Size = Vector2.new(220 * percent, 2)
            end
        end
        
        for i, v in ipairs(ActiveNotifications) do if v.ID == id then table.remove(ActiveNotifications, i) break end end
        for _, el in pairs(elements) do el:Remove() end
    end)
end

function Arcane:CreateWindow(Title, Size, ThemeName)
    local theme = themes[ThemeName] or themes.Default
    local windowSize = Size or Vector2.new(680, 460)
    local screenPos = Vector2.new(250, 250)

    local main = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Background, Size = windowSize, Position = screenPos, Corner = 10, Visible = true, ZIndex = 1})
    local sidebar = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = Color3.fromRGB(8, 8, 10), Size = Vector2.new(140, windowSize.Y), Position = screenPos, Corner = 10, Visible = true, ZIndex = 2})
    local logo = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = Title:upper(), Size = 20, Color = theme.Accent, Position = screenPos + Vector2.new(20, 22), Font = 2, Visible = true, ZIndex = 3})
    local globalSelector = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Accent, Size = Vector2.new(2, 16), Position = screenPos + Vector2.new(0, 70), Visible = true, ZIndex = 5})

    local window = {
        Main = main, Sidebar = sidebar, Logo = logo, GlobalSelector = globalSelector,
        Pos = screenPos, Size = windowSize, Theme = theme, Sections = {}, CurrentTab = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({}),
        SidebarItems = {}, SidebarLayoutY = 75, SidebarPadding = 4, TargetSelectorY = 75, CurrentSelectorY = 75,
        TabSections = {}
    }
    window.Glow = createGlow(main, windowSize, screenPos, 10, 8, theme.Accent)
    Arcane.IsOpen = true

    function window:SetVisible(state)
        Arcane.IsOpen = state
        self.Main.Visible = state
        self.Sidebar.Visible = state
        self.Logo.Visible = state
        self.GlobalSelector.Visible = state
        for _, glow in ipairs(self.Glow) do glow.Visible = state end
        for _, item in ipairs(self.SidebarItems) do if item.Text then item.Text.Visible = state end end
        self:UpdateVisibility()
    end

    function window:Move(delta)
        self.Pos = self.Pos + delta
        self.Main.Position = self.Main.Position + delta
        self.Sidebar.Position = self.Sidebar.Position + delta
        self.Logo.Position = self.Logo.Position + delta
        self.GlobalSelector.Position = self.GlobalSelector.Position + delta
        for i, glow in ipairs(self.Glow) do glow.Position = self.Main.Position - Vector2.new(i, i) end
        for _, item in ipairs(self.SidebarItems) do item:_Move(delta) end
        self:RelayoutTab(self.CurrentTab)
    end

    function window:CreateTabSection(text)
        local y = self.SidebarLayoutY
        self.SidebarLayoutY = self.SidebarLayoutY + 20
        local label = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = text:upper(), Size = 11, Color = theme.TextDark, Position = self.Pos + Vector2.new(18, y), Font = 2, Visible = true, ZIndex = 4})
        local tabSection = {Text = label, _Move = function(_, d) label.Position = label.Position + d end}
        Insert(self.SidebarItems, tabSection)
        self.TabSections[text] = tabSection
        return tabSection
    end

    function window:CreateTab(Name)
        local height = 26
        local y = self.SidebarLayoutY
        self.SidebarLayoutY = self.SidebarLayoutY + height + self.SidebarPadding
        local pos = self.Pos + Vector2.new(0, y)
        local text = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = Name, Size = 13, Color = theme.TextDark, Position = pos + Vector2.new(24, 5), Font = 2, Visible = true, ZIndex = 4})
        local tab = {Name = Name, Position = pos, Size = Vector2.new(140, height), Text = text, RelativeY = y + 5}
        function tab:_Move(d) self.Position = self.Position + d; self.Text.Position = self.Text.Position + d end
        Insert(self.SidebarItems, tab)
        Insert(tabs, tab)
        if self.CurrentTab == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({}) then self.CurrentTab = Name; text.Color = theme.Text; self.TargetSelectorY = tab.RelativeY; self.CurrentSelectorY = tab.RelativeY end
        return tab
    end

    function window:UpdateVisibility()
        for _, s in ipairs(self.Sections) do
            local isVisible = (s.Tab == self.CurrentTab) and Arcane.IsOpen
            s.Frame.Visible = isVisible
            s.Title.Visible = isVisible
            s.Line.Visible = isVisible
            for _, item in ipairs(s.ContentDrawings) do 
                if item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8400,11025,10395,11235,10605,11970,8400,10185,11970,12180}) or item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,11970,11655,11760,10500,11655,12495,11550,8400,10185,11970,12180}) then item.Obj.Visible = false else item.Obj.Visible = isVisible end
            end
        end
        OpenDropdown = nil
        self:RelayoutTab(self.CurrentTab)
    end

    function window:CreateSection(Name, TabName)
        local section = {Frame = nil, Title = nil, Tab = TabName, Name = Name, ContentDrawings = {}, InternalY = 5, Width = 230}
        section.Frame = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Section, Size = Vector2.new(230, 25), Corner = 6, Visible = (TabName == self.CurrentTab), ZIndex = 10})
        section.Title = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = Name:upper(), Size = 12, Color = theme.Text, Font = 2, Visible = (TabName == self.CurrentTab), ZIndex = 11})
        section.Line = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Outline, Size = Vector2.new(230, 1), Visible = (TabName == self.CurrentTab), ZIndex = 11})

        function section:AddLabel(text)
            local label = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = text, Size = 13, Color = theme.TextDark, Font = 2, Visible = self.Frame.Visible, ZIndex = 12})
            Insert(self.ContentDrawings, {Obj = label, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7980,10185,10290,10605,11340}), Height = 18})
            self.InternalY = self.InternalY + 18
            window:RelayoutTab(self.Tab)
            return label
        end

        function section:AddTextBox(text, default, callback)
            local box = {Value = default or ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({}), Callback = callback}
            local label = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = text, Size = 13, Color = theme.Text, Font = 2, Visible = self.Frame.Visible, ZIndex = 12})
            local boxFrame = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Button, Size = Vector2.new(section.Width - 20, 22), Corner = 4, Visible = self.Frame.Visible, ZIndex = 12})
            local boxText = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = box.Value, Size = 13, Color = theme.TextDark, Center = true, Font = 2, Visible = self.Frame.Visible, ZIndex = 13})
            local active = false
            Insert(self.ContentDrawings, {Obj = label, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7980,10185,10290,10605,11340}), Height = 16})
            Insert(self.ContentDrawings, {Obj = boxFrame, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6930,12285,12180,12180,11655,11550,7350,11970,10185,11445,10605}), Height = 26})
            Insert(self.ContentDrawings, {Obj = boxText, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6930,12285,12180,12180,11655,11550,8820,10605,12600,12180}), Center = true})
            
            function box:SetValue(val)
                self.Value = val
                boxText.Text = self.Value
                self.Callback(self.Value)
            end

            spawn(function()
                local wasM1 = false
                local wasPressed = {}
                while true do
                    if section.Frame.Visible and window.CurrentTab == section.Tab and Arcane.IsOpen then
                        local m1 = ismouse1pressed()
                        if not OpenDropdown and m1 and not wasM1 then
                            active = isMouseOver(boxFrame.Position, boxFrame.Size)
                            boxFrame.Color = active and theme.Section or theme.Button
                            boxText.Color = active and theme.Accent or theme.TextDark
                        end
                        wasM1 = m1
                        if active then
                            for name, kc in pairs(KeyCodeNames) do
                                local down = iskeypressed(kc)
                                if down and not wasPressed[kc] then
                                    if kc == 0x08 then box.Value = box.Value:sub(1, #box.Value - 1)
                                    elseif kc == 0x0D then active = false; boxFrame.Color = theme.Button; boxText.Color = theme.TextDark; box.Callback(box.Value)
                                    elseif #name == 1 or name == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11760,10185,10395,10605}) then
                                        local char = (name == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11760,10185,10395,10605}) and ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({3360}) or name)
                                        char = iskeypressed(0x10) and char:upper() or char:lower()
                                        box.Value = box.Value .. char
                                    end
                                    boxText.Text = box.Value
                                end
                                wasPressed[kc] = down
                            end
                        end
                    end
                    wait()
                end
            end)
            section.InternalY = section.InternalY + 42; window:RelayoutTab(section.Tab)
            return box
        end

        function section:AddButton(text, callback)
            local btnFrame = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Button, Size = Vector2.new(self.Width - 20, 22), Corner = 4, Visible = self.Frame.Visible, ZIndex = 12})
            local btnText = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = text, Size = 13, Color = theme.Text, Center = true, Font = 2, Visible = self.Frame.Visible, ZIndex = 13})
            Insert(self.ContentDrawings, {Obj = btnFrame, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6930,12285,12180,12180,11655,11550,7350,11970,10185,11445,10605}), Height = 26})
            Insert(self.ContentDrawings, {Obj = btnText, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6930,12285,12180,12180,11655,11550,8820,10605,12600,12180}), Center = true})
            spawn(function()
                local wasDown = false
                while true do
                    if section.Frame.Visible and window.CurrentTab == section.Tab and Arcane.IsOpen then
                        local over = isMouseOver(btnFrame.Position, btnFrame.Size)
                        local down = ismouse1pressed()
                        if not OpenDropdown and over then
                            btnFrame.Color = lerpColor(theme.Button, theme.Accent, 0.15)
                            if down and not wasDown then callback(); btnFrame.Color = theme.Accent; wait(0.08) end
                        else btnFrame.Color = theme.Button end
                        wasDown = down
                    end
                    wait()
                end
            end)
            section.InternalY = section.InternalY + 26; window:RelayoutTab(section.Tab)
            return {Frame = btnFrame, Text = btnText}
        end

        function section:AddSlider(text, options)
            local slider = {Value = options.Default or 0, Min = options.Min or 0, Max = options.Max or 100, Callback = options.Callback}
            local label = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = text, Size = 13, Color = theme.Text, Font = 2, Visible = self.Frame.Visible, ZIndex = 12})
            local backFrame = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Button, Size = Vector2.new(section.Width - 20, 14), Corner = 4, Visible = self.Frame.Visible, ZIndex = 12})
            local fillFrame = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Accent, Size = Vector2.new(0, 14), Corner = 4, Visible = self.Frame.Visible, ZIndex = 13})
            local valueText = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = tostring(slider.Value), Size = 12, Color = theme.Text, Center = false, Font = 2, Visible = self.Frame.Visible, ZIndex = 14})
            
            Insert(self.ContentDrawings, {Obj = label, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7980,10185,10290,10605,11340}), Height = 18})
            Insert(self.ContentDrawings, {Obj = backFrame, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11340,11025,10500,10605,11970,7350,11970,10185,11445,10605}), Height = 20})
            Insert(self.ContentDrawings, {Obj = fillFrame, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7665,10815,11550,11655,11970,10605})})
            Insert(self.ContentDrawings, {Obj = valueText, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7665,10815,11550,11655,11970,10605})})
            
            function slider:SetValue(val)
                self.Value = math.clamp(val, self.Min, self.Max)
                local percent = (self.Value - self.Min) / (self.Max - self.Min)
                fillFrame.Size = Vector2.new(backFrame.Size.X * percent, backFrame.Size.Y)
                valueText.Text = tostring(self.Value)
                self.Callback(self.Value)
            end

            spawn(function()
                local dragging = false
                while true do
                    if section.Frame.Visible and window.CurrentTab == section.Tab and Arcane.IsOpen then
                        local down = ismouse1pressed()
                        if not OpenDropdown and isMouseOver(backFrame.Position, backFrame.Size) and down then dragging = true end
                        if not down then dragging = false end
                        if dragging then
                            local percent = math.clamp((getMousePos().X - backFrame.Position.X) / backFrame.Size.X, 0, 1)
                            slider:SetValue(math.floor(slider.Min + (slider.Max - slider.Min) * percent))
                        end
                        fillFrame.Position = backFrame.Position
                        fillFrame.Visible = section.Frame.Visible and Arcane.IsOpen
                        
                        if valueText.TextBounds then
                            valueText.Position = Vector2.new(backFrame.Position.X + backFrame.Size.X - valueText.TextBounds.X, label.Position.Y + 1)
                        end
                        valueText.Visible = section.Frame.Visible and Arcane.IsOpen
                    else fillFrame.Visible, valueText.Visible = false, false end
                    wait()
                end
            end)
            slider:SetValue(slider.Value)
            section.InternalY = section.InternalY + 38; window:RelayoutTab(section.Tab)
            return slider
        end

        function section:AddDropdown(text, list, default, callback)
            local dp = {Value = default or list[1], List = list, Callback = callback, Open = false}
            local self_id = {}
            local label = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = text, Size = 13, Color = theme.Text, Font = 2, Visible = self.Frame.Visible, ZIndex = 12})
            local dropFrame = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Button, Size = Vector2.new(section.Width - 20, 22), Corner = 4, Visible = self.Frame.Visible, ZIndex = 12})
            local dropText = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = dp.Value, Size = 13, Color = theme.TextDark, Center = true, Font = 2, Visible = self.Frame.Visible, ZIndex = 13})
            local container = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Section, Size = Vector2.new(section.Width - 20, #list * 20 + 10), Corner = 4, Visible = false, ZIndex = 50})
            local items = {}

            local function clearItems() for _, it in ipairs(items) do it.Obj:Remove() end items = {} end
            local function createItems()
                clearItems()
                for i, val in ipairs(dp.List) do
                    local itemText = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = val, Size = 12, Color = (val == dp.Value and theme.Accent or theme.Text), Center = true, Font = 2, Visible = false, ZIndex = 51})
                    table.insert(items, {Obj = itemText, Value = val})
                    table.insert(section.ContentDrawings, {Obj = itemText, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,11970,11655,11760,10500,11655,12495,11550,8400,10185,11970,12180})})
                end
                container.Size = Vector2.new(section.Width - 20, #dp.List * 20 + 10)
            end

            function dp:SetValue(val)
                self.Value = val
                dropText.Text = self.Value
                for _, it in ipairs(items) do it.Obj.Color = (it.Value == self.Value and theme.Accent or theme.Text) end
                self.Callback(self.Value)
            end
            function dp:Refresh(newList) self.List = newList; createItems() end

            createItems()
            table.insert(section.ContentDrawings, {Obj = label, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7980,10185,10290,10605,11340}), Height = 18})
            table.insert(section.ContentDrawings, {Obj = dropFrame, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6930,12285,12180,12180,11655,11550,7350,11970,10185,11445,10605}), Height = 26})
            table.insert(section.ContentDrawings, {Obj = dropText, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6930,12285,12180,12180,11655,11550,8820,10605,12600,12180}), Center = true})
            table.insert(section.ContentDrawings, {Obj = container, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,11970,11655,11760,10500,11655,12495,11550,8400,10185,11970,12180})})

            spawn(function()
                local wasM1 = false
                while true do
                    if section.Frame.Visible and window.CurrentTab == section.Tab and Arcane.IsOpen then
                        local m1 = ismouse1pressed()
                        local over = isMouseOver(dropFrame.Position, dropFrame.Size)
                        if m1 and not wasM1 then
                            if over then
                                if OpenDropdown == self_id then dp.Open = false; OpenDropdown = nil
                                elseif OpenDropdown == nil then dp.Open = true; OpenDropdown = self_id end
                            elseif dp.Open and not isMouseOver(container.Position, container.Size) then
                                dp.Open = false; if OpenDropdown == self_id then OpenDropdown = nil end
                            end
                        end
                        container.Visible = dp.Open
                        container.Position = dropFrame.Position + Vector2.new(0, 24)
                        
                        for i, item in ipairs(items) do
                            item.Obj.Visible = dp.Open
                            item.Obj.Position = container.Position + Vector2.new(container.Size.X/2, 8 + (i-1)*18)
                            if dp.Open and m1 and not wasM1 and isMouseOver(item.Obj.Position - Vector2.new(container.Size.X/2, 6), Vector2.new(container.Size.X, 16)) then
                                dp:SetValue(item.Value)
                                dp.Open = false
                                OpenDropdown = nil
                            end
                        end
                        wasM1 = m1
                    else dp.Open = false; if OpenDropdown == self_id then OpenDropdown = nil end; container.Visible = false end
                    wait()
                end
            end)
            section.InternalY = section.InternalY + 44; window:RelayoutTab(section.Tab)
            return dp
        end

        function section:AddKeybind(text, defaultKeyName, callback, isMenuKey)
            local kb = {Key = KeyCodeNames[defaultKeyName] or 0x2D, Mode = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7560,11655,11340,10500}), Binding = false, Active = false, MenuOpen = false, Callback = callback}
            local label = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = text, Size = 13, Color = theme.Text, Font = 2, Visible = self.Frame.Visible, ZIndex = 12})
            
            local btnFrame = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Button, Size = Vector2.new(50, 16), Corner = 4, Visible = self.Frame.Visible, ZIndex = 12})
            local btnText = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = GetKeyName(kb.Key):lower(), Size = 11, Color = theme.Accent, Center = true, Font = 2, Visible = self.Frame.Visible, ZIndex = 13})
            
            local delFrame = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11865,12285,10185,11970,10605}), {Filled = true, Color = theme.Button, Size = Vector2.new(16, 16), Corner = 4, Visible = self.Frame.Visible, ZIndex = 12})
            local delText = Draw(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,10605,12600,12180}), {Text = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({9240}), Size = 11, Color = Color3.fromRGB(220, 60, 60), Center = true, Font = 2, Visible = self.Frame.Visible, ZIndex = 13})
            
            Insert(self.ContentDrawings, {Obj = label, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7980,10185,10290,10605,11340}), Height = 22})
            Insert(self.ContentDrawings, {Obj = btnFrame, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7875,10605,12705,10290,11025,11550,10500,7350,11970,10185,11445,10605}), Height = 0})
            Insert(self.ContentDrawings, {Obj = btnText, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7875,10605,12705,10290,11025,11550,10500,8820,10605,12600,12180}), Center = true})
            Insert(self.ContentDrawings, {Obj = delFrame, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,10605,11340,7875,10605,12705,10290,11025,11550,10500,7350,11970,10185,11445,10605}), Height = 0})
            Insert(self.ContentDrawings, {Obj = delText, Type = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,10605,11340,7875,10605,12705,10290,11025,11550,10500,8820,10605,12600,12180}), Center = true})

            function kb:SetValue(k) 
                self.Key = k
                if k == 0 then btnText.Text = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({11550,11655,11550,10605}) else btnText.Text = GetKeyName(self.Key):lower() end
            end

            local function updateActive()
                if isMenuKey then return end
                local isA = (kb.Mode == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6825,11340,12495,10185,12705,12075})) or kb.Active
                if kb.Key == 0 and kb.Mode ~= ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6825,11340,12495,10185,12705,12075}) then isA = false end
                ActiveKeybinds[text] = isA and kb.Mode or nil
                kb.Callback(isA)
            end

            spawn(function()
                local wasPressed = {}
                while true do
                    if kb.Key ~= 0 then
                        for name, kc in pairs(KeyCodeNames) do
                            if kc ~= 0 then
                                local down = iskeypressed(kc)
                                if down and not wasPressed[kc] then
                                    if kb.Binding then 
                                        if kc ~= 0x01 then kb:SetValue(kc); kb.Binding = false; btnFrame.Color = theme.Button end
                                    elseif kc == kb.Key then
                                        if isMenuKey then kb.Callback() else
                                            if kb.Mode == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7560,11655,11340,10500}) then kb.Active = true; updateActive() elseif kb.Mode == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,11655,10815,10815,11340,10605}) then kb.Active = not kb.Active; updateActive() end
                                        end
                                    end
                                elseif not down and wasPressed[kc] then
                                    if not isMenuKey and kc == kb.Key and kb.Mode == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7560,11655,11340,10500}) then kb.Active = false; updateActive() end
                                end
                                wasPressed[kc] = down
                            end
                        end
                    else
                        if kb.Binding then
                            for name, kc in pairs(KeyCodeNames) do
                                if kc ~= 0 then
                                    local down = iskeypressed(kc)
                                    if down and not wasPressed[kc] then
                                        if kc ~= 0x01 then kb:SetValue(kc); kb.Binding = false; btnFrame.Color = theme.Button end
                                    end
                                    wasPressed[kc] = down
                                end
                            end
                        end
                    end
                    wait()
                end
            end)

            spawn(function()
                local wasM1 = false
                while true do
                    if section.Frame.Visible and window.CurrentTab == section.Tab and Arcane.IsOpen then
                        local m1 = ismouse1pressed()
                        local overBtn = isMouseOver(btnFrame.Position, btnFrame.Size)
                        local overDel = isMouseOver(delFrame.Position, delFrame.Size)
                        
                        if not OpenDropdown then
                            if overBtn and m1 and not wasM1 then
                                kb.Binding = true; btnText.Text = ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({4830,4830,4830}); btnFrame.Color = theme.Section
                            end
                            if overDel and m1 and not wasM1 then
                                kb.Binding = false; kb:SetValue(0); kb.Active = false; updateActive(); btnFrame.Color = theme.Button
                            end
                            delFrame.Color = overDel and theme.Section or theme.Button
                        end
                        wasM1 = m1
                    else kb.Binding = false end
                    wait()
                end
            end)

            section.InternalY = section.InternalY + 22; window:RelayoutTab(section.Tab)
            return kb
        end

        Insert(self.Sections, section) return section
    end

    function window:RelayoutTab(TabName)
        local startX, startY, padding = 150, 25, 10
        local curX, curY, maxH = startX, startY, 0

        for _, s in ipairs(self.Sections) do
            if s.Tab == TabName then
                if curX + s.Width > self.Size.X - 10 then curX = startX; curY = curY + maxH + 25; maxH = 0 end
                s.Frame.Position = self.Pos + Vector2.new(curX, curY)
                s.Title.Position = s.Frame.Position + Vector2.new(6, -16)
                s.Line.Position = s.Frame.Position + Vector2.new(0, 2)
                
                local lY = 8
                local lastLabelPos, lastSquarePos, lastSquareSize = nil, nil, nil
                local lastDelPos, lastDelSize = nil, nil

                for _, item in ipairs(s.ContentDrawings) do
                    local d = item.Obj
                    if item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6930,12285,12180,12180,11655,11550,7350,11970,10185,11445,10605}) or item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,11340,11025,10500,10605,11970,7350,11970,10185,11445,10605}) then
                        d.Position = s.Frame.Position + Vector2.new(10, lY)
                        lastSquarePos, lastSquareSize = d.Position, d.Size
                        lY = lY + (item.Height or 26)
                    elseif item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7980,10185,10290,10605,11340}) then
                        d.Position = s.Frame.Position + Vector2.new(10, lY)
                        lastLabelPos = d.Position
                        lY = lY + (item.Height or 18)
                    elseif item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,11655,10815,10815,11340,10605,7350,11970,10185,11445,10605}) then
                        if lastLabelPos then d.Position = Vector2.new(s.Frame.Position.X + s.Width - d.Size.X - 10, lastLabelPos.Y) end
                    elseif item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6930,12285,12180,12180,11655,11550,8820,10605,12600,12180}) then
                        if item.Center and lastSquarePos then 
                            local textH = d.TextBounds.Y > 0 and d.TextBounds.Y or d.Size
                            d.Position = Vector2.new(lastSquarePos.X + (lastSquareSize.X / 2), lastSquarePos.Y + (lastSquareSize.Y / 2) - (textH / 2) + 2) 
                        end
                    elseif item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7875,10605,12705,10290,11025,11550,10500,7350,11970,10185,11445,10605}) then
                        if lastLabelPos then 
                            d.Position = Vector2.new(s.Frame.Position.X + s.Width - d.Size.X - 26, lastLabelPos.Y + 1)
                            lastSquarePos, lastSquareSize = d.Position, d.Size 
                        end
                    elseif item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7875,10605,12705,10290,11025,11550,10500,8820,10605,12600,12180}) then
                        if item.Center and lastSquarePos then 
                            local textH = d.TextBounds.Y > 0 and d.TextBounds.Y or d.Size
                            d.Position = Vector2.new(lastSquarePos.X + (lastSquareSize.X / 2), lastSquarePos.Y + (lastSquareSize.Y / 2) - (textH / 2) + 2) 
                        end
                    elseif item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,10605,11340,7875,10605,12705,10290,11025,11550,10500,7350,11970,10185,11445,10605}) then
                        if lastSquarePos then
                            d.Position = Vector2.new(lastSquarePos.X + lastSquareSize.X + 4, lastSquarePos.Y)
                            lastDelPos, lastDelSize = d.Position, d.Size
                        end
                    elseif item.Type == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,10605,11340,7875,10605,12705,10290,11025,11550,10500,8820,10605,12600,12180}) then
                        if item.Center and lastDelPos then
                            local textH = d.TextBounds.Y > 0 and d.TextBounds.Y or d.Size
                            d.Position = Vector2.new(lastDelPos.X + (lastDelSize.X / 2), lastDelPos.Y + (lastDelSize.Y / 2) - (textH / 2) + 2) 
                        end
                    end
                end
                s.Frame.Size = Vector2.new(s.Width, lY + 6)
                if s.Frame.Size.Y > maxH then maxH = s.Frame.Size.Y end
                curX = curX + s.Width + padding
            end
        end
    end

    spawn(function()
        local wasD, drag, dsm, dsp, dragK, dsmK, dspK = false, false, nil, nil, false, nil, nil
        while true do
            local d, mp = ismouse1pressed(), getMousePos()
            if Arcane.IsOpen then
                if d and not wasD and isMouseOver(window.Pos, Vector2.new(window.Size.X, 45)) then drag = true; dsm = mp; dsp = window.Pos end
                if not d then drag = false end
                if drag then window:Move((dsp + (mp - dsm)) - window.Pos) end
                
                for _, tab in tabs do
                    if isMouseOver(tab.Position, tab.Size) then
                        if window.CurrentTab ~= tab.Name then tab.Text.Color = Color3.fromRGB(180, 180, 190) end
                        if d and not wasD then 
                            for _, t in ipairs(tabs) do t.Text.Color = theme.TextDark end
                            tab.Text.Color = theme.Text; window.CurrentTab = tab.Name; window.TargetSelectorY = tab.RelativeY; window:UpdateVisibility() 
                        end
                    elseif window.CurrentTab ~= tab.Name then tab.Text.Color = theme.TextDark end
                end
            end
            window.CurrentSelectorY = lerp(window.CurrentSelectorY, window.TargetSelectorY, 0.15)
            window.GlobalSelector.Position = Vector2.new(window.Pos.X, window.Pos.Y + window.CurrentSelectorY)
            wasD = d; wait(0.01)
        end
    end)

    function window:Finalize()
        self:CreateTabSection(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,12705,12075,12180,10605,11445})); self:CreateTab(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,10605,12180,12180,11025,11550,10815,12075}))
        local s = self:CreateSection(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8085,10605,11550,12285}), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,10605,12180,12180,11025,11550,10815,12075}))
        s:AddLabel(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({9030,10605,11970,12075,11025,11655,11550,3360,9030,5145,4830,5145})); s:AddKeybind(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,10920,11655,12495,4935,7560,11025,10500,10605,3360,7455,12285,11025}), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7665,11550,12075,10605,11970,12180}), function() window:SetVisible(not Arcane.IsOpen) end, true)
        s:AddButton(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,10605,12075,12180,11970,11655,12705,3360,7665,11550,12180,10605,11970,10710,10185,10395,10605}), function() for _, v in ipairs(drawings) do v:Remove() end end)
        self:UpdateVisibility()
    end
    return window
end

local Window = Arcane:CreateWindow(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7770,12285,11340,11655,5145,5880,5460,5775}), Vector2.new(500, 320), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,10605,10710,10185,12285,11340,12180}))
Window:CreateTabSection(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8295,12285,12180,11025,11340,12075}))
local MainTab = Window:CreateTab(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8085,10185,11025,11550}))

local selectedTargetName = nil
local tpDistance = 4
local dropdown = nil

local function updatePlayerList()
    local newNames = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(newNames, plr.Name)
        end
    end
    table.sort(newNames, function(a, b) return a:lower() < b:lower() end)
    
    if dropdown then
        dropdown:Refresh(newNames)
    end
    return newNames
end

local function teleportBehind()
    if not selectedTargetName or selectedTargetName == ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({}) then
        notify(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6825,12285,10395,12285,11550,10605,3360,10395,11025,10290,11340,10605,3360,11550})a été sélectionnée.ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({4620,3360})ErreurubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({4620,3360,5355,4305,1365,1050,3360,3360,3360,3360,3360,3360,3360,3360,11970,10605,12180,12285,11970,11550,1365,1050,3360,3360,3360,3360,10605,11550,10500,1365,1050,1365,1050,3360,3360,3360,3360,11340,11655,10395,10185,11340,3360,12180,10185,11970,10815,10605,12180,8400,11340,10185,12705,10605,11970,3360,6405,3360,8400,11340,10185,12705,10605,11970,12075,6090,7350,11025,11550,10500,7350,11025,11970,12075,12180,7035,10920,11025,11340,10500,4200,12075,10605,11340,10605,10395,12180,10605,10500,8820,10185,11970,10815,10605,12180,8190,10185,11445,10605,4305,1365,1050,1365,1050,3360,3360,3360,3360,11025,10710,3360,12180,10185,11970,10815,10605,12180,8400,11340,10185,12705,10605,11970,3360,10185,11550,10500,3360,12180,10185,11970,10815,10605,12180,8400,11340,10185,12705,10605,11970,4830,7035,10920,10185,11970,10185,10395,12180,10605,11970,3360,10185,11550,10500,3360,12180,10185,11970,10815,10605,12180,8400,11340,10185,12705,10605,11970,4830,7035,10920,10185,11970,10185,10395,12180,10605,11970,6090,7350,11025,11550,10500,7350,11025,11970,12075,12180,7035,10920,11025,11340,10500,4200})HumanoidRootPartubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({4305,3360,12180,10920,10605,11550,1365,1050,3360,3360,3360,3360,3360,3360,3360,3360,11340,11655,10395,10185,11340,3360,11340,11655,10395,10185,11340,7035,10920,10185,11970,3360,6405,3360,7980,11655,10395,10185,11340,8400,11340,10185,12705,10605,11970,4830,7035,10920,10185,11970,10185,10395,12180,10605,11970,1365,1050,3360,3360,3360,3360,3360,3360,3360,3360,11025,10710,3360,11340,11655,10395,10185,11340,7035,10920,10185,11970,3360,10185,11550,10500,3360,11340,11655,10395,10185,11340,7035,10920,10185,11970,6090,7350,11025,11550,10500,7350,11025,11970,12075,12180,7035,10920,11025,11340,10500,4200})HumanoidRootPartubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({4305,3360,12180,10920,10605,11550,1365,1050,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,11340,11655,10395,10185,11340,3360,12180,10185,11970,10815,10605,12180,7560,8610,8400,3360,6405,3360,12180,10185,11970,10815,10605,12180,8400,11340,10185,12705,10605,11970,4830,7035,10920,10185,11970,10185,10395,12180,10605,11970,4830,7560,12285,11445,10185,11550,11655,11025,10500,8610,11655,11655,12180,8400,10185,11970,12180,1365,1050,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,11340,11655,10395,10185,11340,3360,11340,11655,10395,10185,11340,7560,8610,8400,3360,6405,3360,11340,11655,10395,10185,11340,7035,10920,10185,11970,4830,7560,12285,11445,10185,11550,11655,11025,10500,8610,11655,11655,12180,8400,10185,11970,12180,1365,1050,1365,1050,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,4725,4725,3360,8295,11550,3360,10185,11760,11760,11340,11025,11865,12285,10605,3360,11340,10185,3360,10500,11025,12075,12180,10185,11550,10395,10605,3360,10500,10605,11970,11970,11025,20475,17640,11970,10605,3360,11340,10605,3360,11130,11655,12285,10605,12285,11970,1365,1050,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,11340,11655,10395,10185,11340,7560,8610,8400,4830,7035,7350,11970,10185,11445,10605,3360,6405,3360,12180,10185,11970,10815,10605,12180,7560,8610,8400,4830,7035,7350,11970,10185,11445,10605,3360,4410,3360,7035,7350,11970,10185,11445,10605,4830,11550,10605,12495,4200,5040,4620,3360,5040,4620,3360,12180,11760,7140,11025,12075,12180,10185,11550,10395,10605,4305,1365,1050,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,11550,11655,12180,11025,10710,12705,4200})Téléporté derrière ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({3360,4830,4830,3360,12180,10185,11970,10815,10605,12180,8400,11340,10185,12705,10605,11970,4830,8190,10185,11445,10605,4620,3360})SuccèsubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({4620,3360,5355,4305,1365,1050,3360,3360,3360,3360,3360,3360,3360,3360,10605,11340,12075,10605,1365,1050,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,3360,11550,11655,12180,11025,10710,12705,4200})Ton personnage nubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({10605,12075,12180,3360,11760,10185,12075,3360,11760,11970,20475,17850,12180,4830}), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7245,11970,11970,10605,12285,11970}), 3)
        end
    else
        notify(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7980,10605,3360,11130,11655,12285,10605,12285,11970,3360,10395,11025,10290,11340,20475,17745,3360,10605,12075,12180,3360,11025,11550,12180,11970,11655,12285,12390,10185,10290,11340,10605,3360,11655,12285,3360,11445,11655,11970,12180,4830}), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7245,11970,11970,10605,12285,11970}), 3)
    end
end

local targetSection = Window:CreateSection(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7035,11025,10290,11340,10185,10815,10605}), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8085,10185,11025,11550}))

dropdown = targetSection:AddDropdown(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7035,10920,11655,11025,12075,11025,11970,3360,12285,11550,3360,11130,11655,12285,10605,12285,11970}), updatePlayerList(), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({}), function(selected)
    selectedTargetName = selected
end)

targetSection:AddTextBox(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8610,10605,10395,10920,10605,11970,10395,10920,10605,3360,4200,8400,12075,10605,12285,10500,11655,4305}), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({}), function(text)
    if text and text ~= ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({}) then
        local found = false
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and string.find(p.Name:lower(), text:lower()) then
                selectedTargetName = p.Name
                dropdown:SetValue(p.Name)
                notify(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7035,11025,10290,11340,10605,3360,12390,10605,11970,11970,11655,12285,11025,11340,11340,20475,17745,10605,3360,6090,3360}) .. p.Name, ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8610,10605,10395,10920,10605,11970,10395,10920,10605}), 2)
                found = true
                break
            end
        end
        if not found then
            notify(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6825,12285,10395,12285,11550,3360,11130,11655,12285,10605,12285,11970,3360,12180,11970,11655,12285,12390,20475,17745,4830}), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8610,10605,10395,10920,10605,11970,10395,10920,10605}), 2)
        end
    end
end)

targetSection:AddButton(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6825,10395,12180,12285,10185,11340,11025,12075,10605,11970,3360,11340,10185,3360,11340,11025,12075,12180,10605}), function()
    updatePlayerList()
    notify(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7980,11025,12075,12180,10605,3360,10500,10605,12075,3360,11130,11655,12285,10605,12285,11970,12075,3360,11445,11025,12075,10605,3360,20475,16800,3360,11130,11655,12285,11970,4830}), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6825,10395,12180,12285,10185,11340,11025,12075,10185,12180,11025,11655,11550}), 2)
end)

local actionSection = Window:CreateSection(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({6825,10395,12180,11025,11655,11550}), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8085,10185,11025,11550}))

actionSection:AddSlider(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7140,11025,12075,12180,10185,11550,10395,10605,3360,10185,11970,11970,11025,20475,17640,11970,10605,3360,4200,8715,12180,12285,10500,12075,4305}), {Min = 1, Max = 15, Default = 4, Callback = function(v)
    tpDistance = v
end})

actionSection:AddButton(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8715,7245,3360,8820,20475,14385,7980,20475,14385,8400,8295,8610,8820,7245,8610}), function()
    teleportBehind()
end)

(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350}) par défaut)
actionSection:AddKeybind(ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({8820,11655,12285,10395,10920,10605,3360,10500,10605,3360,8820,8400,3360,11970,10185,11760,11025,10500,10605}), ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({7350}), function()
    teleportBehind()
end, true)

Players.PlayerAdded:Connect(function() updatePlayerList() end)
Players.PlayerRemoving:Connect(function() updatePlayerList() end)

(Affiche lubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({11025,11550,12180,10605,11970,10710,10185,10395,10605,4305,1365,1050,9135,11025,11550,10500,11655,12495,6090,7350,11025,11550,10185,11340,11025,12810,10605,4200,4305,1365,1050,11550,11655,12180,11025,10710,12705,4200})Menu de TP prêt (Touche INSER pour cacher)ubKERhCbbpoDjorJJcHuOwhasEyzSXIHCDHnsfRZNPQiuskNBEIGwKMBogwziOOSQgNPMtvnLiwwkvMB({4620,3360})Système', 4)    