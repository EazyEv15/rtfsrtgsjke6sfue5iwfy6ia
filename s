game.StarterGui:SetCore("SendNotification", {
	Title = "eazy admin", 
	Text = "loaded",
	Duration = 5
})
local Player = game.Players.LocalPlayer
print("eazy admin yay")
function notify(title,text,duration)
	game.StarterGui:SetCore("SendNotification", {
		Title = title or "", 
		Text = text or "",
		Duration = duration or 5
	})
end

local knownCmds = {}

local function isCmd(cmd, aliases)
	for _, alias in ipairs(aliases) do
		if not knownCmds[alias] then
			knownCmds[alias] = true
		end
		if cmd == alias then
			return true
		end
	end
	return false
end

local Players = game:GetService("Players")
local player = Player

local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "eazy-admin"
ScreenGui.ResetOnSpawn = false

local TextBox = Instance.new("TextBox", ScreenGui)
TextBox.Size = UDim2.new(0.5, 0, 0, 30)
TextBox.Position = UDim2.new(0.25, 0, 0.95, -40)
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.PlaceholderText = ";command"
TextBox.ClearTextOnFocus = false
TextBox.Text = ""
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 18
TextBox.BorderSizePixel = 0
local touchflingEnabled = false
local touchflingThread

TextBox.FocusLost:Connect(function(enterPressed)
	if not enterPressed then return end

	local msg = TextBox.Text
	TextBox.Text = ""

	if string.sub(msg, 1, 1) ~= ";" then return end

	local args = msg:sub(2):lower():split(" ")
	local cmd = args[1]
	if isCmd(cmd, {"save"}) then
		saveinstance()
	elseif isCmd(cmd, {"discord"}) then
		notify("hi", "copied to clipboard")
		setclipboard("https://discord.gg/FVtJcwKpVB")
	elseif isCmd(cmd, {"suicidegun"}) then
		-- made by bobby
		local ReplicatedStorage = game.ReplicatedStorage
		local TextChatService = game:GetService("TextChatService")
		isLegacyChat = TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService
		local function chat(text)
			if not isLegacyChat then
				TextChatService.TextChannels.RBXGeneral:SendAsync(text)
			else
				ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
			end
		end

		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://28492456"
		local animation2 = Instance.new("Animation")
		animation2.AnimationId = "rbxassetid://181526230"

		local track = Player.Character.Humanoid:LoadAnimation(animation)
		track:Play()
		track:AdjustSpeed(.5)
		wait(1.1)
		track:AdjustSpeed(0)
		wait(.75)
		chat("See you on the other side.")
		wait(1.5)
		track:Stop()
		local track2 = Player.Character.Humanoid:LoadAnimation(animation2)
		track2:Play()
		track2:AdjustSpeed(10000)
		task.wait(.25)
		Player.Character.Head:Destroy()
	elseif isCmd(cmd, {"controlnpc"}) then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty38.lua"))()
	elseif isCmd(cmd, {"permadeath"}) then
		if replicatesignal then do
				replicatesignal(Player.ConnectDiedSignalBackend)
				task.wait(Players.RespawnTime + 0.20)
				notify("done", "loaded", 5)
			end
		else
			notify("error", "permadeath not supported on yo executor", 5)
		end
	elseif isCmd(cmd, {"unpermadeath"}) then
		replicatesignal(Player.ConnectDiedSignalBackend)
	elseif isCmd(cmd, {"babft"}) then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/TheRealAsu/BABFT/refs/heads/main/Jan25_Source.lua'))()
		local triggerbotConnection
	elseif isCmd(cmd, {"triggerbot"}) then
		local m = Player:GetMouse()
		local rs = game:GetService("RunService")

		local function aimAtTarget(t)
			if t and t.Parent then
				local character = t.Parent
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					return (character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso")) and character.Head.Position
				end
			end
		end

		if triggerbotConnection then
			triggerbotConnection:Disconnect()
		end

		triggerbotConnection = rs.RenderStepped:Connect(function()
			local t = m.Target
			if t and aimAtTarget(t) then
				mouse1press()
				mouse1release()
			end
		end)

	elseif isCmd(cmd, {"untriggerbot"}) then
		if triggerbotConnection then
			triggerbotConnection:Disconnect()
			triggerbotConnection = nil
		end
	elseif isCmd(cmd, {"audiologger"}) then
		aa = game:GetObjects("rbxassetid://01997056190")[1]
		aa.Parent = game.CoreGui
		wait(0.2)
		GUI = aa.PopupFrame.PopupFrame
		pos = 0

		ignore = {
			"rbxasset://sounds/action_get_up.mp3",
			"rbxasset://sounds/uuhhh.mp3",
			"rbxasset://sounds/action_falling.mp3",
			"rbxasset://sounds/action_jump.mp3",
			"rbxasset://sounds/action_jump_land.mp3",
			"rbxasset://sounds/impact_water.mp3",
			"rbxasset://sounds/action_swim.mp3",
			"rbxasset://sounds/action_footsteps_plastic.mp3"
		}

		GUI.Close.MouseButton1Click:connect(function()
			GUI:TweenSize(UDim2.new(0, 360, 0, 0),"Out","Quad",0.5,true) wait(0.6)
			GUI.Parent:TweenSize(UDim2.new(0, 0, 0, 20),"Out","Quad",0.5,true) wait(0.6)
			aa:Destroy()
		end)

		local min = false
		GUI.Minimize.MouseButton1Click:connect(function()
			if min == false then
				GUI:TweenSize(UDim2.new(0, 360, 0, 20),"Out","Quad",0.5,true) min = true
			else
				GUI:TweenSize(UDim2.new(0, 360, 0, 260),"Out","Quad",0.5,true) min = false
			end
		end)

		function printTable(tbl)
			if type(tbl) ~= 'table' then return nil end
			local depthCount = -15

			local function run(val, inPrefix)
				depthCount = depthCount + 15
				-- if inPrefix then print(string.rep(' ', depthCount) .. '{') end
				for i,v in pairs(val) do
					if type(v) == 'table' then
						-- print(string.rep(' ', depthCount) .. ' [' .. tostring(i) .. '] = {')
						GUI.Store.Text = GUI.Store.Text..'\n'..string.rep(' ', depthCount) .. ' [' .. tostring(i) .. '] = {'
						run(v, false)
						wait()
					else
						-- print(string.rep(' ', depthCount) .. ' [' .. tostring(i) .. '] = ' .. tostring(v))
						GUI.Store.Text = GUI.Store.Text..'\n'..string.rep(' ', depthCount) .. ' [' .. tostring(i) .. '] = ' .. tostring(v)
						wait()
					end
				end
				-- print(string.rep(' ', depthCount) .. '}')
				depthCount = depthCount - 15
			end
			run(tbl, true)
		end

		function refreshlist()
			pos = 0
			GUI.Logs.CanvasSize = UDim2.new(0,0,0,0)
			for i,v in pairs(GUI.Logs:GetChildren()) do
				v.Position = UDim2.new(0,0,0, pos)
				GUI.Logs.CanvasSize = UDim2.new(0,0,0, pos+20)
				pos = pos+20
			end
		end

		function FindTable(Table, Name)
			for i,v in pairs(Table) do
				if v == Name then
					return true
				end end
			return false
		end

		function writefileExploit()
			if writefile then
				return true
			end
		end

		writeaudio = {}
		running = false
		GUI.SS.MouseButton1Click:connect(function()
			if writefileExploit() then
				if running == false then
					GUI.Load.Visible = true running = true
					GUI.Load:TweenSize(UDim2.new(0, 360, 0, 20),"Out","Quad",0.5,true) wait(0.3)
					for _, child in pairs(GUI.Logs:GetChildren()) do
						if child:FindFirstChild('ImageButton') then local bttn = child:FindFirstChild('ImageButton')
							if bttn.BackgroundTransparency == 0 then
								writeaudio[#writeaudio + 1] = {NAME = child.NAME.Value, ID = child.ID.Value}
							end
						end
					end
					GUI.Store.Visible = true
					printTable(writeaudio)
					wait(0.2)
					local filename = 0
					local function write()
						local file
						pcall(function() file = readfile("Audios"..filename..".txt") end)
						if file then
							filename = filename+1
							write()
						else
							local text = tostring(GUI.Store.Text)
							text = text:gsub('\n', '\r\n')
							writefile("Audios"..filename..".txt", text)
						end
					end
					write()
					for rep = 1,10 do
						GUI.Load.BackgroundTransparency = GUI.Load.BackgroundTransparency + 0.1
						wait(0.05)
					end
					GUI.Load.Visible = false
					GUI.Load.BackgroundTransparency = 0
					GUI.Load.Size = UDim2.new(0, 0, 0, 20)
					running = false
					GUI.Store.Visible = false
					GUI.Store.Text = ''
					writeaudio = {}
					game:FindService('StarterGui'):SetCore('SendNotification', {
						Title = 'Audio Logger',
						Text = 'Saved audios\n(Audios'..filename..'.txt)',
						Icon = 'http://www.roblox.com/asset/?id=176572847',
						Duration = 5,
					})
				end
			else
				game:FindService('StarterGui'):SetCore('SendNotification', {
					Title = 'Audio Logger',
					Text = 'Exploit cannot writefile :(',
					Icon = 'http://www.roblox.com/asset/?id=176572847',
					Duration = 5,
				})
			end
		end)

		GUI.SA.MouseButton1Click:connect(function()
			if writefileExploit() then
				if running == false then
					GUI.Load.Visible = true running = true
					GUI.Load:TweenSize(UDim2.new(0, 360, 0, 20),"Out","Quad",0.5,true) wait(0.3)
					for _, child in pairs(GUI.Logs:GetChildren()) do
						writeaudio[#writeaudio + 1] = {NAME = child.NAME.Value, ID = child.ID.Value}
					end
					GUI.Store.Visible = true
					printTable(writeaudio)
					wait(0.2)
					local filename = 0
					local function write()
						local file
						pcall(function() file = readfile("Audios"..filename..".txt") end)
						if file then
							filename = filename+1
							write()
						else
							local text = tostring(GUI.Store.Text)
							text = text:gsub('\n', '\r\n')
							writefile("Audios"..filename..".txt", text)
						end
					end
					write()
					for rep = 1,10 do
						GUI.Load.BackgroundTransparency = GUI.Load.BackgroundTransparency + 0.1
						wait(0.05)
					end
					GUI.Load.Visible = false
					GUI.Load.BackgroundTransparency = 0
					GUI.Load.Size = UDim2.new(0, 0, 0, 20)
					running = false
					GUI.Store.Visible = false
					GUI.Store.Text = ''
					writeaudio = {}
					game:FindService('StarterGui'):SetCore('SendNotification', {
						Title = 'Audio Logger',
						Text = 'Saved audios\n(Audios'..filename..'.txt)',
						Icon = 'http://www.roblox.com/asset/?id=176572847',
						Duration = 5,
					})
				end
			else
				game:FindService('StarterGui'):SetCore('SendNotification', {
					Title = 'Audio Logger',
					Text = 'Exploit cannot writefile :(',
					Icon = 'http://www.roblox.com/asset/?id=176572847',
					Duration = 5,
				})
			end
		end)

		selectedaudio = nil
		function getaudio(place)
			if running == false then
				GUI.Load.Visible = true running = true
				GUI.Load:TweenSize(UDim2.new(0, 360, 0, 20),"Out","Quad",0.5,true) wait(0.3)
				for _, child in pairs(place:GetDescendants()) do
					spawn(function()
						if child:IsA("Sound") and not GUI.Logs:FindFirstChild(child.SoundId) and not FindTable(ignore,child.SoundId) then
							local id = string.match(child.SoundId, "rbxasset://sounds.+") or string.match(child.SoundId, "&hash=.+") or string.match(child.SoundId, "%d+")
							if id ~= nil then		
								local newsound = GUI.Audio:Clone()
								if string.sub(id, 1, 6) == "&hash=" or string.sub(id, 1, 7) == "&0hash=" then
									id = string.sub(id, (string.sub(id, 1, 6) == "&hash=" and 7) or (string.sub(id, 1, 7) == "&0hash=" and 8), string.len(id))
									newsound.ImageButton.Image = 'rbxassetid://1453863294'
								end
								newsound.Parent = GUI.Logs
								newsound.Name = child.SoundId
								newsound.Visible = true
								newsound.Position = UDim2.new(0,0,0, pos)
								GUI.Logs.CanvasSize = UDim2.new(0,0,0, pos+20)
								pos = pos+20
								local function findname()
									Asset = game:GetService("MarketplaceService"):GetProductInfo(id)
								end
								local audioname = 'error'
								local success, message = pcall(findname)
								if success then
									newsound.TextLabel.Text = Asset.Name
									audioname = Asset.Name
								else
									newsound.TextLabel.Text = child.Name
									audioname = child.Name
								end
								local data = Instance.new('StringValue') data.Parent = newsound data.Value = child.SoundId data.Name = 'ID'
								local data2 = Instance.new('StringValue') data2.Parent = newsound data2.Value = audioname data2.Name = 'NAME'
								local soundselected = false
								newsound.ImageButton.MouseButton1Click:Connect(function()
									if GUI.Info.Visible ~= true then
										if soundselected == false then soundselected = true
											newsound.ImageButton.BackgroundTransparency = 0
										else soundselected = false
											newsound.ImageButton.BackgroundTransparency = 1
										end
									end
								end)
								newsound.Click.MouseButton1Click:Connect(function()
									if GUI.Info.Visible ~= true then
										GUI.Info.TextLabel.Text = "Name: " ..audioname.. "\n\nID: " .. child.SoundId .. "\n\nWorkspace Name: " .. child.Name
										selectedaudio = child.SoundId
										GUI.Info.Visible = true
									end
								end)
							end
						end
					end)
				end
			end
			for rep = 1,10 do
				GUI.Load.BackgroundTransparency = GUI.Load.BackgroundTransparency + 0.1
				wait(0.05)
			end
			GUI.Load.Visible = false
			GUI.Load.BackgroundTransparency = 0
			GUI.Load.Size = UDim2.new(0, 0, 0, 20)
			running = false
		end

		GUI.All.MouseButton1Click:connect(function() getaudio(game)end)
		GUI.Workspace.MouseButton1Click:connect(function() getaudio(workspace)end)
		GUI.Lighting.MouseButton1Click:connect(function() getaudio(game:GetService('Lighting'))end)
		GUI.SoundS.MouseButton1Click:connect(function() getaudio(game:GetService('SoundService'))end)
		GUI.Clr.MouseButton1Click:connect(function()
			for _, child in pairs(GUI.Logs:GetChildren()) do
				if child:FindFirstChild('ImageButton') then local bttn = child:FindFirstChild('ImageButton')
					if bttn.BackgroundTransparency == 1 then
						bttn.Parent:Destroy()
						refreshlist()
					end
				end
			end
		end)
		GUI.ClrS.MouseButton1Click:connect(function()
			for _, child in pairs(GUI.Logs:GetChildren()) do
				if child:FindFirstChild('ImageButton') then local bttn = child:FindFirstChild('ImageButton')
					if bttn.BackgroundTransparency == 0 then
						bttn.Parent:Destroy()
						refreshlist()
					end
				end
			end
		end)
		autoscan = false
		GUI.AutoScan.MouseButton1Click:connect(function()
			if autoscan == false then autoscan = true
				GUI.AutoScan.BackgroundTransparency = 0.5
				game:FindService('StarterGui'):SetCore('SendNotification', {
					Title = 'Audio Logger',
					Text = 'Auto Scan ENABLED',
					Icon = 'http://www.roblox.com/asset/?id=176572847',
					Duration = 5,
				})
			else autoscan = false
				GUI.AutoScan.BackgroundTransparency = 0
				game:FindService('StarterGui'):SetCore('SendNotification', {
					Title = 'Audio Logger',
					Text = 'Auto Scan DISABLED',
					Icon = 'http://www.roblox.com/asset/?id=176572847',
					Duration = 5,
				})
			end
		end)

		game.DescendantAdded:connect(function(added)
			wait()
			if autoscan == true and added:IsA('Sound') and not GUI.Logs:FindFirstChild(added.SoundId) and not FindTable(ignore,added.SoundId) then
				local id = string.match(added.SoundId, "rbxasset://sounds.+") or string.match(added.SoundId, "&hash=.+") or string.match(added.SoundId, "%d+")
				if id ~= nil then		
					local newsound = GUI.Audio:Clone()
					if string.sub(id, 1, 6) == "&hash=" or string.sub(id, 1, 7) == "&0hash=" then
						id = string.sub(id, (string.sub(id, 1, 6) == "&hash=" and 7) or (string.sub(id, 1, 7) == "&0hash=" and 8), string.len(id))
						newsound.ImageButton.Image = 'rbxassetid://1453863294'
					end
					local scrolldown = false
					newsound.Parent = GUI.Logs
					newsound.Name = added.SoundId
					newsound.Visible = true
					newsound.Position = UDim2.new(0,0,0, pos)
					if GUI.Logs.CanvasPosition.Y == GUI.Logs.CanvasSize.Y.Offset - 230 then
						scrolldown = true
					end
					GUI.Logs.CanvasSize = UDim2.new(0,0,0, pos+20)
					pos = pos+20
					local function findname()
						Asset = game:GetService("MarketplaceService"):GetProductInfo(id)
					end
					local audioname = 'error'
					local success, message = pcall(findname)
					if success then
						newsound.TextLabel.Text = Asset.Name
						audioname = Asset.Name
					else 
						newsound.TextLabel.Text = added.Name
						audioname = added.Name
					end
					local data = Instance.new('StringValue') data.Parent = newsound data.Value = added.SoundId data.Name = 'ID'
					local data2 = Instance.new('StringValue') data2.Parent = newsound data2.Value = audioname data2.Name = 'NAME'
					local soundselected = false
					newsound.ImageButton.MouseButton1Click:Connect(function()
						if GUI.Info.Visible ~= true then
							if soundselected == false then soundselected = true
								newsound.ImageButton.BackgroundTransparency = 0
							else soundselected = false
								newsound.ImageButton.BackgroundTransparency = 1
							end
						end
					end)
					newsound.Click.MouseButton1Click:Connect(function()
						if GUI.Info.Visible ~= true then
							GUI.Info.TextLabel.Text = "Name: " ..audioname.. "\n\nID: " .. added.SoundId .. "\n\nWorkspace Name: " .. added.Name
							selectedaudio = added.SoundId
							GUI.Info.Visible = true
						end
					end)
					--230'
					if scrolldown == true then
						GUI.Logs.CanvasPosition = Vector2.new(0, 9999999999999999999999999999999999999999999, 0, 0)
					end
				end
			end
		end)

		GUI.Info.Copy.MouseButton1Click:Connect(function()
			if pcall(function() Synapse:Copy(selectedaudio) end) then	
			else
				local clip = setclipboard or Clipboard.set
				clip(selectedaudio)
			end
			game:FindService('StarterGui'):SetCore('SendNotification', {
				Title = 'Audio Logger',
				Text = 'Copied to clipboard',
				Icon = 'http://www.roblox.com/asset/?id=176572847',
				Duration = 5,
			})
		end)

		GUI.Info.Close.MouseButton1Click:Connect(function()
			GUI.Info.Visible = false
			for _, sound in pairs(game:GetService('Players').LocalPlayer.PlayerGui:GetChildren()) do
				if sound.Name == 'SampleSound' then
					sound:Destroy()
				end
			end
			GUI.Info.Listen.Text = 'Listen'
		end)

		GUI.Info.Listen.MouseButton1Click:Connect(function()
			if GUI.Info.Listen.Text == 'Listen' then
				local samplesound = Instance.new('Sound') samplesound.Parent = game:GetService('Players').LocalPlayer.PlayerGui
				samplesound.Looped = true samplesound.SoundId = selectedaudio samplesound:Play() samplesound.Name = 'SampleSound'
				samplesound.Volume = 5
				GUI.Info.Listen.Text = 'Stop'
			else
				for _, sound in pairs(game:GetService('Players').LocalPlayer.PlayerGui:GetChildren()) do
					if sound.Name == 'SampleSound' then
						sound:Destroy()
					end
				end
				GUI.Info.Listen.Text = 'Listen'
			end
		end)

		function drag(gui)
			spawn(function()
				local UserInputService = game:GetService("UserInputService")
				local dragging
				local dragInput
				local dragStart
				local startPos
				local function update(input)
					local delta = input.Position - dragStart
					gui:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), "InOut", "Quart", 0.04, true, nil) 
				end
				gui.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						dragStart = input.Position
						startPos = gui.Position
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
							end
						end)
					end
				end)
				gui.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if input == dragInput and dragging then
						update(input)
					end
				end)
			end)
		end
		drag(aa.PopupFrame)
	elseif isCmd(cmd, {"stretchres"}) then
		loadstring(game:HttpGet("https://pastebin.com/raw/bBAdTbBC"))()
	elseif isCmd(cmd, {"antipush"}) then
		local a = game:GetService("ReplicatedStorage")
		local b = Player
		local c = b.Character:WaitForChild("Humanoid")
		local d = a:WaitForChild("RemoteEvents"):WaitForChild("PushEvent")

		c.StateChanged:Connect(function(_, e)
			if e == Enum.HumanoidStateType.Physics then
				c:ChangeState(Enum.HumanoidStateType.GettingUp)
			elseif e == Enum.HumanoidStateType.GettingUp then
				c.AutoRotate = true
			end
		end)

		d.OnClientEvent:Connect(function()
			local f = b.Character
			local g = f:FindFirstChildOfClass("Humanoid")
			local h = f:FindFirstChild("Animate")
			if h then
				h.Enabled = false
				h.Enabled = true
			end
			if g then
				for _, i in g:GetPlayingAnimationTracks() do
					i:Stop()
				end
			end
		end)
	elseif isCmd(cmd, {"camlock"}) then
		local Players, RunService, UIS, Workspace = Players, game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("Workspace")
		local LocalPlayer, Camera, Mouse = Player, Workspace.CurrentCamera, Player:GetMouse()
		local Target, Locking = nil, false

		local function getClosest()
			local closest, dist, mousePos = nil, math.huge, Vector2.new(Mouse.X, Mouse.Y)
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= LocalPlayer and p.Character then
					local hrp, hum = p.Character:FindFirstChild("HumanoidRootPart"), p.Character:FindFirstChildWhichIsA("Humanoid")
					if hrp and hum and hum.Health > 0 then
						local pos, vis = Camera:WorldToScreenPoint(hrp.Position)
						local mag = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
						if vis and mag < dist then
							dist, closest = mag, p
						end
					end
				end
			end
			return closest
		end

		UIS.InputBegan:Connect(function(i, g)
			if not g and i.KeyCode == Enum.KeyCode.Nine then
				Target, Locking = Locking and nil or getClosest(), not Locking
			end
		end)

		RunService.RenderStepped:Connect(function()
			if Locking and Target and Target.Character then
				local hrp, hum = Target.Character:FindFirstChild("HumanoidRootPart"), Target.Character:FindFirstChildWhichIsA("Humanoid")
				if hrp and hum and hum.Health > 0 then
					Camera.CFrame = CFrame.new(Camera.CFrame.Position, hrp.Position)
				else
					Target, Locking = nil, false
				end
			end
		end)
	elseif isCmd(cmd, {"speed"}) then
		local amount = tonumber(args[2])
		if amount then
			local hum = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
			if hum then
				hum.WalkSpeed = amount
			end
		end
	elseif isCmd(cmd, {"esp"}) then
		local function applyESP(player)
			if player == Player then return end

			local function onCharacterAdded(char)
				if not char:FindFirstChild("ESP_Highlight") then
					local highlight = Instance.new("Highlight")
					highlight.Name = "ESP_Highlight"
					highlight.FillColor = Color3.new(1, 0, 0)
					highlight.OutlineColor = Color3.new(1, 1, 1)
					highlight.FillTransparency = 0.5
					highlight.OutlineTransparency = 0
					highlight.Adornee = char
					highlight.Parent = char
				end
			end

			if player.Character then onCharacterAdded(player.Character) end
			player.CharacterAdded:Connect(onCharacterAdded)
		end

		for _, player in ipairs(Players:GetPlayers()) do
			applyESP(player)
		end

		if not _G.espHooked then
			_G.espHooked = true
			Players.PlayerAdded:Connect(applyESP)
		end
	elseif isCmd(cmd, {"unesp"}) then
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= Player and player.Character then
				local esp = player.Character:FindFirstChild("ESP_Highlight")
				if esp then esp:Destroy() end
			end
		end
	elseif isCmd(cmd, {"jerk"}) then
		loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
	elseif isCmd(cmd, {"animlogger"}) then
		loadstring(game:HttpGet("https://pastebin.com/raw/jWtPpjYY",true))()
	elseif isCmd(cmd, {"antilag"}) then
		for i, v in pairs(workspace:GetDescendants()) do
			if v:IsA("Decal") or v:IsA("Texture") then
				v:Destroy()
			end
		end
	elseif isCmd(cmd, {"fly"}) then
		local char = Player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if not hrp or _G.flying then return end

		_G.flying = true

		local bv = Instance.new("BodyVelocity")
		bv.Name = "FlyVelocity"
		bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
		bv.Velocity = Vector3.zero
		bv.Parent = hrp

		local bg = Instance.new("BodyGyro")
		bg.Name = "FlyGyro"
		bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
		bg.P = 10000
		bg.CFrame = hrp.CFrame
		bg.Parent = hrp

		local UIS = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")
		local flyKeys = {
			W = false, A = false, S = false, D = false,
			Space = false, LeftControl = false
		}

		local function updateVelocity()
			if not _G.flying then return end
			local cam = workspace.CurrentCamera
			local move = Vector3.zero
			if flyKeys.W then move += cam.CFrame.LookVector end
			if flyKeys.S then move -= cam.CFrame.LookVector end
			if flyKeys.A then move -= cam.CFrame.RightVector end
			if flyKeys.D then move += cam.CFrame.RightVector end
			if flyKeys.Space then move += cam.CFrame.UpVector end
			if flyKeys.LeftControl then move -= cam.CFrame.UpVector end

			if move.Magnitude > 0 then
				bv.Velocity = move.Unit * 50
			else
				bv.Velocity = Vector3.zero
			end

			bg.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.CFrame.LookVector)
		end

		_G.flyInputBegin = UIS.InputBegan:Connect(function(input, gpe)
			if gpe then return end
			local key = input.KeyCode.Name
			if flyKeys[key] ~= nil then flyKeys[key] = true end
		end)

		_G.flyInputEnd = UIS.InputEnded:Connect(function(input, gpe)
			if gpe then return end
			local key = input.KeyCode.Name
			if flyKeys[key] ~= nil then flyKeys[key] = false end
		end)

		_G.flyUpdate = RunService.RenderStepped:Connect(updateVelocity)
	elseif isCmd(cmd, {"unfly"}) then
		if not _G.flying then return end
		_G.flying = false

		local char = Player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hrp then
			if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
			if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
		end

		if _G.flyInputBegin then _G.flyInputBegin:Disconnect() end
		if _G.flyInputEnd then _G.flyInputEnd:Disconnect() end
		if _G.flyUpdate then _G.flyUpdate:Disconnect() end
	elseif isCmd(cmd, {"kartic"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		local genv = (getgenv and (getgenv() ~= getfenv()) and getgenv()) or _G
		local char = Player.Character or Player.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
		local simRadius = gethiddenproperty and gethiddenproperty(Player,"SimulationRadius")
		local requiredRadius = 20
		local isR15 = hum.RigType == Enum.HumanoidRigType.R15
		local forcefield = char:FindFirstChildOfClass("ForceField")
		local fakeHum = hum:Clone()
		local hrp = char:WaitForChild("HumanoidRootPart")
		local hrpCF = hrp.CFrame
		local stopAlign = false
		local stopAntiVoid = false
		local limbs = {}
		local hatHandles = {}
		local reanimConnections = {}

		runCommand("clip")

		if simRadius and simRadius < requiredRadius then
			repeat
				notify("Please wait",`Waiting for bigger SimulationRadius ({tostring(math.floor(simRadius))}/{tostring(requiredRadius)})`, 2)
				task.wait(2)
			until gethiddenproperty(Player,"SimulationRadius") >= requiredRadius
			if Player.Character == nil or Player.Character ~= char or hum.Parent == nil or hum.Health <= 0 then return end
		end

		if forcefield then forcefield:Destroy() end
		char.Archivable = true

		local rig = (not isR15) and char:Clone()

		if isR15 then
			local canGetObjects, loadedRig = pcall(function() return game:GetObjects("rbxassetid://18418211383")[1] end)
			local r6Rig = isTesting and rStorage:WaitForChild("R6Rig") or canGetObjects and loadedRig or loadstring(httpget("https://gist.githubusercontent.com/someunknowndude/ad264038a91f7fa11bec2f67dad3feaf/raw"))()
			local humDesc = players:GetCharacterAppearanceAsync(Player.UserId)
			local r6Head = r6Rig.Head
			local r15Head = char.Head
			local surfaceAppearance = r15Head:FindFirstChildOfClass("SurfaceAppearance")
			local face = r15Head:FindFirstChild("face")

			if surfaceAppearance then 
				surfaceAppearance:Clone().Parent = r6Head
			else
				--if face then r6Head.face.Texture = face.Texture end
				--r6Head.face.Transparency = 0
			end

			for i,v in pairs(r15Head:GetChildren()) do
				if not v:IsA("Attachment") then continue end
				v:Clone().Parent = r6Head
			end

			for i,v in pairs(humDesc:GetDescendants()) do
				if v:IsA("BodyColors") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic") then
					v.Parent = r6Rig
					continue
				end
				if v:IsA("Accessory") or v:IsA("Hat") then
					r6Rig:WaitForChild("Humanoid"):AddAccessory(v)
				end
			end


			rig = r6Rig
		else
			local mesh = char.Head:FindFirstChildOfClass("SpecialMesh")
			local face = char.Head:FindFirstChild("face")
			if mesh and face then
				delete(face)
			end
		end	

		local rigHRP = rig:WaitForChild("HumanoidRootPart")
		local rigHum = rig:FindFirstChild("Humanoid")

		rig.Name = "wacky reanim rig"


		for i,v in pairs(char:GetChildren()) do
			if not v:IsA("BasePart") then continue end
			table.insert(limbs, {v,rig[v.Name]})
		end


		local accessories = hum:GetAccessories()
		local rigAccessories = rigHum:GetAccessories()

		for i,v in pairs(accessories) do
			if not isR15 then
				table.insert(hatHandles,{v.Handle,rigAccessories[i].Handle})
				continue
			end
			for _,rigAcc in pairs(rigAccessories) do
				local handle = rigAcc.Handle
				local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle
				local texture = handle == mesh and mesh.TextureID or mesh.TextureId
				if not (rigAcc.Name == v.Name and mesh.MeshId == v.Handle.MeshId and texture == v.Handle.TextureID) then continue end
				table.insert(hatHandles,{v.Handle,rigAcc.Handle})
				continue 
			end
		end

		local clock = os and os.clock or tick
		local cos = math.cos
		local sin = math.sin
		local cfNew = CFrame.new
		local cfZero = CFrame.identity
		local v3New = Vector3.new
		local v3Zero = Vector3.zero

		local changedMaxSimRad = pcall(sethiddenproperty, Player, "MaximumSimulationRadius", 1000)
		local changedSimRad = pcall(sethiddenproperty, Player, "SimulationRadius", 1000)
		local netlessCF = cfZero
		local sineValue = 0


		local function align(part0, part1, offset)
			if stopAlign then return end
			if part0 and part0.Parent and part1 and part1.Parent then
				local part0_mass = part1.Mass * 5
				part0.AssemblyLinearVelocity = v3New(part1.AssemblyLinearVelocity.X * part0_mass, sineValue, part1.AssemblyLinearVelocity.Z * part0_mass)
				part0.AssemblyAngularVelocity = part1.AssemblyAngularVelocity

				if isnetworkowner(part0) then
					part0.CFrame = part1.CFrame * offset
				end
			end
		end

		local function setCamera(model)
			local oldCamCF = workspace.CurrentCamera.CFrame
			workspace.CurrentCamera.CameraSubject = model.Humanoid
			workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Once(function()
				workspace.CurrentCamera.CFrame = oldCamCF
			end)
		end

		local function disableCollisions(model,canTouchAndCast)
			for _, part in next, model:GetDescendants() do
				if part and part:IsA("BasePart") then
					part.CanCollide = false
					part.CanQuery = canTouchAndCast
					part.CanTouch = canTouchAndCast
				end
			end
		end

		local function makeTransparent(model)
			for i,v in pairs(model:GetDescendants()) do
				if not (v:IsA("BasePart") or v:IsA("Decal")) then continue end
				v.Transparency = 1
			end
		end

		local function breakJoints(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("JointInstance") then continue end
				delete(v)
			end
		end

		local function removeScripts(model)
			for i,v in pairs(model:GetChildren()) do
				if not (v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") or v.Name == "Animate") then continue end
				delete(v)
			end
		end

		local function removeTouchTriggers(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("TouchTransmitter") then continue end
				delete(v)
			end
		end

		local function onPostSim()
			for _, data in next, limbs do
				align(data[1], data[2],netlessCF)
			end

			for _, data in next, hatHandles do
				align(data[1], data[2], netlessCF)
			end
		end

		local function onPreSim()
			netlessCF = cfNew(0.01 * sin(clock()*16), 0, 0.01 * math.cos(clock()*16))
			sineValue = 40 - 3 * sin(clock()*10)

			if stopAntiVoid or rigHRP.Position.Y > (workspace.FallenPartsDestroyHeight + 50) then return end
			rigHRP.CFrame = hrpCF
			rigHRP.AssemblyLinearVelocity = v3Zero
			rigHRP.AssemblyAngularVelocity = v3Zero
		end


		rigHRP.CFrame = hrpCF
		rig.Parent = workspace
		Player.Character = rig
		setCamera(rig)
		rig.Animate.Enabled = false
		rig.Animate.Enabled = true
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		repeat task.wait() until limbs[3][1].CanCollide
		task.wait(0.05)
		delete(hum)
		repeat task.wait() until hum.Parent == nil
		task.wait()
		fakeHum.Parent = char
		task.wait()
		table.insert(reanimConnections, game:GetService("RunService").PreSimulation:Connect(onPreSim))
		table.insert(reanimConnections, game:GetService("RunService").PostSimulation:Connect(onPostSim))
		table.insert(reanimConnections, game:GetService("RunService").Stepped:Connect(function()
			disableCollisions(char,false)
			disableCollisions(rig,true)
		end))

		breakJoints(char)
		makeTransparent(char)
		removeScripts(char)
		removeTouchTriggers(char)

		genv.LoadLibrary = function(lib) return loadstring(httpget("https://raw.githubusercontent.com/Roblox/Core-Scripts/master/CoreScriptsRoot/Libraries/" .. lib .. ".lua"))() end

		local reset = Instance.new("BindableEvent")
		reset.Event:Connect(function()
			if stopAlign then
				local hum = character:FindFirstChildOfClass("Humanoid")
				if not hum then return character:BreakJoints() end
				hum.Health = 0
				return
			end
			notify("Resetting", "Please wait ~6 seconds", 6)
			stopAntiVoid = true
			rigHRP.Anchored = true
			rigHRP.CFrame = CFrame.new(0,workspace.FallenPartsDestroyHeight + 5,0)
			task.wait(0.5)
			stopAlign = true
			rigHum:ChangeState(Enum.HumanoidStateType.Dead)
			Player.CharacterAdded:Wait()
			rig:Destroy()
			for i,v in pairs(reanimConnections) do
				v:Disconnect()
			end
		end)

		game.StarterGui:SetCore("ResetButtonCallback", reset)

		notify("Success!", "reanim loaded!")
		local delete = delete or _G.delete
		Player = Player
		Character = Player.Character
		Character.Animate.Enabled = false
		PlayerGui = Player.PlayerGui
		Backpack = Player.Backpack
		Torso = Character.Torso
		Head = Character.Head
		Humanoid = Character.Humanoid
		LeftArm = Character["Left Arm"]
		LeftLeg = Character["Left Leg"]
		RightArm = Character["Right Arm"]
		RightLeg = Character["Right Leg"]
		LS = Torso["Left Shoulder"]
		LH = Torso["Left Hip"]
		RS = Torso["Right Shoulder"]
		RH = Torso["Right Hip"]
		Face = Head.face
		Neck = Torso.Neck
		it = Instance.new
		attacktype = 1
		attacktype2 = 1
		vt = Vector3.new
		cf = CFrame.new
		cn = CFrame.new
		euler = CFrame.fromEulerAnglesXYZ
		angles = CFrame.Angles
		necko = cf(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
		necko2 = cf(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
		LHC0 = cf(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		LHC1 = cf(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		RHC0 = cf(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
		RHC1 = cf(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
		RootPart = Character.HumanoidRootPart
		RootJoint = RootPart.RootJoint
		RootCF = euler(-1.57, 0, 3.14)
		attack = false
		attackdebounce = false
		trispeed = 0.2
		attackmode = "none"
		local idle = 0
		local Anim = "Idle"
		stance = false
		local ff = 2
		noleg = false
		evadecooldown = false
		Humanoid.Animator.Parent = nil
		equip = false
		Face.Texture = "http://www.roblox.com/asset/?id=0"
		attackspeed = 0.14
		df = false
		Swing = 1
		local sine = 0
		local change = 1
		local val = 0
		magic = false
		cam = workspace.CurrentCamera
		deb = game:GetService("Debris")
		--RbxUtility = --LoadLibrary("RbxUtility")
		Create = function(Instname)
			local obj = Instance.new(Instname)
			local func = function(tbl)
				for i,v in pairs(tbl) do
					obj[i] = v
				end
				return obj
			end
			return func
		end

		-- RbxUtility.Create
		local handee = Instance.new("Part")
		handee.Parent = Character
		handee.Size = Vector3.new(0.2, 0.2, 0.2)
		handee.Archivable = true
		handee.Transparency = 1
		handee.CanCollide = false
		handee.BrickColor = BrickColor.new("Cyan")
		handee.Material = "Neon"
		local handeeweld = Instance.new("Weld")
		handeeweld.Parent = handee
		handeeweld.Part0 = RightArm
		handeeweld.Part1 = handee
		handeeweld.C1 = CFrame.new(0, 0.96, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
		handeeweld.Part0 = RightArm
		function newWeld(wp0, wp1, wc0x, wc0y, wc0z)
			local wld = Instance.new("Weld", wp1)
			wld.Part0 = wp0
			wld.Part1 = wp1
			wld.C0 = CFrame.new(wc0x, wc0y, wc0z)
		end
		function weld(model)
			local parts, last = {}, nil
			local function scan(parent)
				for _, v in pairs(parent:GetChildren()) do
					if v:IsA("BasePart") then
						if last then
							local w = Instance.new("Weld")
							w.Name = ("%s_Weld"):format(v.Name)
							w.Part0, w.Part1 = last, v
							w.C0 = last.CFrame:inverse()
							w.C1 = v.CFrame:inverse()
							w.Parent = last
						end
						last = v
						table.insert(parts, v)
					end
					scan(v)
				end
			end
			scan(model)
			for _, v in pairs(parts) do
				v.Anchored = false
				v.Locked = true
				v.BackSurface = Enum.SurfaceType.SmoothNoOutlines
				v.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
				v.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
				v.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
				v.RightSurface = Enum.SurfaceType.SmoothNoOutlines
				v.TopSurface = Enum.SurfaceType.SmoothNoOutlines
				v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
			end
		end

		music = Instance.new("Sound", Torso)
		music.Volume = 1
		music.TimePosition = 0
		music.Pitch = 1
		music.SoundId = "rbxassetid://1466277933"
		music.Looped = true
		music:Play()
		function so(id, par, vol, pit)
			coroutine.resume(coroutine.create(function()
				local sou = Instance.new("Sound", par or workspace)
				sou.Volume = vol
				sou.Pitch = pit or 1
				sou.SoundId = id
				swait()
				sou:play()
				game:GetService("Debris"):AddItem(sou, 8)
			end))
		end
		RSH, LSH = nil, nil
		RW, LW = Instance.new("Weld"), Instance.new("Weld")
		RW.Name = "Right Shoulder"
		LW.Name = "Left Shoulder"
		LH = Torso["Left Hip"]
		RH = Torso["Right Hip"]
		TorsoColor = Torso.BrickColor
		function NoOutline(Part)
			Part.TopSurface, Part.BottomSurface, Part.LeftSurface, Part.RightSurface, Part.FrontSurface, Part.BackSurface = 10, 10, 10, 10, 10, 10
		end
		player = Player
		ch = Character
		RSH = ch.Torso["Right Shoulder"]
		LSH = ch.Torso["Left Shoulder"]
		RSH.Parent = nil
		LSH.Parent = nil
		RW.Name = "Right Shoulder"
		RW.Part0 = ch.Torso
		RW.C0 = cf(1.5, 0.5, 0)
		RW.C1 = cf(0, 0.5, 0)
		RW.Part1 = ch["Right Arm"]
		RW.Parent = ch.Torso
		LW.Name = "Left Shoulder"
		LW.Part0 = ch.Torso
		LW.C0 = cf(-1.5, 0.5, 0)
		LW.C1 = cf(0, 0.5, 0)
		LW.Part1 = ch["Left Arm"]
		LW.Parent = ch.Torso

		newWeld(RootPart, Torso, 0, -1, 0)
		Torso.Weld.C1 = CFrame.new(0, -1, 0)
		newWeld(Torso, LeftLeg, -0.5, -1, 0)
		LeftLeg.Weld.C1 = CFrame.new(0, 1, 0)
		newWeld(Torso, RightLeg, 0.5, -1, 0)
		RightLeg.Weld.C1 = CFrame.new(0, 1, 0)
		Player = Player
		Character = Player.Character
		mouse = Player:GetMouse()
		m = Instance.new("Model", Character)
		local weldBetween = function(a, b)
			local weldd = Instance.new("ManualWeld")
			weldd.Part0 = a
			weldd.Part1 = b
			weldd.C0 = CFrame.new()
			weldd.C1 = b.CFrame:inverse() * a.CFrame
			weldd.Parent = a
			return weldd
		end
		ArtificialHB = Instance.new("BindableEvent", script)
		ArtificialHB.Name = "Heartbeat"
		script:WaitForChild("Heartbeat")
		frame = 0.016666666666666666
		tf = 0
		allowframeloss = false
		tossremainder = false
		lastframe = tick()
		script.Heartbeat:Fire()
		game:GetService("RunService").Heartbeat:connect(function(s, p)
			tf = tf + s
			if tf >= frame then
				if allowframeloss then
					script.Heartbeat:Fire()
					lastframe = tick()
				else
					for i = 1, math.floor(tf / frame) do
						script.Heartbeat:Fire()
					end
					lastframe = tick()
				end
				if tossremainder then
					tf = 0
				else
					tf = tf - frame * math.floor(tf / frame)
				end
			end
		end)
		function swait(num)
			if num == 0 or num == nil then
				ArtificialHB.Event:wait()
			else
				for i = 0, num do
					ArtificialHB.Event:wait()
				end
			end
		end
		function RemoveOutlines(part)
			part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface = 10, 10, 10, 10, 10, 10
		end
		CFuncs = {
			Part = {
				Create = function(Parent, Material, Reflectance, Transparency, BColor, Name, Size)
					local Part = Create("Part")({
						Parent = Parent,
						Reflectance = Reflectance,
						Transparency = Transparency,
						CanCollide = false,
						Locked = true,
						BrickColor = BrickColor.new(tostring(BColor)),
						Name = Name,
						Size = Size,
						Material = Material
					})
					RemoveOutlines(Part)
					return Part
				end
			},
			Mesh = {
				Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
					local Msh = Create(Mesh)({
						Parent = Part,
						Offset = OffSet,
						Scale = Scale
					})
					if Mesh == "SpecialMesh" then
						Msh.MeshType = MeshType
						Msh.MeshId = MeshId
					end
					return Msh
				end
			},
			Weld = {
				Create = function(Parent, Part0, Part1, C0, C1)
					local Weld = Create("Weld")({
						Parent = Parent,
						Part0 = Part0,
						Part1 = Part1,
						C0 = C0,
						C1 = C1
					})
					return Weld
				end
			},
			Sound = {
				Create = function(id, par, vol, pit)
					coroutine.resume(coroutine.create(function()
						local S = Create("Sound")({
							Volume = vol,
							Pitch = pit or 1,
							SoundId = id,
							Parent = par or workspace
						})
						wait()
						S:play()
						game:GetService("Debris"):AddItem(S, 6)
					end))
				end
			},
			ParticleEmitter = {
				Create = function(Parent, Color1, Color2, LightEmission, Size, Texture, Transparency, ZOffset, Accel, Drag, LockedToPart, VelocityInheritance, EmissionDirection, Enabled, LifeTime, Rate, Rotation, RotSpeed, Speed, VelocitySpread)
					local fp = Create("ParticleEmitter")({
						Parent = Parent,
						Color = ColorSequence.new(Color1, Color2),
						LightEmission = LightEmission,
						Size = Size,
						Texture = Texture,
						Transparency = Transparency,
						ZOffset = ZOffset,
						Acceleration = Accel,
						Drag = Drag,
						LockedToPart = LockedToPart,
						VelocityInheritance = VelocityInheritance,
						EmissionDirection = EmissionDirection,
						Enabled = Enabled,
						Lifetime = LifeTime,
						Rate = Rate,
						Rotation = Rotation,
						RotSpeed = RotSpeed,
						Speed = Speed,
						VelocitySpread = VelocitySpread
					})
					return fp
				end
			},
			CreateTemplate = {}
		}
		EffectModel = Create("Model")({Parent = Character, Name = "Effects"})
		Effects = {
			Block = {
				Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay, Type)
					local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
					prt.Anchored = true
					prt.CFrame = cframe
					local msh = CFuncs.Mesh.Create("BlockMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
					game:GetService("Debris"):AddItem(prt, 2)
					if Type == 1 or Type == nil then
						table.insert(Effects, {
							prt,
							"Block1",
							delay,
							x3,
							y3,
							z3,
							msh
						})
					elseif Type == 2 then
						table.insert(Effects, {
							prt,
							"Block2",
							delay,
							x3,
							y3,
							z3,
							msh
						})
					end
				end
			},
			Cylinder = {
				Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
					local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
					prt.Anchored = true
					prt.CFrame = cframe
					local msh = CFuncs.Mesh.Create("CylinderMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
					game:GetService("Debris"):AddItem(prt, 10)
					table.insert(Effects, {
						prt,
						"Cylinder",
						delay,
						x3,
						y3,
						z3,
						msh
					})
				end
			},
			Head = {
				Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
					local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
					prt.Anchored = true
					prt.CFrame = cframe
					local msh = CFuncs.Mesh.Create("SpecialMesh", prt, "Head", "nil", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
					game:GetService("Debris"):AddItem(prt, 10)
					table.insert(Effects, {
						prt,
						"Cylinder",
						delay,
						x3,
						y3,
						z3,
						msh
					})
				end
			},
			Sphere = {
				Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
					local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
					prt.Anchored = true
					prt.CFrame = cframe
					local msh = CFuncs.Mesh.Create("SpecialMesh", prt, "Sphere", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
					game:GetService("Debris"):AddItem(prt, 10)
					table.insert(Effects, {
						prt,
						"Cylinder",
						delay,
						x3,
						y3,
						z3,
						msh
					})
				end
			},
			Elect = {
				Create = function(cff, x, y, z)
					local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, BrickColor.new("Lime green"), "Part", Vector3.new(1, 1, 1))
					prt.Anchored = true
					prt.CFrame = cff * CFrame.new(math.random(-x, x), math.random(-y, y), math.random(-z, z))
					prt.CFrame = CFrame.new(prt.Position)
					game:GetService("Debris"):AddItem(prt, 2)
					local xval = math.random() / 2
					local yval = math.random() / 2
					local zval = math.random() / 2
					local msh = CFuncs.Mesh.Create("BlockMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(xval, yval, zval))
					table.insert(Effects, {
						prt,
						"Elec",
						0.1,
						x,
						y,
						z,
						xval,
						yval,
						zval
					})
				end
			},
			Ring = {
				Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
					local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
					prt.Anchored = true
					prt.CFrame = cframe
					local msh = CFuncs.Mesh.Create("SpecialMesh", prt, "FileMesh", "rbxassetid://3270017", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
					game:GetService("Debris"):AddItem(prt, 10)
					table.insert(Effects, {
						prt,
						"Cylinder",
						delay,
						x3,
						y3,
						z3,
						msh
					})
				end
			},
			Wave = {
				Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
					local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
					prt.Anchored = true
					prt.CFrame = cframe
					local msh = CFuncs.Mesh.Create("SpecialMesh", prt, "FileMesh", "rbxassetid://20329976", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
					game:GetService("Debris"):AddItem(prt, 10)
					table.insert(Effects, {
						prt,
						"Cylinder",
						delay,
						x3,
						y3,
						z3,
						msh
					})
				end
			},
			Break = {
				Create = function(brickcolor, cframe, x1, y1, z1)
					local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new(0.5, 0.5, 0.5))
					prt.Anchored = true
					prt.CFrame = cframe * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
					local msh = CFuncs.Mesh.Create("SpecialMesh", prt, "Sphere", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
					local num = math.random(10, 50) / 1000
					game:GetService("Debris"):AddItem(prt, 10)
					table.insert(Effects, {
						prt,
						"Shatter",
						num,
						prt.CFrame,
						math.random() - math.random(),
						0,
						math.random(50, 100) / 100
					})
				end
			},
			Fire = {
				Create = function(brickcolor, cframe, x1, y1, z1, delay)
					local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
					prt.Anchored = true
					prt.CFrame = cframe
					local msh = CFuncs.Mesh.Create("BlockMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
					game:GetService("Debris"):AddItem(prt, 10)
					table.insert(Effects, {
						prt,
						"Fire",
						delay,
						1,
						1,
						1,
						msh
					})
				end
			},
			FireWave = {
				Create = function(brickcolor, cframe, x1, y1, z1)
					local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 1, brickcolor, "Effect", Vector3.new())
					prt.Anchored = true
					prt.CFrame = cframe
					local msh = CFuncs.Mesh.Create("BlockMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
					local d = Create("Decal")({
						Parent = prt,
						Texture = "rbxassetid://26356434",
						Face = "Top"
					})
					local d = Create("Decal")({
						Parent = prt,
						Texture = "rbxassetid://26356434",
						Face = "Bottom"
					})
					game:GetService("Debris"):AddItem(prt, 10)
					table.insert(Effects, {
						prt,
						"FireWave",
						1,
						30,
						math.random(400, 600) / 100,
						msh
					})
				end
			},
			Lightning = {
				Create = function(p0, p1, tym, ofs, col, th, tra, last)
					local magz = (p0 - p1).magnitude
					local curpos = p0
					local trz = {
						-ofs,
						ofs
					}
					for i = 1, tym do
						local li = CFuncs.Part.Create(EffectModel, "Neon", 0, tra or 0.4, col, "Ref", Vector3.new(th, th, magz / tym))
						local ofz = Vector3.new(trz[math.random(1, 2)], trz[math.random(1, 2)], trz[math.random(1, 2)])
						local trolpos = CFrame.new(curpos, p1) * CFrame.new(0, 0, magz / tym).Position + ofz
						li.Material = "Neon"
						if tym == i then
							local magz2 = (curpos - p1).magnitude
							li.Size = Vector3.new(th, th, magz2)
							li.CFrame = CFrame.new(curpos, p1) * CFrame.new(0, 0, -magz2 / 2)
							table.insert(Effects, {
								li,
								"Disappear",
								last
							})
						else
							li.CFrame = CFrame.new(curpos, trolpos) * CFrame.new(0, 0, magz / tym / 2)
							curpos = li.CFrame * CFrame.new(0, 0, magz / tym / 2).Position
							game.Debris:AddItem(li, 10)
							table.insert(Effects, {
								li,
								"Disappear",
								last
							})
						end
					end
				end
			},
			EffectTemplate = {}
		}
		function New(Object, Parent, Name, Data)
			local Object = Instance.new(Object)
			for Index, Value in pairs(Data or {}) do
				Object[Index] = Value
			end
			Object.Parent = Parent
			Object.Name = Name
			return Object
		end
		function clerp(a, b, t)
			local qa = {
				QuaternionFromCFrame(a)
			}
			local qb = {
				QuaternionFromCFrame(b)
			}
			local ax, ay, az = a.x, a.y, a.z
			local bx, by, bz = b.x, b.y, b.z
			local _t = 1 - t
			return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
		end
		function QuaternionFromCFrame(cf)
			local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
			local trace = m00 + m11 + m22
			if trace > 0 then
				local s = math.sqrt(1 + trace)
				local recip = 0.5 / s
				return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
			else
				local i = 0
				if m00 < m11 then
					i = 1
				end
				if m22 > (i == 0 and m00 or m11) then
					i = 2
				end
				if i == 0 then
					local s = math.sqrt(m00 - m11 - m22 + 1)
					local recip = 0.5 / s
					return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
				elseif i == 1 then
					local s = math.sqrt(m11 - m22 - m00 + 1)
					local recip = 0.5 / s
					return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
				elseif i == 2 then
					local s = math.sqrt(m22 - m00 - m11 + 1)
					local recip = 0.5 / s
					return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
				end
			end
		end
		function QuaternionToCFrame(px, py, pz, x, y, z, w)
			local xs, ys, zs = x + x, y + y, z + z
			local wx, wy, wz = w * xs, w * ys, w * zs
			local xx = x * xs
			local xy = x * ys
			local xz = x * zs
			local yy = y * ys
			local yz = y * zs
			local zz = z * zs
			return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
		end
		function QuaternionSlerp(a, b, t)
			local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
			local startInterp, finishInterp
			if cosTheta >= 1.0E-4 then
				if 1 - cosTheta > 1.0E-4 then
					local theta = math.acos(cosTheta)
					local invSinTheta = 1 / math.sin(theta)
					startInterp = math.sin((1 - t) * theta) * invSinTheta
					finishInterp = math.sin(t * theta) * invSinTheta
				else
					startInterp = 1 - t
					finishInterp = t
				end
			elseif 1 + cosTheta > 1.0E-4 then
				local theta = math.acos(-cosTheta)
				local invSinTheta = 1 / math.sin(theta)
				startInterp = math.sin((t - 1) * theta) * invSinTheta
				finishInterp = math.sin(t * theta) * invSinTheta
			else
				startInterp = t - 1
				finishInterp = t
			end
			return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
		end
		function weld5(part0, part1, c0, c1)
			local weeld = Instance.new("Weld", part0)
			weeld.Part0 = part0
			weeld.Part1 = part1
			weeld.C0 = c0
			weeld.C1 = c1
			return weeld
		end
		function rayCast(Pos, Dir, Max, Ignore)
			return game:service("Workspace"):FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999.999)), Ignore)
		end
		function Damagefunc(hit, minim, maxim, knockback, Type, Property, Delay, KnockbackType, decreaseblock)
			if hit.Parent == nil then return end
			local hum = hit.Parent:FindFirstChild("Humanoid") or (hit.Name == "Handle" and hit.Parent.Parent:FindFirstChild("Humanoid"))
			local hitpart
			if hum == nil then
				return
			end
			local tchar = hum.Parent
			hitpart = tchar:FindFirstChild("Head") or tchar:FindFirstChild("Torso") or tchar:FindFirstChild("LowerTorso") or tchar:FindFirstChild("HumanoidRootPart")
			if hitpart then
				delete(hitpart)
			end
		end

		function attackone()
			attack = true
			for i = 0, 2, attackspeed + 0.16 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.1)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(-30)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(0), math.rad(90)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, -0.3 * i) * angles(math.rad(60 * i), math.rad(0), math.rad(-20 * i)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(3), math.rad(0)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-40), math.rad(4)), 0.2)
			end
			so("http://roblox.com/asset/?id=1022532343", LeftArm, 1, 1)
			RootPart.Velocity = RootPart.CFrame.lookVector * 34
			local con5 = Humanoid.Touched:connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false and hit.Parent ~= Character and hit.Parent.Name ~= Player.Name then
					attackdebounce = true
					Damagefunc(hit, 5, 8, math.random(5, 8), "Normal", RootPart, 0, 1)
					so("http://roblox.com/asset/?id=573395724", LeftArm, 1, 1)
					wait(0.2)
					attackdebounce = false
				end
			end)
			for i = 0, 1, attackspeed do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.4)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(60)), 0.4)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(20), math.rad(0), math.rad(30)), 0.4)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, -0.3) * angles(math.rad(20), math.rad(-40 * i), math.rad(-90)), 0.4)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(3), math.rad(-4)), 0.3)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-3), math.rad(0)), 0.3)
			end
			attack = false
			con5:Disconnect()
		end
		function attacktwo()
			attack = true
			for i = 0, 2, 0.15 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.1)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(30)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -0.3 * i) * angles(math.rad(60 * i), math.rad(0), math.rad(20 * i)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(90 - 40 * i), math.rad(0), math.rad(-90 + 40 * i)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(40), math.rad(4)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-3), math.rad(0)), 0.2)
			end
			so("http://roblox.com/asset/?id=169259383", RightArm, 1, 1)
			RootPart.Velocity = RootPart.CFrame.lookVector * 45
			local con5 = Humanoid.Touched:connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false and hit.Parent ~= Character and hit.Parent.Name ~= Player.Name then
					attackdebounce = true
					Damagefunc(hit, 6, 17, math.random(5, 12), "Normal", RootPart, 0, 1)
					so("http://roblox.com/asset/?id=542443306", RightArm, 1, 1)
					wait(0.3)
					attackdebounce = false
				end
			end)
			for i = 0, 1, 0.07 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-40), math.rad(90 * i), math.rad(0)), 0.6)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(15), math.rad(-70)), 0.4)
				RW.C0 = clerp(RW.C0, CFrame.new(0.9, 0.5, -0.5) * angles(math.rad(80), math.rad(0), math.rad(-50)), 0.7)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-40), math.rad(0), math.rad(50)), 0.4)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-40), math.rad(20), math.rad(0)), 0.3)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(20), math.rad(-40), math.rad(20)), 0.3)
			end
			con5:Disconnect()
			attack = false
		end
		function attackthree()
			attack = true
			noleg = true
			for i = 0, 2.3, 0.16 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1.15, 2.5) * CFrame.Angles(math.rad(-27), math.rad(0 - 50 * i), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-24), math.rad(-8), math.rad(43)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(60)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-0.9, 0.5, -0.3) * angles(math.rad(90), math.rad(0), math.rad(50)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -0.72, -0.4) * CFrame.Angles(math.rad(17), math.rad(0), math.rad(-16)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.34, -1.15, 0.3) * CFrame.Angles(math.rad(-77), math.rad(0), math.rad(0)), 0.2)
			end
			local con5 = Humanoid.Touched:connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false and hit.Parent ~= Character and hit.Parent.Name ~= Player.Name then
					attackdebounce = true
					Damagefunc(hit, 6, 12, math.random(5, 8), "Normal", RootPart, 0, 1)
					so("http://roblox.com/asset/?id=573395724", LeftLeg, 1, 1)
					wait(0.17)
					attackdebounce = false
				end
			end)
			so("http://roblox.com/asset/?id=1022532343", LeftLeg, 1, 1.34)
			so("http://roblox.com/asset/?id=1022532343", RightLeg, 1, 1.34)
			for i = 0, 3.17, 0.11 do
				swait()
				RootPart.Velocity = RootPart.CFrame.lookVector * 45
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -0.7, -0.9) * CFrame.Angles(math.rad(16 + 40 * i), math.rad(0 + 111 * i), math.rad(32 + 20 * i)), 0.1)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(23), math.rad(0), math.rad(-10)), 0.16)
				RW.C0 = clerp(RW.C0, CFrame.new(0.3, 0.35, -0.5) * angles(math.rad(90), math.rad(0), math.rad(-70)), 0.16)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0.2) * angles(math.rad(-70), math.rad(0), math.rad(-40)), 0.16)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.79, -0.95, 0.34) * CFrame.Angles(math.rad(-32), math.rad(32), math.rad(-40)), 0.17)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.4, -0.75, -0.43) * CFrame.Angles(math.rad(76), math.rad(38), math.rad(0)), 0.1)
			end
			for i = 0, 1, attackspeed do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, -0.4) * CFrame.Angles(math.rad(-8), math.rad(-30), math.rad(0)), 0.1)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(30)), 0.1)
				RW.C0 = clerp(RW.C0, CFrame.new(0.3, 0.35, -0.5) * angles(math.rad(90), math.rad(0), math.rad(-70)), 0.16)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(20), math.rad(0), math.rad(-30)), 0.1)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(3), math.rad(0)), 0.1)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1.03, 0.3) * CFrame.Angles(math.rad(-13), math.rad(0), math.rad(0)), 0.1)
			end
			noleg = false
			attack = false
			con5:Disconnect()
		end
		function Fdash()
			evadecooldown = true
			attack = true
			so("http://www.roblox.com/asset/?id=558640653", Character, 2.5, 1)
			Effects.Block.Create(BrickColor.new("Navy blue"), RootPart.CFrame, 2, 2, 2, 33.6, 33.6, 33.6, 0.05)
			Effects.Block.Create(BrickColor.new("White"), RootPart.CFrame, 2, 2, 2, 33.4, 33.4, 33.4, 0.04)
			Effects.Block.Create(BrickColor.new("Navy blue"), RootPart.CFrame, 2, 2, 2, 36.6, 36.6, 36.6, 0.05)
			Effects.Block.Create(BrickColor.new("Deep blue"), RootPart.CFrame, 2, 2, 2, 36.4, 36.4, 36.4, 0.05)
			Effects.Ring.Create(BrickColor.new("New Yeller"), Torso.CFrame, 2, 2, 2, 7.6, 7.6, 7.6, 0.025)
			Effects.Ring.Create(BrickColor.new("Deep blue"), Torso.CFrame, 2, 2, 2, 8.6, 8.6, 8.6, 0.03)
			Effects.Ring.Create(BrickColor.new("White"), Torso.CFrame, 2, 2, 2, 9.6, 9.6, 9.6, 0.04)
			Effects.Ring.Create(BrickColor.new("Navy blue"), Torso.CFrame, 2, 2, 2, 10.6, 10.6, 10.6, 0.05)
			for i = 0, 2, 0.064 do
				swait()
				RootPart.Velocity = RootPart.CFrame.lookVector * 145
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, -4.8) * CFrame.Angles(math.rad(-90), math.rad(0 + 213.8 * i), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-90), math.rad(0), math.rad(0)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(70)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(-70)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
			end
			attack = false
			wait(0.13)
			evadecooldown = false
		end
		function Adash()
			evadecooldown = true
			attack = true
			so("http://www.roblox.com/asset/?id=558640653", Character, 2.5, 1)
			RootPart.Velocity = RootPart.Velocity + Vector3.new(0,25,0)
			Effects.Block.Create(BrickColor.new("Navy blue"), LeftLeg.CFrame, 2, 2, 2, 33.6, 33.6, 33.6, 0.05)
			Effects.Block.Create(BrickColor.new("White"), RightLeg.CFrame, 2, 2, 2, 33.4, 33.4, 33.4, 0.04)
			Effects.Block.Create(BrickColor.new("Navy blue"), LeftLeg.CFrame, 2, 2, 2, 36.6, 36.6, 36.6, 0.05)
			Effects.Block.Create(BrickColor.new("Deep blue"), RightLeg.CFrame, 2, 2, 2, 36.4, 36.4, 36.4, 0.05)
			Torso.Velocity = RootPart.Velocity + vt(0, 19.4, 0)
			for i = 0, 2, 0.064 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(0), math.rad(0 + 213.8 * i), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-90), math.rad(0), math.rad(0)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(70)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(-70)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
			end
			attack = false
			wait(0.13)
			evadecooldown = false
		end
		function Ldash()
			evadecooldown = true
			attack = true
			so("http://www.roblox.com/asset/?id=707957812", Torso, 2.5, 1)
			for i = 0, 2, 0.064 do
				swait()
				RootPart.Velocity = RootPart.CFrame.rightVector * -75
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(32)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(-9), math.rad(-14)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(77), math.rad(0), math.rad(70)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.5, -0.55) * angles(math.rad(30), math.rad(0), math.rad(70)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(12)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(8)), 0.2)
			end
			attack = false
			wait(0.13)
			evadecooldown = false
		end
		function Rdash()
			evadecooldown = true
			attack = true
			so("http://www.roblox.com/asset/?id=707957812", Torso, 2.5, 1)
			for i = 0, 2, 0.064 do
				swait()
				RootPart.Velocity = RootPart.CFrame.rightVector * 75
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-32)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(9), math.rad(14)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -0.55) * angles(math.rad(30), math.rad(0), math.rad(-70)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(77), math.rad(0), math.rad(-70)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-8)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-12)), 0.2)
			end
			attack = false
			wait(0.13)
			evadecooldown = false
		end
		function Bdash()
			evadecooldown = true
			attack = true
			for i = 0, 8.4, 0.21 do
				swait()
				RootPart.Velocity = RootPart.CFrame.lookVector * -90
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -0.79, 2.5) * CFrame.Angles(math.rad(0 + 100 * i), math.rad(0), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(20), math.rad(0), math.rad(0)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(180), math.rad(-60), math.rad(40)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(180), math.rad(60), math.rad(-40)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
			end
			attack = false
			wait(0.9)
			evadecooldown = false
		end
		function bullets()
			local X = Instance.new("Part", workspace)
			local O = Instance.new("ObjectValue", X)
			O.Name = "creator"
			X.Locked = true
			X.Name = "Shell"
			X.Anchored = false
			X.CanCollide = false
			X.Transparency = 0.24
			X.Reflectance = 0
			X.BottomSurface = 0
			X.TopSurface = 0
			X.Shape = 0
			local V = Instance.new("ObjectValue", X)
			V.Value = Character
			V.Name = "creator"
			X.BrickColor = BrickColor.new("Cyan")
			X.Size = Vector3.new(2, 2, 2)
			X.Material = "Neon"
			local Z = Instance.new("SpecialMesh", X)
			Z.MeshType = "Sphere"
			Z.Scale = Vector3.new(0.2, 0.2, 0.7) + Vector3.new(math.random(0, 0.7), math.random(0, 0.7), math.random(0, 0.7))
			X.CFrame = handee.CFrame * CFrame.new(0, -5, -1) + Vector3.new(math.random(-76, 76), math.random(5, 10), math.random(-44, 44))
			local bv = Instance.new("BodyVelocity", X)
			bv.maxForce = Vector3.new(99999, 99999, 99999)
			X.CFrame = CFrame.new(X.Position, mouse.Hit.p)
			bv.velocity = X.CFrame.lookVector * 445
			so("http://roblox.com/asset/?id=200633327", X, 1, 1)
			local X2 = Instance.new("Part", workspace)
			local O2 = Instance.new("ObjectValue", X2)
			O2.Name = "creator"
			X2.Locked = true
			X2.Name = "Shell"
			X2.Anchored = false
			X2.CanCollide = false
			X2.Transparency = 0.24
			X2.Reflectance = 0
			X2.BottomSurface = 0
			X2.TopSurface = 0
			X2.Shape = 0
			local V2 = Instance.new("ObjectValue", X2)
			V2.Value = Character
			V2.Name = "creator"
			X2.BrickColor = BrickColor.new("New Yeller")
			X2.Size = Vector3.new(2, 2, 2)
			X2.Material = "Neon"
			local Z2 = Instance.new("SpecialMesh", X2)
			Z2.MeshType = "Sphere"
			Z2.Scale = Vector3.new(0.2, 0.2, 0.7) + Vector3.new(math.random(0, 0.7), math.random(0, 0.7), math.random(0, 0.7))
			X2.CFrame = handee.CFrame * CFrame.new(0, -5, -1) + Vector3.new(math.random(-76, 76), math.random(5, 10), math.random(-44, 44))
			local bv2 = Instance.new("BodyVelocity", X2)
			bv2.maxForce = Vector3.new(99999, 99999, 99999)
			X2.CFrame = CFrame.new(X2.Position, mouse.Hit.p)
			bv2.velocity = X2.CFrame.lookVector * 345
			so("http://roblox.com/asset/?id=200633327", X2, 1, 1)
			local X3 = Instance.new("Part", workspace)
			local O3 = Instance.new("ObjectValue", X3)
			O3.Name = "creator"
			X3.Locked = true
			X3.Name = "Shell"
			X3.Anchored = false
			X3.CanCollide = false
			X3.Transparency = 0.24
			X3.Reflectance = 0
			X3.BottomSurface = 0
			X3.TopSurface = 0
			X3.Shape = 0
			local V3 = Instance.new("ObjectValue", X3)
			V3.Value = Character
			V3.Name = "creator"
			X3.BrickColor = BrickColor.new("White")
			X3.Size = Vector3.new(2, 2, 2)
			X3.Material = "Neon"
			local Z3 = Instance.new("SpecialMesh", X3)
			Z3.MeshType = "Sphere"
			Z3.Scale = Vector3.new(0.2, 0.2, 0.7) + Vector3.new(math.random(0, 0.7), math.random(0, 0.7), math.random(0, 0.7))
			X3.CFrame = handee.CFrame * CFrame.new(0, -5, -1) + Vector3.new(math.random(-76, 76), math.random(5, 10), math.random(-44, 44))
			local bv3 = Instance.new("BodyVelocity", X3)
			bv3.maxForce = Vector3.new(99999, 99999, 99999)
			X3.CFrame = CFrame.new(X3.Position, mouse.Hit.p)
			bv3.velocity = X3.CFrame.lookVector * 545
			so("http://roblox.com/asset/?id=200633327", X3, 1, 1)
			local con5 = X.Touched:connect(function(hit)
				Effects.Sphere.Create(BrickColor.new("Toothpaste"), X.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
				X:Destroy()
				so("http://roblox.com/asset/?id=265581252", workspace, 0.5, 1)
				if hit.Parent and hit.Parent:FindFirstChild("Humanoid") ~= nil and hit.Name ~= "X2" and hit.Name ~= "X3" and hit.Parent ~= Character and hit.Parent.Name ~= Player.Name then
					Damagefunc(hit, 9, 16, math.random(4, 6), "Knockdown", RootPart, 0.2, 1)
					Effects.Sphere.Create(BrickColor.new("Toothpaste"), X.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
					so("http://roblox.com/asset/?id=265581252", workspace, 0.5, 1)
					X:Destroy()
				end
			end)
			local con5 = X2.Touched:connect(function(hit)
				Effects.Sphere.Create(BrickColor.new("New Yeller"), X2.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
				X2:Destroy()
				so("http://roblox.com/asset/?id=265581252", workspace, 0.5, 1)
				if hit.Parent and hit.Parent:FindFirstChild("Humanoid") ~= nil and hit.Name ~= "X" and hit.Name ~= "X3" and hit.Parent ~= Character and hit.Parent.Name ~= Player.Name then
					Damagefunc(hit, 9, 16, math.random(4, 6), "Knockdown", RootPart, 0.2, 1)
					Effects.Sphere.Create(BrickColor.new("New Yeller"), X2.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
					so("http://roblox.com/asset/?id=265581252", workspace, 0.5, 1)
					X2:Destroy()
				end
			end)
			local con5 = X3.Touched:connect(function(hit)
				Effects.Sphere.Create(BrickColor.new("White"), X3.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
				X3:Destroy()
				so("http://roblox.com/asset/?id=265581252", workspace, 0.5, 1)
				if hit.Parent and hit.Parent:FindFirstChild("Humanoid") ~= nil and hit.Name ~= "X2" and hit.Name ~= "X" and hit.Parent ~= Character and hit.Parent.Name ~= Player.Name then
					Damagefunc(hit, 9, 16, math.random(4, 6), "Knockdown", RootPart, 0.2, 1)
					Effects.Sphere.Create(BrickColor.new("White"), X3.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
					so("http://roblox.com/asset/?id=265581252", workspace, 0.5, 1)
					X3:Destroy()
				end
			end)
		end
		function Fkickcombo()
			attack = true
			for i = 0, 2.3, 0.16 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1.15, 2.5) * CFrame.Angles(math.rad(-27), math.rad(0 - 50 * i), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-24), math.rad(-8), math.rad(43)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(60)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-0.9, 0.5, -0.3) * angles(math.rad(90), math.rad(0), math.rad(50)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -0.72, -0.4) * CFrame.Angles(math.rad(17), math.rad(0), math.rad(-16)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.34, -1.15, 0.3) * CFrame.Angles(math.rad(-77), math.rad(0), math.rad(0)), 0.2)
			end
			local con5 = Humanoid.Touched:connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false and hit.Parent ~= Character and hit.Parent.Name ~= Player.Name then
					attackdebounce = true
					Damagefunc(hit, 17, 26, math.random(2, 3), "Normal", RootPart, 0, 1)
					so("http://roblox.com/asset/?id=260429995", RightLeg, 2, 1)
					wait(0.14)
					attackdebounce = false
				end
			end)
			so("http://roblox.com/asset/?id=158475221", Torso, 1, 1.9)
			noleg = true
			for i = 0, 3.3, 0.11 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, 2.4, -0.8) * CFrame.Angles(math.rad(13 - 22 * i), math.rad(0 + 130 * i), math.rad(80 - 15 * i)), 0.15)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(13), math.rad(-17), math.rad(0)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(0.7, 0.5, -0.7) * angles(math.rad(80), math.rad(0), math.rad(-70)), 0.15)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-90), math.rad(0), math.rad(-30)), 0.15)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1.03, 0.4) * CFrame.Angles(math.rad(-54 - 3 * i), math.rad(0), math.rad(0)), 0.15)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, -0.7) * CFrame.Angles(math.rad(60 + 3 * i), math.rad(10), math.rad(-4)), 0.15)
			end
			attack = false
			noleg = false
			con5:disconnect()
		end
		function Magicform()
			df = true
			attack = true
			music.TimePosition = 0
			music.SoundId = "rbxassetid://1228696343"
			swait(1)
			for i = 0, 4, 0.1 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(0), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(24), math.rad(0), math.rad(0)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, -0.35) * angles(math.rad(90), math.rad(0), math.rad(-70)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.5, -0.35) * angles(math.rad(90), math.rad(0), math.rad(70)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(30), math.rad(-4), math.rad(3)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(30), math.rad(4), math.rad(-3)), 0.2)
			end
			so("http://roblox.com/asset/?id=1286168545", Head, 6, 1)
			Effects.Sphere.Create(BrickColor.new("Toothpaste"), Torso.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
			for i = 0, 4, 0.1 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-54), math.rad(0), math.rad(0)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(70)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(-70)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(4), math.rad(-3)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(-4), math.rad(3)), 0.2)
			end
			attack = false
		end
		function Magicrevert()
			df = false
			attack = true
			music.TimePosition = 0
			music.SoundId = "rbxassetid://1343241846"
			swait(1)
			for i = 0, 4, 0.1 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(0), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(24), math.rad(0), math.rad(0)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, -0.35) * angles(math.rad(90), math.rad(0), math.rad(-70)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.5, -0.35) * angles(math.rad(90), math.rad(0), math.rad(70)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(30), math.rad(-4), math.rad(3)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(30), math.rad(4), math.rad(-3)), 0.2)
			end
			so("http://roblox.com/asset/?id=1286168545", Head, 6, 1)
			Effects.Sphere.Create(BrickColor.new("New Yeller"), Torso.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
			for i = 0, 4, 0.1 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-54), math.rad(0), math.rad(0)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(70)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(-70)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(4), math.rad(-3)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(-4), math.rad(3)), 0.2)
			end
			attack = false
		end
		function Sphere1()
			magic = true
			while magic == true do
				do
					local thing = Instance.new("BodyGyro", RootPart)
					thing.D = 30
					thing.P = 3000
					thing.MaxTorque = vt(math.huge, math.huge, 0)
					thing.CFrame = CFrame.new(RootPart.Position, mouse.Hit.p)
					attack = true
					Effects.Block.Create(BrickColor.new("Navy blue"), handee.CFrame, 2, 2, 2, 3.6, 3.6, 3.6, 0.07)
					for i = 0, 1.6, 0.22 do
						swait()
						Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-14), math.rad(-60), math.rad(0)), 0.2)
						Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(70)), 0.2)
						RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(0), math.rad(90)), 0.2)
						LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(60), math.rad(0), math.rad(-90)), 0.2)
						LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1.06, 0) * CFrame.Angles(math.rad(-8), math.rad(27), math.rad(-12)), 0.2)
						RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(2), math.rad(-24), math.rad(7)), 0.2)
					end
					local X = Instance.new("Part", workspace)
					local O = Instance.new("ObjectValue", X)
					O.Name = "creator"
					X.Locked = true
					X.Name = "Shell"
					X.Anchored = false
					X.CanCollide = false
					X.Transparency = 0.24
					X.Reflectance = 0
					X.BottomSurface = 0
					X.TopSurface = 0
					X.Shape = 0
					local V = Instance.new("ObjectValue", X)
					V.Value = Character
					V.Name = "creator"
					X.BrickColor = BrickColor.new("Cyan")
					X.Size = Vector3.new(2, 2, 2)
					X.Material = "Neon"
					local Z = Instance.new("SpecialMesh", X)
					Z.MeshType = "Sphere"
					Z.Scale = Vector3.new(1.5, 1.5, 2)
					X.CFrame = handee.CFrame * CFrame.new(0, -5, -1)
					local bv = Instance.new("BodyVelocity", X)
					bv.maxForce = Vector3.new(99999, 99999, 99999)
					X.CFrame = CFrame.new(X.Position, mouse.Hit.p)
					bv.velocity = X.CFrame.lookVector * 245
					RootPart.Velocity = RootPart.CFrame.lookVector * -43
					Torso.Velocity = RootPart.Velocity + vt(0, 3.4, 0)
					game:service("Debris"):AddItem(X, 9)
					local con5 = X.Touched:connect(function(hit)
						Effects.Sphere.Create(BrickColor.new("Toothpaste"), X.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
						X:Destroy()
						so("http://roblox.com/asset/?id=265581252", workspace, 0.5, 1)
						if hit.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false and hit.Parent ~= Character and hit.Parent.Name ~= Player.Name then
							attackdebounce = true
							Damagefunc(hit, 9, 16, math.random(4, 6), "Knockdown", RootPart, 0.2, 1)
							Effects.Sphere.Create(BrickColor.new("Toothpaste"), X.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
							so("http://roblox.com/asset/?id=265581252", workspace, 0.5, 1)
							X:Destroy()
							wait()
							attackdebounce = false
						end
					end)
					Effects.Block.Create(BrickColor.new("Navy blue"), handee.CFrame, 2, 2, 2, 3.6, 3.6, 3.6, 0.07)
					for i = 0, 2.86, 0.22 do
						swait()
						Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(10), math.rad(40), math.rad(0)), 0.2)
						Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(6), math.rad(0), math.rad(-50)), 0.2)
						RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, -0.65) * angles(math.rad(80), math.rad(0), math.rad(-70)), 0.2)
						LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(-40)), 0.2)
						LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-16), math.rad(4), math.rad(11)), 0.2)
						RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(16), math.rad(-4), math.rad(13)), 0.2)
					end
					thing:Destroy()
					attack = false
				end
			end
		end
		function Sphere2()
			attack = true
			local thing = Instance.new("BodyGyro", RootPart)
			thing.D = 30
			thing.P = 3000
			thing.MaxTorque = vt(math.huge, math.huge, 0)
			Effects.Block.Create(BrickColor.new("Navy blue"), handee.CFrame, 2, 2, 2, 3.6, 3.6, 3.6, 0.07)
			for i = 0, 2.86, 0.22 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(10), math.rad(40), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(6), math.rad(0), math.rad(-50)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, -0.65) * angles(math.rad(80), math.rad(0), math.rad(-70)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(-40)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-16), math.rad(4), math.rad(11)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(16), math.rad(-4), math.rad(13)), 0.2)
			end
			for i = 1, 5 do
				thing.CFrame = CFrame.new(RootPart.Position, mouse.Hit.p)
				bullets()
				swait()
				bullets()
				bullets()
				wait(0.2)
				bullets()
				bullets()
				RootPart.Velocity = RootPart.CFrame.lookVector * -23
			end
			thing:Destroy()
			attack = false
		end
		function laser()
			local thing = Instance.new("BodyGyro", RootPart)
			thing.D = 0
			thing.P = 7000
			thing.MaxTorque = vt(math.huge, math.huge, 0)
			thing.CFrame = CFrame.new(RootPart.Position, mouse.Hit.p)
			attack = true
			so("http://roblox.com/asset/?id=1048497321", RightArm, 1, 1)
			for i = 0, 1, 0.1 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(-80)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(0), math.rad(90)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(-30)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.73, -1, 0) * CFrame.Angles(math.rad(-25), math.rad(-66), math.rad(-25)), 0.1)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.6, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-83), math.rad(0)), 0.1)
			end
			local ray = Ray.new(handee.CFrame.p, (mouse.Hit.p - handee.CFrame.p).unit * 700)
			local part, position = workspace:FindPartOnRay(ray, player.Character, false, true)
			local beam = Instance.new("Part", workspace)
			beam.BrickColor = BrickColor.new("Navy blue")
			beam.FormFactor = "Custom"
			beam.Material = "Neon"
			beam.Transparency = 0
			beam.Anchored = true
			beam.Locked = true
			beam.CanCollide = false
			local beam1 = Instance.new("Part", workspace)
			beam1.BrickColor = BrickColor.new("Navy blue")
			beam1.FormFactor = "Custom"
			beam1.Material = "Neon"
			beam1.Transparency = 0
			beam1.Anchored = false
			beam1.Locked = true
			beam1.CanCollide = false
			local distance = (handee.CFrame.p - position).magnitude
			beam.Size = Vector3.new(1.71, 1.71, distance)
			beam1.Size = Vector3.new(2.71, 2.71, distance)
			beam.CFrame = CFrame.new(handee.CFrame.p, position) * CFrame.new(0, 0, -distance / 2)
			beam1.CFrame = CFrame.new(handee.CFrame.p, position) * CFrame.new(0, 0, -distance / 2)
			local Z = Instance.new("SpecialMesh", beam)
			Z.MeshType = "Sphere"
			local Z1 = Instance.new("SpecialMesh", beam1)
			Z1.MeshType = "Sphere"
			local bv = Instance.new("BodyVelocity", beam1)
			bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			beam1.CFrame = CFrame.new(beam1.Position, mouse.Hit.p)
			bv.velocity = beam1.CFrame.lookVector * 350
			so("http://roblox.com/asset/?id=215270668", RightArm, 6, 1)
			Torso.Anchored = true
			Effects.Ring.Create(BrickColor.new("Navy blue"), RootPart.CFrame, 2, 2, 2, 18.6, 18.6, 18.6, 0.02)
			Effects.Block.Create(BrickColor.new("Navy blue"), handee.CFrame, 2, 2, 2, 3.6, 3.6, 3.6, 0.03)
			if part then
				local humanoid = part.Parent:FindFirstChild("Humanoid")
				humanoid = humanoid or part.Parent.Parent:FindFirstChild("Humanoid")
				if humanoid and part.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false then
					attackdebounce = true
					Damagefunc(part, 1, 9, math.random(1, 2), "Knockdown", RootPart, 0.2, 1)
					swait()
					attackdebounce = false
				end
			end
			for i = 0, 3.8, 0.1 do
				swait()
				beam.Size = beam.Size + Vector3.new(3.71, 3.71, 0)
				beam1.Size = beam1.Size + Vector3.new(7.71, 7.71, 0)
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(-80)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90 + 7 * math.cos(sine / 1.6) / 2), math.rad(0), math.rad(90)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(-30)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.73, -1, 0) * CFrame.Angles(math.rad(-25), math.rad(-66), math.rad(-25)), 0.1)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.6, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-83), math.rad(0)), 0.1)
			end
			for i = 0, 3.8, 0.1 do
				swait()
				beam.Size = beam.Size - Vector3.new(6.71, 6.71, 0)
				beam1.Size = beam1.Size - Vector3.new(9.71, 9.71, 0)
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(-80)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90 + 7 * math.cos(sine / 1.6) / 2), math.rad(0), math.rad(90)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(-30)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.73, -1, 0) * CFrame.Angles(math.rad(-25), math.rad(-66), math.rad(-25)), 0.1)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.6, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-83), math.rad(0)), 0.1)
			end
			Torso.Anchored = false
			game:GetService("Debris"):AddItem(beam, 0.1)
			game:GetService("Debris"):AddItem(beam1, 0.1)
			attack = false
			thing:Destroy()
		end
		mouse.Button1Down:connect(function()
			if attack == false and attacktype == 1 and df == false then
				attacktype = 2
				attackone()
			elseif attack == false and attacktype == 2 and df == false then
				attacktype = 3
				attacktwo()
			elseif attack == false and attacktype == 3 and df == false then
				attacktype = 1
				attackthree()
			elseif attack == false and attacktype == 4 and df == false then
				attacktype = 1
				--attackfour()
			elseif attack == false and attacktype2 == 1 and df == true then
				attacktype = 1
				Sphere1()
			end
		end)
		mouse.Button1Up:connect(function()
			if attack == true and df == true then
				magic = false
			end
		end)
		mouse.KeyDown:connect(function(key)
			if key == "f" and attack == false and evadecooldown == false then
				Fdash()
			end
		end)
		mouse.KeyDown:connect(function(key)
			if key == "g" and attack == false and evadecooldown == false then
				Adash()
			end
		end)
		mouse.KeyDown:connect(function(key)
			if key == "e" and attack == false and evadecooldown == false then
				Ldash()
			end
		end)
		mouse.KeyDown:connect(function(key)
			if key == "r" and attack == false and evadecooldown == false then
				Rdash()
			end
		end)
		mouse.KeyDown:connect(function(key)
			if key == "q" and attack == false and df == false then
				Fkickcombo()
			end
		end)
		mouse.KeyDown:connect(function(key)
			if key == "t" and attack == false then
				Bdash()
			end
		end)
		mouse.KeyDown:connect(function(key)
			if key == "y" and attack == false and df == false then
				Magicform()
			end
		end)
		mouse.KeyDown:connect(function(key)
			if key == "u" and attack == false and df == true then
				Magicrevert()
			end
		end)
		mouse.KeyDown:connect(function(key)
			if key == "l" and attack == false and df == true then
				laser()
			end
		end)
		mouse.KeyDown:connect(function(key)
			if key == "h" and attack == false and df == true then
				Sphere2()
			end
		end)
		mouse.KeyDown:connect(function(key)
			if string.byte(key) == 32 then
				local lastwall
				local ray = Ray.new(Torso.CFrame.p, Torso.CFrame.lookVector * 2)
				local hit, position, normal = workspace:FindPartOnRay(ray, Character)
				if hit and hit ~= lastwall then
					local velo = Instance.new("BodyVelocity", Torso)
					velo.MaxForce = Vector3.new(400000, 400000, 400000)
					velo.Velocity = -Torso.CFrame.lookVector * 20 + Vector3.new(0, 16, 0)
					game.Debris:AddItem(velo, 0.1)
					lastwall = hit
					wait(0.4)
					lastwall = nil
				end
			end
		end)
		for _, v in next, game:service("Players").localPlayer.Character:GetDescendants() do
			if v:IsA("BasePart") then
				local BF = Instance.new("BodyForce", v)
				BF.force = Vector3.new(0, workspace.Gravity * v:GetMass() / 1.121, 0)
			end
		end
		mouse.KeyDown:connect(function(key)
			if string.byte(key) == 48 then
				Swing = 2
				if df == true then
					Character.Humanoid.WalkSpeed = 38.82
				end
				if df == false then
					Character.Humanoid.WalkSpeed = 28.82
				end
			end
		end)
		mouse.KeyUp:connect(function(key)
			if string.byte(key) == 48 then
				Swing = 1
				Character.Humanoid.WalkSpeed = 8
			end
		end)
		Humanoid.JumpPower = 43.3
		Character.Humanoid.WalkSpeed = 8
		while true do
			swait()
			sine = sine + change
			local torvel = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude
			local velderp = RootPart.Velocity.y
			hitfloor, posfloor = rayCast(RootPart.Position, CFrame.new(RootPart.Position, RootPart.Position - Vector3.new(0, 1, 0)).lookVector, 4, Character)
			if attack == true or attack == false then
				if attack == false then
					idle = idle + 1
				else
					idle = 0
				end
				if not (idle >= 500) or attack == false then
				end
				if RootPart.Velocity.y > 1 and hitfloor == nil then
					Anim = "Jump"
					if attack == false then
						change = 1
						Humanoid.CameraOffset = Vector3.new(0, 0, 0)
						Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, -0.15) * CFrame.Angles(math.rad(-13), math.rad(0), math.rad(0)), 0.1)
						Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-30 + 2.05 * math.cos(sine / 5)), math.rad(0), math.rad(0)), 0.1)
						RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-30 + 2.05 * math.cos(sine / 5)), math.rad(0), math.rad(50 - 2.05 * math.cos(sine / 5))), 0.1)
						LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30 + 2.05 * math.cos(sine / 5)), math.rad(0), math.rad(-50 + 2.05 * math.cos(sine / 5))), 0.1)
					end
					if attack == false then
						LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-25 + 3.05 * math.cos(sine / 5)), math.rad(0), math.rad(0)), 0.1)
						RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -0.47, -0.7) * CFrame.Angles(math.rad(-12 + 3.05 * math.cos(sine / 5)), math.rad(-3), math.rad(0)), 0.1)
					end
				elseif RootPart.Velocity.y < -1 and hitfloor == nil then
					Anim = "Fall"
					change = 1
					if attack == false then
						Humanoid.CameraOffset = Vector3.new(0, 0, 0)
						Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0.2) * CFrame.Angles(math.rad(-10), math.rad(0), math.rad(0)), 0.1)
						RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(20), math.rad(90)), 0.1)
						LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(90), math.rad(-20), math.rad(-90)), 0.1)
						Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(40), math.rad(0), math.rad(0)), 0.1)
					end
					if attack == false or attack == true then
						LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-8), math.rad(3), math.rad(0)), 0.1)
						RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -0.67, -0.4) * CFrame.Angles(math.rad(25), math.rad(0), math.rad(0)), 0.1)
					end
				elseif torvel < 1 and hitfloor ~= nil then
					Anim = "Idle"
					change = 1.54
					if attack == false and equip == false then
						Humanoid.CameraOffset = Vector3.new(0, 0, 0)
						Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1 - 0.1 * math.cos(sine / 40), 0) * CFrame.Angles(math.rad(0), math.rad(-43), math.rad(0)), 0.1)
						Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(7 + 5 * math.sin(sine / 40)), math.rad(-4), math.rad(43)), 0.1)
						RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5 + 0.07 * math.sin(sine / 40), 0) * angles(math.rad(-13), math.rad(0 + 7 * math.cos(sine / 40)), math.rad(14 + 3.2 * math.cos(sine / 40))), 0.1)
						LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5 + 0.07 * math.sin(sine / 40), 0) * angles(math.rad(-3), math.rad(0 - 7 * math.cos(sine / 40)), math.rad(-14 - 3.2 * math.cos(sine / 40))), 0.1)
						LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1.03 + 0.1 * math.cos(sine / 40), 0) * CFrame.Angles(math.rad(0), math.rad(25), math.rad(-4)), 0.1)
						RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1 + 0.1 * math.cos(sine / 40), 0) * CFrame.Angles(math.rad(-14), math.rad(-9), math.rad(7)), 0.1)
					end
				elseif torvel > 2 and torvel < 25 and hitfloor ~= nil then
					Anim = "Walk"
					change = 0.76
					if attack == false and equip == false then
						Humanoid.CameraOffset = Vector3.new(0, 0, 0)
						Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1 + 0.23 * math.cos(sine / 3.5), -0.3) * angles(math.rad(-7 + 3 * math.cos(sine / 3.5)), math.rad(0 + 4 * math.cos(sine / 7)), math.rad(0) + RootPart.RotVelocity.Y / 46), 0.1)
						Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0 - 6 * math.cos(sine / 3.5)), math.rad(0), math.rad(0) + RootPart.RotVelocity.Y / 13), 0.1)
						RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0 + 0.34 * math.sin(sine / 7)) * angles(math.rad(0 - 44 * math.sin(sine / 7)) + RootPart.RotVelocity.Y / -34, math.rad(0), math.rad(5 + 14 * math.sin(sine / 7)) - RootPart.RotVelocity.Y / 34), 0.1)
						LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0 - 0.34 * math.sin(sine / 7)) * angles(math.rad(0 + 44 * math.sin(sine / 7)) + RootPart.RotVelocity.Y / 34, math.rad(0), math.rad(-5 + 14 * math.sin(sine / 7)) + RootPart.RotVelocity.Y / -34), 0.1)
						LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1 - 0.22 * math.cos(sine / 7), 0 + 0.22 * math.sin(sine / 7)) * CFrame.Angles(math.rad(0 - 65 * math.sin(sine / 7)), math.rad(3), math.rad(0)), 0.1)
						RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1 + 0.22 * math.cos(sine / 7), 0 - 0.22 * math.sin(sine / 7)) * CFrame.Angles(math.rad(0 + 65 * math.sin(sine / 7)), math.rad(-3), math.rad(0)), 0.1)
					end
					if attack == true and noleg == false then
						LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1 - 0.12 * math.cos(sine / 18), 0 + 0.22 * math.sin(sine / 18)) * CFrame.Angles(math.rad(0 - 30 * math.sin(sine / 18)), math.rad(3), math.rad(0)), 0.1)
						RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1 + 0.12 * math.cos(sine / 18), 0 - 0.22 * math.sin(sine / 18)) * CFrame.Angles(math.rad(0 + 30 * math.sin(sine / 18)), math.rad(-3), math.rad(0)), 0.1)
					end
				elseif torvel >= 25 and hitfloor ~= nil then
					Anim = "Run"
					if df == false then
						change = 1
					end
					if df == true then
						change = 1.35
					end
					if attack == false and equip == false then
						Humanoid.CameraOffset = Vector3.new(0, 0, 0)
						Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1 - 0.42 * math.cos(sine / 2.5), -0.8) * angles(math.rad(-27), math.rad(0), math.rad(0) + RootPart.RotVelocity.Y / 26), 0.1)
						Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-13 + 20 * math.sin(sine / 2.5)), math.rad(0), math.rad(0 + 5 * math.sin(sine / 5)) + RootPart.RotVelocity.Y / 13), 0.1)
						RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0 + 0.34 * math.sin(sine / 5)) * angles(math.rad(0 - 80 * math.sin(sine / 5)), math.rad(0), math.rad(10 + 18 * math.sin(sine / 5))), 0.15)
						LW.C0 = clerp(LW.C0, cf(-1.5, 0.5, 0 - 0.34 * math.sin(sine / 5)) * angles(math.rad(0 + 80 * math.sin(sine / 5)), math.rad(0), math.rad(-10 + 18 * math.sin(sine / 5))), 0.15)
						LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1 - 0.24 * math.cos(sine / 5), 0 + 0.32 * math.sin(sine / 5)) * CFrame.Angles(math.rad(0 - 85 * math.sin(sine / 5)), math.rad(3), math.rad(0)), 0.2)
						RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1 + 0.24 * math.cos(sine / 5), 0 - 0.32 * math.sin(sine / 5)) * CFrame.Angles(math.rad(0 + 85 * math.sin(sine / 5)), math.rad(-3), math.rad(0)), 0.2)
					end
					if attack == true and noleg == false then
						LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1 - 0.24 * math.cos(sine / 5), 0 + 0.32 * math.sin(sine / 5)) * CFrame.Angles(math.rad(0 - 65 * math.sin(sine / 5)), math.rad(3), math.rad(0)), 0.2)
						RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1 + 0.24 * math.cos(sine / 5), 0 - 0.32 * math.sin(sine / 5)) * CFrame.Angles(math.rad(0 + 65 * math.sin(sine / 5)), math.rad(-3), math.rad(0)), 0.2)
					end
				end
			end
			if 0 < #Effects then
				for e = 1, #Effects do
					if Effects[e] ~= nil then
						local Thing = Effects[e]
						if Thing ~= nil then
							local Part = Thing[1]
							local Mode = Thing[2]
							local Delay = Thing[3]
							local IncX = Thing[4]
							local IncY = Thing[5]
							local IncZ = Thing[6]
							if Thing[2] == "Shoot" then
								local Look = Thing[1]
								local move = 30
								if Thing[8] == 3 then
									move = 10
								end
								local hit, pos = rayCast(Thing[4], Thing[1], move, m)
								if Thing[10] ~= nil then
									da = pos
									cf2 = CFrame.new(Thing[4], Thing[10].Position)
									cfa = CFrame.new(Thing[4], pos)
									tehCF = cfa:lerp(cf2, 0.2)
									Thing[1] = tehCF.lookVector
								end
								local mag = (Thing[4] - pos).magnitude
								Effects.Head.Create(Torso.BrickColor, CFrame.new((Thing[4] + pos) / 2, pos) * CFrame.Angles(1.57, 0, 0), 1, mag * 5, 1, 0.5, 0, 0.5, 0.2)
								if Thing[8] == 2 then
									Effects.Ring.Create(Torso.BrickColor, CFrame.new((Thing[4] + pos) / 2, pos) * CFrame.Angles(1.57, 0, 0) * CFrame.fromEulerAnglesXYZ(1.57, 0, 0), 1, 1, 0.1, 0.5, 0.5, 0.1, 0.1, 1)
								end
								Thing[4] = Thing[4] + Look * move
								Thing[3] = Thing[3] - 1
								if 2 < Thing[5] then
									Thing[5] = Thing[5] - 0.3
									Thing[6] = Thing[6] - 0.3
								end
								if hit ~= nil then
									Thing[3] = 0
									if Thing[8] == 1 or Thing[8] == 3 then
										Damagefunc(hit, hit, Thing[5], Thing[6], Thing[7], "Normal", RootPart, 0, "", 1)
									elseif Thing[8] == 2 then
										Damagefunc(hit, hit, Thing[5], Thing[6], Thing[7], "Normal", RootPart, 0, "", 1)
										if hit.Parent:findFirstChild("Humanoid") ~= nil or hit.Parent.Parent:findFirstChild("Humanoid") ~= nil then
											ref = CFuncs.Part.Create(workspace, "Neon", 0, 1, BrickColor.new("Really red"), "Reference", Vector3.new())
											ref.Anchored = true
											ref.CFrame = CFrame.new(pos)
											CFuncs.Sound.Create("161006093", ref, 1, 1.2)
											game:GetService("Debris"):AddItem(ref, 0.2)
											Effects.Block.Create(Torso.BrickColor, CFrame.new(ref.Position) * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50)), 1, 1, 1, 10, 10, 10, 0.1, 2)
											Effects.Ring.Create(BrickColor.new("Bright yellow"), CFrame.new(ref.Position) * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50)), 1, 1, 0.1, 4, 4, 0.1, 0.1)
											--MagnitudeDamage(ref, 15, Thing[5] / 1.5, Thing[6] / 1.5, 0, "Normal", "", 1)
										end
									end
									ref = CFuncs.Part.Create(workspace, "Neon", 0, 1, BrickColor.new("Really red"), "Reference", Vector3.new())
									ref.Anchored = true
									ref.CFrame = CFrame.new(pos)
									Effects.Sphere.Create(Torso.BrickColor, CFrame.new(pos), 5, 5, 5, 1, 1, 1, 0.07)
									game:GetService("Debris"):AddItem(ref, 1)
								end
								if Thing[3] <= 0 then
									table.remove(Effects, e)
								end
							end
							if Thing[2] == "FireWave" then
								if Thing[3] <= Thing[4] then
									Thing[1].CFrame = Thing[1].CFrame * CFrame.fromEulerAnglesXYZ(0, 1, 0)
									Thing[3] = Thing[3] + 1
									Thing[6].Scale = Thing[6].Scale + Vector3.new(Thing[5], 0, Thing[5])
								else
									Part.Parent = nil
									table.remove(Effects, e)
								end
							end
							if Thing[2] ~= "Shoot" and Thing[2] ~= "Wave" and Thing[2] ~= "FireWave" then
								if Thing[1].Transparency <= 1 then
									if Thing[2] == "Block1" then
										Thing[1].CFrame = Thing[1].CFrame * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
										Mesh = Thing[7]
										Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
										Thing[1].Transparency = Thing[1].Transparency + Thing[3]
									elseif Thing[2] == "Block2" then
										Thing[1].CFrame = Thing[1].CFrame
										Mesh = Thing[7]
										Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
										Thing[1].Transparency = Thing[1].Transparency + Thing[3]
									elseif Thing[2] == "Fire" then
										Thing[1].CFrame = CFrame.new(Thing[1].Position) + Vector3.new(0, 0.2, 0)
										Thing[1].CFrame = Thing[1].CFrame * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
										Thing[1].Transparency = Thing[1].Transparency + Thing[3]
									elseif Thing[2] == "Cylinder" then
										Mesh = Thing[7]
										Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
										Thing[1].Transparency = Thing[1].Transparency + Thing[3]
									elseif Thing[2] == "Blood" then
										Mesh = Thing[7]
										Thing[1].CFrame = Thing[1].CFrame * CFrame.new(0, 0.5, 0)
										Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
										Thing[1].Transparency = Thing[1].Transparency + Thing[3]
									elseif Thing[2] == "Elec" then
										Mesh = Thing[10]
										Mesh.Scale = Mesh.Scale + Vector3.new(Thing[7], Thing[8], Thing[9])
										Thing[1].Transparency = Thing[1].Transparency + Thing[3]
									elseif Thing[2] == "Disappear" then
										Thing[1].Transparency = Thing[1].Transparency + Thing[3]
									elseif Thing[2] == "Shatter" then
										Thing[1].Transparency = Thing[1].Transparency + Thing[3]
										Thing[4] = Thing[4] * CFrame.new(0, Thing[7], 0)
										Thing[1].CFrame = Thing[4] * CFrame.fromEulerAnglesXYZ(Thing[6], 0, 0)
										Thing[6] = Thing[6] + Thing[5]
									end
								else
									Part.Parent = nil
									table.remove(Effects, e)
								end
							end
						end
					end
				end
			end
		end
	elseif isCmd(cmd, {"touchfling"}) then
		touchflingEnabled = true
		local lp = Player
		local movel = 0.1

		local function walkfling()
			while touchflingEnabled do
				game:GetService("RunService").Heartbeat:Wait()
				local char = lp.Character
				local hrp = char and char:FindFirstChild("HumanoidRootPart")

				if hrp then
					local vel = hrp.Velocity
					hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
					game:GetService("RunService").RenderStepped:Wait()
					hrp.Velocity = vel
					game:GetService("RunService").Stepped:Wait()
					hrp.Velocity = vel + Vector3.new(0, movel, 0)
					movel = -movel
				end
			end
		end

		if not touchflingThread or coroutine.status(touchflingThread) == "dead" then
			touchflingThread = coroutine.create(walkfling)
			coroutine.resume(touchflingThread)
		end

	elseif isCmd(cmd, {"untouchfling"}) then
		touchflingEnabled = false
	elseif isCmd(cmd, {"jumppower"}) then
		local amount = tonumber(args[2])
		if amount then
			local hum = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
			if hum then
				hum.JumpPower = amount
			end
		end
	elseif isCmd(cmd, {"to"}) then
		local targetName = args[2]
		if targetName then
			targetName = targetName:lower()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Name:lower():sub(1, #targetName) == targetName or plr.DisplayName:lower():sub(1, #targetName) == targetName then
					local myChar = player.Character
					local targetChar = plr.Character
					if myChar and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
						local hrp = myChar:FindFirstChild("HumanoidRootPart")
						if hrp then
							hrp.CFrame = targetChar.HumanoidRootPart.CFrame
						end
					end
					break
				end
			end
		end
	elseif isCmd(cmd, {"longleftleg"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		local Character = Player.Character

		local Hum = {
			"BodyTypeScale",
			"BodyProportionScale",
			"BodyWidthScale",
			"BodyHeightScale",
			"BodyDepthScale",
			"HeadScale"
		}

		function Remove()
			repeat wait() until Character.LeftFoot:FindFirstChild("OriginalSize")
			delete(Character.LeftFoot.OriginalSize)
			delete(Character.LeftLowerLeg.OriginalSize)
			delete(Character.LeftUpperLeg.OriginalSize)
			delete(Character.RightFoot.OriginalSize)
			delete(Character.RightLowerLeg.OriginalSize)
			delete(Character.RightUpperLeg.OriginalSize)
		end

		delete(Character.LeftLowerLeg.LeftKneeRigAttachment.OriginalPosition)
		delete(Character.LeftUpperLeg.LeftKneeRigAttachment.OriginalPosition)
		delete(Character.LeftLowerLeg.LeftKneeRigAttachment)
		delete(Character.LeftUpperLeg.LeftKneeRigAttachment)
		for i=1,4 do
			Remove()
			delete(Character.Humanoid[Hum[i]])
			print("yeah")
			wait(1)
		end
	elseif isCmd(cmd, {"speedcoil"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		local coil = Instance.new("Tool", Player.Backpack)
		coil.Grip = CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, 90)
		coil.Name = "SpeedCoil"
		local handle = Instance.new("Part", coil)
		handle.Name = "Handle"
		handle.Size = Vector3.new(1.3, 1.3, 2.4)
		local mesh = Instance.new("SpecialMesh", handle)
		mesh.Scale = Vector3.new(0.7, 0.7, 0.7)
		mesh.MeshType = Enum.MeshType.FileMesh
		mesh.TextureId = "http://www.roblox.com/asset/?id=99170547"
		mesh.MeshId = "http://www.roblox.com/asset/?id=16606212"
		local sound
		local arm = Player.Character["Right Arm"]

		local function findRemoteEvent(name)
			local replicatedStorage = game:GetService("ReplicatedStorage")
			local workspace = game:GetService("Workspace")
			for _, parent in ipairs({replicatedStorage, workspace}) do
				for _, child in ipairs(parent:GetDescendants()) do
					if child:IsA("RemoteEvent") and child.Name == name then
						return child
					end
				end
			end
			return nil
		end

		sp = coil

		sp.Equipped:Connect(function()
			local speedboost = 1
			Player.Character.Humanoid.WalkSpeed = 16+16*speedboost
			local remote = findRemoteEvent("AC6_FE_Sounds")
			if handle then
				local assetId = "http://www.roblox.com/asset/?id=99173388"
				local soundName = "Sound_" .. tostring(math.random(100000, 999999))
				local pitch = 1
				local volume = 1

				remote:FireServer("newSound", soundName, arm, assetId, pitch, volume, false)
				remote:FireServer("playSound", soundName)
				sound = soundName
			end
			sp.Unequipped:Connect(function()
				Player.Character.Humanoid.WalkSpeed = 16
				delete(arm:FindFirstChild(sound))
			end)
		end)
	elseif isCmd(cmd, {"boombox"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		local player = Player
		local boom = Instance.new("Tool")
		boom.Name = "BoomBox"
		boom.Parent = player.Backpack
		boom.Grip = CFrame.new(1, -1.25, 0) * CFrame.Angles(0, math.rad(-90), 0)
		boom.TextureId = "http://www.roblox.com/asset/?id=212303004"
		local songgui
		local song
		local mouse = player:GetMouse()
		local handle = Instance.new("Part")
		handle.Name = "Handle"
		handle.Size = Vector3.new(3.2, 1.6, 1.2)
		handle.Parent = boom
		local mesh = Instance.new("SpecialMesh", handle)
		mesh.MeshType = Enum.MeshType.FileMesh
		mesh.MeshId = "http://www.roblox.com/asset/?id=212302951"
		mesh.TextureId = "http://www.roblox.com/asset/?id=212303049"
		mesh.Scale = Vector3.new(4, 4, 4)
		local function findRemoteEvent(name)
			for _, parent in ipairs({game:GetService("ReplicatedStorage"), game:GetService("Workspace")}) do
				for _, child in ipairs(parent:GetDescendants()) do
					if child:IsA("RemoteEvent") and child.Name == name then
						return child
					end
				end
			end
			return nil
		end
		boom.Equipped:Connect(function()
			local clicked = false
			local clickConnection

			clickConnection = mouse.Button1Up:Connect(function()
				if clicked then return end

				local sg = Instance.new("ScreenGui")
				sg.Name = "ChooseSongGui"
				sg.ResetOnSpawn = false

				local frame = Instance.new("Frame")
				frame.Style = "RobloxRound"
				frame.Size = UDim2.new(0.25, 0, 0.25, 0)
				frame.Position = UDim2.new(0.375, 0, 0.375, 0)
				frame.Parent = sg
				frame.Draggable = true

				local text = Instance.new("TextLabel")
				text.BackgroundTransparency = 1
				text.TextStrokeTransparency = 0
				text.TextColor3 = Color3.new(1, 1, 1)
				text.Size = UDim2.new(1, 0, 0.6, 0)
				text.TextScaled = true
				text.Text = "Lay down the beat!\nPut in the ID number for a song you love that's been uploaded to ROBLOX.\nLeave it blank to stop playing music."
				text.Parent = frame

				local input = Instance.new("TextBox")
				input.BackgroundColor3 = Color3.new(0, 0, 0)
				input.BackgroundTransparency = 0.5
				input.BorderColor3 = Color3.new(1, 1, 1)
				input.TextColor3 = Color3.new(1, 1, 1)
				input.TextStrokeTransparency = 1
				input.TextScaled = true
				input.Text = "142376088"
				input.Size = UDim2.new(1, 0, 0.2, 0)
				input.Position = UDim2.new(0, 0, 0.6, 0)
				input.Parent = frame

				local button = Instance.new("TextButton")
				button.Style = "RobloxButton"
				button.Size = UDim2.new(0.75, 0, 0.2, 0)
				button.Position = UDim2.new(0.125, 0, 0.8, 0)
				button.TextColor3 = Color3.new(1, 1, 1)
				button.TextStrokeTransparency = 0
				button.Text = "Play!"
				button.TextScaled = true
				button.Parent = frame

				button.MouseButton1Click:Connect(function()
					clicked = true
					local remote = findRemoteEvent("AC6_FE_Sounds")
					local assetId = "rbxassetid://"..tonumber(input.Text)
					local randomName = "Sound_" .. tostring(math.random(100000, 999999))
					local pitch = 1
					local volume = 1

					if assetId and remote then
						local head = player.Character and player.Character:FindFirstChild("Right Arm") or player.Character.PrimaryPart
						if head then
							remote:FireServer("newSound", randomName, head, assetId, pitch, volume, true)
							remote:FireServer("playSound", randomName)
							song = randomName
						end
					end

					sg:Destroy()
				end)

				sg.Parent = player:WaitForChild("PlayerGui")
				songgui = sg
			end)
			boom.Unequipped:Connect(function()
				clicked = false
				clickConnection:Disconnect()
				songgui:Destroy()
				if song then
					delete(player.Character:FindFirstChild("Right Arm"):FindFirstChild(song))
				end
			end)
		end)
	elseif isCmd(cmd, {"gravity"}) then
		local amount = tonumber(args[2])
		local ws = workspace
		ws.Gravity = amount
	elseif isCmd(cmd, {"noclip"}) then
		local function disableCollision()
			local char = player.Character
			if char then
				for _, part in pairs(char:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end

		if noclipConn then
			noclipConn:Disconnect()
		end

		noclipConn = game:GetService("RunService").Stepped:Connect(disableCollision)
	elseif isCmd(cmd, {"clip"}) then
		if noclipConn then
			noclipConn:Disconnect()
			noclipConn = nil
		end

		local char = player.Character
		if char then
			for _, part in pairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	elseif isCmd(cmd, {"kdv3"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		function notify(title,text,duration)
			game.StarterGui:SetCore("SendNotification", {
				Title = title or "", 
				Text = text or "",
				Duration = duration or 5
			})
		end
		local genv = (getgenv and (getgenv() ~= getfenv()) and getgenv()) or _G
		local char = Player.Character or Player.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
		local simRadius = gethiddenproperty and gethiddenproperty(Player,"SimulationRadius")
		local requiredRadius = 20
		local isR15 = hum.RigType == Enum.HumanoidRigType.R15
		local forcefield = char:FindFirstChildOfClass("ForceField")
		local fakeHum = hum:Clone()
		local hrp = char:WaitForChild("HumanoidRootPart")
		local hrpCF = hrp.CFrame
		local stopAlign = false
		local stopAntiVoid = false
		local limbs = {}
		local hatHandles = {}
		local reanimConnections = {}

		runCommand("clip")

		if simRadius and simRadius < requiredRadius then
			repeat
				notify("Please wait",`Waiting for bigger SimulationRadius ({tostring(math.floor(simRadius))}/{tostring(requiredRadius)})`, 2)
				task.wait(2)
			until gethiddenproperty(Player,"SimulationRadius") >= requiredRadius
			if Player.Character == nil or Player.Character ~= char or hum.Parent == nil or hum.Health <= 0 then return end
		end

		if forcefield then forcefield:Destroy() end
		char.Archivable = true

		local rig = (not isR15) and char:Clone()

		if isR15 then
			local canGetObjects, loadedRig = pcall(function() return game:GetObjects("rbxassetid://18418211383")[1] end)
			local r6Rig = isTesting and rStorage:WaitForChild("R6Rig") or canGetObjects and loadedRig or loadstring(httpget("https://gist.githubusercontent.com/someunknowndude/ad264038a91f7fa11bec2f67dad3feaf/raw"))()
			local humDesc = players:GetCharacterAppearanceAsync(Player.UserId)
			local r6Head = r6Rig.Head
			local r15Head = char.Head
			local surfaceAppearance = r15Head:FindFirstChildOfClass("SurfaceAppearance")
			local face = r15Head:FindFirstChild("face")

			if surfaceAppearance then 
				surfaceAppearance:Clone().Parent = r6Head
			else
				--if face then r6Head.face.Texture = face.Texture end
				--r6Head.face.Transparency = 0
			end

			for i,v in pairs(r15Head:GetChildren()) do
				if not v:IsA("Attachment") then continue end
				v:Clone().Parent = r6Head
			end

			for i,v in pairs(humDesc:GetDescendants()) do
				if v:IsA("BodyColors") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic") then
					v.Parent = r6Rig
					continue
				end
				if v:IsA("Accessory") or v:IsA("Hat") then
					r6Rig:WaitForChild("Humanoid"):AddAccessory(v)
				end
			end


			rig = r6Rig
		else
			local mesh = char.Head:FindFirstChildOfClass("SpecialMesh")
			local face = char.Head:FindFirstChild("face")
			if mesh and face then
				delete(face)
			end
		end	

		local rigHRP = rig:WaitForChild("HumanoidRootPart")
		local rigHum = rig:FindFirstChild("Humanoid")

		rig.Name = "wacky reanim rig"


		for i,v in pairs(char:GetChildren()) do
			if not v:IsA("BasePart") then continue end
			table.insert(limbs, {v,rig[v.Name]})
		end


		local accessories = hum:GetAccessories()
		local rigAccessories = rigHum:GetAccessories()

		for i,v in pairs(accessories) do
			if not isR15 then
				table.insert(hatHandles,{v.Handle,rigAccessories[i].Handle})
				continue
			end
			for _,rigAcc in pairs(rigAccessories) do
				local handle = rigAcc.Handle
				local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle
				local texture = handle == mesh and mesh.TextureID or mesh.TextureId
				if not (rigAcc.Name == v.Name and mesh.MeshId == v.Handle.MeshId and texture == v.Handle.TextureID) then continue end
				table.insert(hatHandles,{v.Handle,rigAcc.Handle})
				continue 
			end
		end

		local clock = os and os.clock or tick
		local cos = math.cos
		local sin = math.sin
		local cfNew = CFrame.new
		local cfZero = CFrame.identity
		local v3New = Vector3.new
		local v3Zero = Vector3.zero

		local changedMaxSimRad = pcall(sethiddenproperty, Player, "MaximumSimulationRadius", 1000)
		local changedSimRad = pcall(sethiddenproperty, Player, "SimulationRadius", 1000)
		local netlessCF = cfZero
		local sineValue = 0


		local function align(part0, part1, offset)
			if stopAlign then return end
			if part0 and part0.Parent and part1 and part1.Parent then
				local part0_mass = part1.Mass * 5
				part0.AssemblyLinearVelocity = v3New(part1.AssemblyLinearVelocity.X * part0_mass, sineValue, part1.AssemblyLinearVelocity.Z * part0_mass)
				part0.AssemblyAngularVelocity = part1.AssemblyAngularVelocity

				if isnetworkowner(part0) then
					part0.CFrame = part1.CFrame * offset
				end
			end
		end

		local function setCamera(model)
			local oldCamCF = workspace.CurrentCamera.CFrame
			workspace.CurrentCamera.CameraSubject = model.Humanoid
			workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Once(function()
				workspace.CurrentCamera.CFrame = oldCamCF
			end)
		end

		local function disableCollisions(model,canTouchAndCast)
			for _, part in next, model:GetDescendants() do
				if part and part:IsA("BasePart") then
					part.CanCollide = false
					part.CanQuery = canTouchAndCast
					part.CanTouch = canTouchAndCast
				end
			end
		end

		local function makeTransparent(model)
			for i,v in pairs(model:GetDescendants()) do
				if not (v:IsA("BasePart") or v:IsA("Decal")) then continue end
				v.Transparency = 1
			end
		end

		local function breakJoints(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("JointInstance") then continue end
				delete(v)
			end
		end

		local function removeScripts(model)
			for i,v in pairs(model:GetChildren()) do
				if not (v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") or v.Name == "Animate") then continue end
				delete(v)
			end
		end

		local function removeTouchTriggers(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("TouchTransmitter") then continue end
				delete(v)
			end
		end

		local function onPostSim()
			for _, data in next, limbs do
				align(data[1], data[2],netlessCF)
			end

			for _, data in next, hatHandles do
				align(data[1], data[2], netlessCF)
			end
		end

		local function onPreSim()
			netlessCF = cfNew(0.01 * sin(clock()*16), 0, 0.01 * math.cos(clock()*16))
			sineValue = 40 - 3 * sin(clock()*10)

			if stopAntiVoid or rigHRP.Position.Y > (workspace.FallenPartsDestroyHeight + 50) then return end
			rigHRP.CFrame = hrpCF
			rigHRP.AssemblyLinearVelocity = v3Zero
			rigHRP.AssemblyAngularVelocity = v3Zero
		end


		rigHRP.CFrame = hrpCF
		rig.Parent = workspace
		Player.Character = rig
		setCamera(rig)
		rig.Animate.Enabled = false
		rig.Animate.Enabled = true
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		repeat task.wait() until limbs[3][1].CanCollide
		task.wait(0.05)
		delete(hum)
		repeat task.wait() until hum.Parent == nil
		task.wait()
		fakeHum.Parent = char
		task.wait()
		table.insert(reanimConnections, game:GetService("RunService").PreSimulation:Connect(onPreSim))
		table.insert(reanimConnections, game:GetService("RunService").PostSimulation:Connect(onPostSim))
		table.insert(reanimConnections, game:GetService("RunService").Stepped:Connect(function()
			disableCollisions(char,false)
			disableCollisions(rig,true)
		end))

		breakJoints(char)
		makeTransparent(char)
		removeScripts(char)
		removeTouchTriggers(char)

		genv.LoadLibrary = function(lib) return loadstring(httpget("https://raw.githubusercontent.com/Roblox/Core-Scripts/master/CoreScriptsRoot/Libraries/" .. lib .. ".lua"))() end

		local reset = Instance.new("BindableEvent")
		reset.Event:Connect(function()
			if stopAlign then
				local hum = character:FindFirstChildOfClass("Humanoid")
				if not hum then return character:BreakJoints() end
				hum.Health = 0
				return
			end
			notify("Resetting", "Please wait ~6 seconds", 6)
			stopAntiVoid = true
			rigHRP.Anchored = true
			rigHRP.CFrame = CFrame.new(0,workspace.FallenPartsDestroyHeight + 5,0)
			task.wait(0.5)
			stopAlign = true
			rigHum:ChangeState(Enum.HumanoidStateType.Dead)
			Player.CharacterAdded:Wait()
			rig:Destroy()
			for i,v in pairs(reanimConnections) do
				v:Disconnect()
			end
		end)

		game.StarterGui:SetCore("ResetButtonCallback", reset)

		notify("Success!", "reanim loaded!")
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Nitro-GT/OxideReanim/refs/heads/main/KrystalDance3"))()
	elseif isCmd(cmd, {"hideandseekaudio"}) then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/nmalka0I/nmalka0I/refs/heads/main/H%26SAudioPlayer"))()
	elseif isCmd(cmd, {"brookhavenaudio"}) then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ameicaa1/brookhaven-script/main/brookhaven%20script.lua"))()
	elseif isCmd(cmd, {"harked"}) then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/JxcExploit/Harkedv2-script/main/Leaked-v2hardked"))()
	elseif isCmd(cmd, {"hammer"}) then
		loadstring(game:HttpGet("https://pastebin.com/raw/q6yHJSXK", true))()
	elseif isCmd(cmd, {"washiez"}) then
		loadstring(game:HttpGet('https://washiez.lol/script.lua'))()
	elseif isCmd(cmd, {"rejoin"}) then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
	elseif isCmd(cmd, {"ac6"}) then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Roblox-HttpSpy/my-Garbage/refs/heads/main/FeMusicExploit.lua"))()
	elseif isCmd(cmd, {"quirkycmd"}) then
		loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
	elseif isCmd(cmd, {"fencingfucker"}) then
		-- Farewell Infortality.
		-- Version: 2.82
		-- Instances:
		local ScreenGui = Instance.new("ScreenGui")
		local OpenFrame = Instance.new("Frame")
		local Open = Instance.new("TextButton")
		local Main = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		local RealsimAnime = Instance.new("TextButton")
		local Brick = Instance.new("TextButton")
		local Reach = Instance.new("TextButton")
		local Invisible = Instance.new("TextButton")
		local Close = Instance.new("TextButton")
		local TextLabel_2 = Instance.new("TextLabel")
		--Properties:
		ScreenGui.Name = "ScreenGui"
		ScreenGui.Parent = game.CoreGui

		OpenFrame.Name = "OpenFrame"
		OpenFrame.Parent = ScreenGui
		OpenFrame.BackgroundColor3 = Color3.new(0.513726, 0.560784, 1)
		OpenFrame.Position = UDim2.new(0.936265111, 0, 0.837837815, 0)
		OpenFrame.Size = UDim2.new(0, 100, 0, 45)

		Open.Name = "Open"
		Open.Parent = OpenFrame
		Open.BackgroundColor3 = Color3.new(0, 0.0666667, 1)
		Open.Position = UDim2.new(-0.0299999714, 0, -0.111111112, 0)
		Open.Size = UDim2.new(0, 103, 0, 50)
		Open.Font = Enum.Font.Cartoon
		Open.Text = "X"
		Open.TextColor3 = Color3.new(0, 0, 0)
		Open.TextSize = 50
		Open.MouseButton1Down:connect(function()
			Main.Visible = true
			OpenFrame.Visible = false 
		end)

		Main.Name = "Main"
		Main.Parent = ScreenGui
		Main.Active = true
		Main.BackgroundColor3 = Color3.new(0.364706, 0.352941, 0.352941)
		Main.Position = UDim2.new(0.23008287, 0, 0.226044238, 0)
		Main.Size = UDim2.new(0, 648, 0, 366)
		Main.Visible = false
		Main.Draggable = true

		TextLabel.Parent = Main
		TextLabel.BackgroundColor3 = Color3.new(0, 0, 0)
		TextLabel.Size = UDim2.new(0, 648, 0, 50)
		TextLabel.Font = Enum.Font.Cartoon
		TextLabel.Text = "FENCING FUCKER V1"
		TextLabel.TextColor3 = Color3.new(0.807843, 0.266667, 0.807843)
		TextLabel.TextSize = 30
		TextLabel.TextStrokeTransparency = 0

		RealsimAnime.Name = "Realsim Anime"
		RealsimAnime.Parent = Main
		RealsimAnime.BackgroundColor3 = Color3.new(0.137255, 0.509804, 1)
		RealsimAnime.Position = UDim2.new(0.356481493, 0, 0.172131151, 0)
		RealsimAnime.Size = UDim2.new(0, 200, 0, 50)
		RealsimAnime.Font = Enum.Font.Cartoon
		RealsimAnime.Text = "Realsim Anim"
		RealsimAnime.TextColor3 = Color3.new(0, 0, 0)
		RealsimAnime.TextSize = 30
		RealsimAnime.MouseButton1Down:connect(function()
			--<//Realism Script by xAcrozed.\\>--
			--/>>/>>/>>/>>/>>/>>/>>/>>/>>/--
			--------------------------------

			--//Variables\\--
			local lp      = Player
			local animate = lp.Character.Animate

			--//Scripting\\--
			animate.walk.WalkAnim.AnimationId   = "rbxassetid://376760331"
			animate.idle.Animation1.AnimationId = "rbxassetid://75356212"
			animate.idle.Animation1.Looped      = true
			lp.character.Humanoid.WalkSpeed     = 25 
		end)

		Brick.Name = "Brick"
		Brick.Parent = Main
		Brick.BackgroundColor3 = Color3.new(0.137255, 0.509804, 1)
		Brick.Position = UDim2.new(0.0370370373, 0, 0.431694001, 0)
		Brick.Size = UDim2.new(0, 200, 0, 50)
		Brick.Font = Enum.Font.Cartoon
		Brick.Text = "Brick Spam "
		Brick.TextColor3 = Color3.new(0, 0, 0)
		Brick.TextSize = 30
		Brick.MouseButton1Down:connect(function()
			-- https://www.roblox.com/games/12109643/Fencing

			game:GetService('RunService').Stepped:connect(function()
				for i,v in pairs(Player.Character:GetChildren()) do
					if v.Name == "Spray" then
						if v.Handle.Mesh then
							v.Handle.Mesh:Destroy()
						end
						v.Parent = workspace
					end
				end
			end)
			local function paint()
				for i,v in pairs(game.Workspace:GetChildren())do
					if v.Name == "Handle" then
						v.CFrame = Player.Character.HumanoidRootPart.CFrame
						v.Transparency = 1
						v.CanCollide = false
						wait()
						v.CFrame = Player.Character["Left Leg"].CFrame
					end
				end
			end
			local function equip()
				for i,v in pairs(Player.Backpack:GetChildren())do
					if v.Name == "Spray" then
						Player.Character.Humanoid:EquipTool(v)
					end
				end
			end
			while wait(0.05) do
				paint()
				equip()
			end
		end)

		Reach.Name = "Reach"
		Reach.Parent = Main
		Reach.BackgroundColor3 = Color3.new(0.137255, 0.509804, 1)
		Reach.Position = UDim2.new(0.345679015, 0, 0.677595675, 0)
		Reach.Size = UDim2.new(0, 200, 0, 50)
		Reach.Font = Enum.Font.Cartoon
		Reach.Text = "REACH"
		Reach.TextColor3 = Color3.new(0, 0, 0)
		Reach.TextSize = 40
		Reach.MouseButton1Down:connect(function()
			local foil=Player.Backpack.Foil
			a=Instance.new("SelectionBox",foil.Handle)
			a.Adornee=foil.Handle
			foil.Handle.Size=Vector3.new(0.2,0.2,120)
			foil.Equipped:connect(function()
				while wait() do
					game.Workspace[Player.Name].Foil.GripPos=Vector3.new(0,0,-60)
				end
			end)
		end)

		Invisible.Name = "Invisible"
		Invisible.Parent = Main
		Invisible.BackgroundColor3 = Color3.new(0.137255, 0.509804, 1)
		Invisible.Position = UDim2.new(0.654321015, 0, 0.431694001, 0)
		Invisible.Size = UDim2.new(0, 200, 0, 50)
		Invisible.Font = Enum.Font.Cartoon
		Invisible.Text = "Invisible"
		Invisible.TextColor3 = Color3.new(0, 0, 0)
		Invisible.TextSize = 30
		Invisible.MouseButton1Down:connect(function()
			Local = game:GetService('Players').LocalPlayer
			Char  = Local.Character
			touched,tpdback = false, false
			Local.CharacterAdded:connect(function(char)
				if script.Disabled ~= true then
					wait(.25)
					loc = Char.HumanoidRootPart.Position
					Char:MoveTo(box.Position + Vector3.new(0,.5,0))
				end
			end)
			game:GetService('UserInputService').InputBegan:connect(function(key)
				if key.KeyCode == Enum.KeyCode.Equals then
					if script.Disabled ~= true then
						script.Disabled = true
						print'you may re-execute'
					end
				end
			end)
			box = Instance.new('Part',workspace)
			box.Anchored = true
			box.CanCollide = true
			box.Size = Vector3.new(10,1,10)
			box.Position = Vector3.new(0,10000,0)
			box.Touched:connect(function(part)
				if (part.Parent.Name == Local.Name) then
					if touched == false then
						touched = true
						function apply()
							if script.Disabled ~= true then
								no = Char.HumanoidRootPart:Clone()
								wait(.25)
								Char.HumanoidRootPart:Destroy()
								no.Parent = Char
								Char:MoveTo(loc)
								touched = false
							end end
						if Char then
							apply()
						end
					end
				end
			end)
			repeat wait() until Char
			loc = Char.HumanoidRootPart.Position
			Char:MoveTo(box.Position + Vector3.new(0,.5,0))
		end)

		Close.Name = "Close"
		Close.Parent = Main
		Close.BackgroundColor3 = Color3.new(0.137255, 0.509804, 1)
		Close.Position = UDim2.new(0.442901224, 0, 0.431694001, 0)
		Close.Size = UDim2.new(0, 73, 0, 50)
		Close.Font = Enum.Font.Cartoon
		Close.Text = "CLOSE"
		Close.TextColor3 = Color3.new(0, 0, 0)
		Close.TextSize = 20
		Close.MouseButton1Down:connect(function()
			OpenFrame.Visible = true
			Main.Visible = false 
		end)

		TextLabel_2.Parent = Main
		TextLabel_2.BackgroundColor3 = Color3.new(0, 0, 0)
		TextLabel_2.Position = UDim2.new(0, 0, 0.863388002, 0)
		TextLabel_2.Size = UDim2.new(0, 648, 0, 50)
		TextLabel_2.Font = Enum.Font.SourceSans
		TextLabel_2.Text = "GUI BY LUDDE2K ON V3RM"
		TextLabel_2.TextColor3 = Color3.new(1, 0, 1)
		TextLabel_2.TextSize = 30
		-- Scripts:
	elseif isCmd(cmd, {"quirkycmddex"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		loadstring(game:HttpGet("https://gist.githubusercontent.com/someunknowndude/8ee80f941d68d5f95e5982165e9ad42d/raw"))()
	elseif isCmd(cmd, {"explorer"}) then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	elseif isCmd(cmd, {"serveradmin"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		function notify(title,text,duration)
			game.StarterGui:SetCore("SendNotification", {
				Title = title or "", 
				Text = text or "",
				Duration = duration or 5
			})
		end
		local genv = (getgenv and (getgenv() ~= getfenv()) and getgenv()) or _G
		local char = Player.Character or Player.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
		local simRadius = gethiddenproperty and gethiddenproperty(Player,"SimulationRadius")
		local requiredRadius = 20
		local isR15 = hum.RigType == Enum.HumanoidRigType.R15
		local forcefield = char:FindFirstChildOfClass("ForceField")
		local fakeHum = hum:Clone()
		local hrp = char:WaitForChild("HumanoidRootPart")
		local hrpCF = hrp.CFrame
		local stopAlign = false
		local stopAntiVoid = false
		local limbs = {}
		local hatHandles = {}
		local reanimConnections = {}

		runCommand("clip")

		if simRadius and simRadius < requiredRadius then
			repeat
				notify("Please wait",`Waiting for bigger SimulationRadius ({tostring(math.floor(simRadius))}/{tostring(requiredRadius)})`, 2)
				task.wait(2)
			until gethiddenproperty(Player,"SimulationRadius") >= requiredRadius
			if Player.Character == nil or Player.Character ~= char or hum.Parent == nil or hum.Health <= 0 then return end
		end

		if forcefield then forcefield:Destroy() end
		char.Archivable = true

		local rig = (not isR15) and char:Clone()

		if isR15 then
			local canGetObjects, loadedRig = pcall(function() return game:GetObjects("rbxassetid://18418211383")[1] end)
			local r6Rig = isTesting and rStorage:WaitForChild("R6Rig") or canGetObjects and loadedRig or loadstring(httpget("https://gist.githubusercontent.com/someunknowndude/ad264038a91f7fa11bec2f67dad3feaf/raw"))()
			local humDesc = players:GetCharacterAppearanceAsync(Player.UserId)
			local r6Head = r6Rig.Head
			local r15Head = char.Head
			local surfaceAppearance = r15Head:FindFirstChildOfClass("SurfaceAppearance")
			local face = r15Head:FindFirstChild("face")

			if surfaceAppearance then 
				surfaceAppearance:Clone().Parent = r6Head
			else
				--if face then r6Head.face.Texture = face.Texture end
				--r6Head.face.Transparency = 0
			end

			for i,v in pairs(r15Head:GetChildren()) do
				if not v:IsA("Attachment") then continue end
				v:Clone().Parent = r6Head
			end

			for i,v in pairs(humDesc:GetDescendants()) do
				if v:IsA("BodyColors") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic") then
					v.Parent = r6Rig
					continue
				end
				if v:IsA("Accessory") or v:IsA("Hat") then
					r6Rig:WaitForChild("Humanoid"):AddAccessory(v)
				end
			end


			rig = r6Rig
		else
			local mesh = char.Head:FindFirstChildOfClass("SpecialMesh")
			local face = char.Head:FindFirstChild("face")
			if mesh and face then
				delete(face)
			end
		end	

		local rigHRP = rig:WaitForChild("HumanoidRootPart")
		local rigHum = rig:FindFirstChild("Humanoid")

		rig.Name = "wacky reanim rig"


		for i,v in pairs(char:GetChildren()) do
			if not v:IsA("BasePart") then continue end
			table.insert(limbs, {v,rig[v.Name]})
		end


		local accessories = hum:GetAccessories()
		local rigAccessories = rigHum:GetAccessories()

		for i,v in pairs(accessories) do
			if not isR15 then
				table.insert(hatHandles,{v.Handle,rigAccessories[i].Handle})
				continue
			end
			for _,rigAcc in pairs(rigAccessories) do
				local handle = rigAcc.Handle
				local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle
				local texture = handle == mesh and mesh.TextureID or mesh.TextureId
				if not (rigAcc.Name == v.Name and mesh.MeshId == v.Handle.MeshId and texture == v.Handle.TextureID) then continue end
				table.insert(hatHandles,{v.Handle,rigAcc.Handle})
				continue 
			end
		end

		local clock = os and os.clock or tick
		local cos = math.cos
		local sin = math.sin
		local cfNew = CFrame.new
		local cfZero = CFrame.identity
		local v3New = Vector3.new
		local v3Zero = Vector3.zero

		local changedMaxSimRad = pcall(sethiddenproperty, Player, "MaximumSimulationRadius", 1000)
		local changedSimRad = pcall(sethiddenproperty, Player, "SimulationRadius", 1000)
		local netlessCF = cfZero
		local sineValue = 0


		local function align(part0, part1, offset)
			if stopAlign then return end
			if part0 and part0.Parent and part1 and part1.Parent then
				local part0_mass = part1.Mass * 5
				part0.AssemblyLinearVelocity = v3New(part1.AssemblyLinearVelocity.X * part0_mass, sineValue, part1.AssemblyLinearVelocity.Z * part0_mass)
				part0.AssemblyAngularVelocity = part1.AssemblyAngularVelocity

				if isnetworkowner(part0) then
					part0.CFrame = part1.CFrame * offset
				end
			end
		end

		local function setCamera(model)
			local oldCamCF = workspace.CurrentCamera.CFrame
			workspace.CurrentCamera.CameraSubject = model.Humanoid
			workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Once(function()
				workspace.CurrentCamera.CFrame = oldCamCF
			end)
		end

		local function disableCollisions(model,canTouchAndCast)
			for _, part in next, model:GetDescendants() do
				if part and part:IsA("BasePart") then
					part.CanCollide = false
					part.CanQuery = canTouchAndCast
					part.CanTouch = canTouchAndCast
				end
			end
		end

		local function makeTransparent(model)
			for i,v in pairs(model:GetDescendants()) do
				if not (v:IsA("BasePart") or v:IsA("Decal")) then continue end
				v.Transparency = 1
			end
		end

		local function breakJoints(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("JointInstance") then continue end
				delete(v)
			end
		end

		local function removeScripts(model)
			for i,v in pairs(model:GetChildren()) do
				if not (v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") or v.Name == "Animate") then continue end
				delete(v)
			end
		end

		local function removeTouchTriggers(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("TouchTransmitter") then continue end
				delete(v)
			end
		end

		local function onPostSim()
			for _, data in next, limbs do
				align(data[1], data[2],netlessCF)
			end

			for _, data in next, hatHandles do
				align(data[1], data[2], netlessCF)
			end
		end

		local function onPreSim()
			netlessCF = cfNew(0.01 * sin(clock()*16), 0, 0.01 * math.cos(clock()*16))
			sineValue = 40 - 3 * sin(clock()*10)

			if stopAntiVoid or rigHRP.Position.Y > (workspace.FallenPartsDestroyHeight + 50) then return end
			rigHRP.CFrame = hrpCF
			rigHRP.AssemblyLinearVelocity = v3Zero
			rigHRP.AssemblyAngularVelocity = v3Zero
		end


		rigHRP.CFrame = hrpCF
		rig.Parent = workspace
		Player.Character = rig
		setCamera(rig)
		rig.Animate.Enabled = false
		rig.Animate.Enabled = true
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		repeat task.wait() until limbs[3][1].CanCollide
		task.wait(0.05)
		delete(hum)
		repeat task.wait() until hum.Parent == nil
		task.wait()
		fakeHum.Parent = char
		task.wait()
		table.insert(reanimConnections, game:GetService("RunService").PreSimulation:Connect(onPreSim))
		table.insert(reanimConnections, game:GetService("RunService").PostSimulation:Connect(onPostSim))
		table.insert(reanimConnections, game:GetService("RunService").Stepped:Connect(function()
			disableCollisions(char,false)
			disableCollisions(rig,true)
		end))

		breakJoints(char)
		makeTransparent(char)
		removeScripts(char)
		removeTouchTriggers(char)

		genv.LoadLibrary = function(lib) return loadstring(httpget("https://raw.githubusercontent.com/Roblox/Core-Scripts/master/CoreScriptsRoot/Libraries/" .. lib .. ".lua"))() end

		local reset = Instance.new("BindableEvent")
		reset.Event:Connect(function()
			if stopAlign then
				local hum = character:FindFirstChildOfClass("Humanoid")
				if not hum then return character:BreakJoints() end
				hum.Health = 0
				return
			end
			notify("Resetting", "Please wait ~6 seconds", 6)
			stopAntiVoid = true
			rigHRP.Anchored = true
			rigHRP.CFrame = CFrame.new(0,workspace.FallenPartsDestroyHeight + 5,0)
			task.wait(0.5)
			stopAlign = true
			rigHum:ChangeState(Enum.HumanoidStateType.Dead)
			Player.CharacterAdded:Wait()
			rig:Destroy()
			for i,v in pairs(reanimConnections) do
				v:Disconnect()
			end
		end)

		game.StarterGui:SetCore("ResetButtonCallback", reset)

		notify("Success!", "reanim loaded!")
		delete = delete or _G.delete
		local function breakJoints(instance)
			for i,v in pairs(instance:GetDescendants()) do
				if not (v:IsA("Weld") or v:IsA("WeldConstraint") or v:IsA("JointInstance")) then continue end
				delete(v)
			end
		end

		wait(0.2)

		Player = Player
		PlayerGui = Player.PlayerGui
		Cam = workspace.CurrentCamera
		Backpack = Player.Backpack
		Character = Player.Character
		Humanoid = Character.Humanoid
		Mouse = Player:GetMouse()
		RootPart = Character["HumanoidRootPart"]
		Torso = Character["Torso"]
		Head = Character["Head"]
		RightArm = Character["Right Arm"]
		LeftArm = Character["Left Arm"]
		RightLeg = Character["Right Leg"]
		LeftLeg = Character["Left Leg"]
		RootJoint = RootPart["RootJoint"]
		Neck = Torso["Neck"]
		RightShoulder = Torso["Right Shoulder"]
		LeftShoulder = Torso["Left Shoulder"]
		RightHip = Torso["Right Hip"]
		LeftHip = Torso["Left Hip"]

		IT = Instance.new
		CF = CFrame.new
		VT = Vector3.new
		RAD = math.rad
		C3 = Color3.new
		UD2 = UDim2.new
		BRICKC = BrickColor.new
		ANGLES = CFrame.Angles
		EULER = CFrame.fromEulerAnglesXYZ
		COS = math.cos
		ACOS = math.acos
		SIN = math.sin
		ASIN = math.asin
		ABS = math.abs
		MRANDOM = math.random
		FLOOR = math.floor

		Animation_Speed = 3
		Frame_Speed = 1 / 60 -- (1 / 30) OR (1 / 60)
		local Speed = 16
		local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
		local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
		local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
		local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
		local DAMAGEMULTIPLIER = 1
		local ANIM = "Idle"
		local ATTACK = false
		local EQUIPPED = false
		local HOLD = false
		local COMBO = 1
		local Rooted = false
		local SINE = 0
		local KEYHOLD = false
		local CHANGE = 2 / Animation_Speed
		local WALKINGANIM = false
		local VALUE1 = false
		local VALUE2 = false
		local ROBLOXIDLEANIMATION = IT("Animation")
		ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
		ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
		local WEAPONGUI = IT("ScreenGui", PlayerGui)
		WEAPONGUI.Name = "Weapon GUI"
		local ANIMATOR = Humanoid.Animator
		local ANIMATE = Character.Animate
		local UNANCHOR = true
		local SC = false

		ArtificialHB = Instance.new("BindableEvent", script)
		ArtificialHB.Name = "ArtificialHB"

		script:WaitForChild("ArtificialHB")

		frame = Frame_Speed
		tf = 0
		allowframeloss = false
		tossremainder = false
		lastframe = tick()
		script.ArtificialHB:Fire()

		game:GetService("RunService").Heartbeat:connect(function(s, p)
			tf = tf + s
			if tf >= frame then
				if allowframeloss then
					ArtificialHB:Fire()
					lastframe = tick()
				else
					for i = 1, math.floor(tf / frame) do
						ArtificialHB:Fire()
					end
					lastframe = tick()
				end
				if tossremainder then
					tf = 0
				else
					tf = tf - frame * math.floor(tf / frame)
				end
			end
		end)

		function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
			return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
		end

		function PositiveAngle(NUMBER)
			if NUMBER >= 0 then
				NUMBER = 0
			end
			return NUMBER
		end

		function NegativeAngle(NUMBER)
			if NUMBER <= 0 then
				NUMBER = 0
			end
			return NUMBER
		end

		function Swait(NUMBER)
			if NUMBER == 0 or NUMBER == nil then
				ArtificialHB.Event:wait()
			else
				for i = 1, NUMBER do
					ArtificialHB.Event:wait()
				end
			end
		end

		function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
			local NEWMESH = IT(MESH)
			if MESH == "SpecialMesh" then
				NEWMESH.MeshType = MESHTYPE
				if MESHID ~= "nil" and MESHID ~= "" then
					NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
				end
				if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
					NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
				end
			end
			NEWMESH.Offset = OFFSET or VT(0, 0, 0)
			NEWMESH.Scale = SCALE
			NEWMESH.Parent = PARENT
			return NEWMESH
		end

		function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
			local NEWPART = IT("Part")
			NEWPART.formFactor = FORMFACTOR
			NEWPART.Reflectance = REFLECTANCE
			NEWPART.Transparency = TRANSPARENCY
			NEWPART.CanCollide = false
			NEWPART.Locked = true
			NEWPART.Anchored = true
			if ANCHOR == false then
				NEWPART.Anchored = false
			end
			NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
			NEWPART.Name = NAME
			NEWPART.Size = SIZE
			NEWPART.Position = Torso.Position
			NEWPART.Material = MATERIAL
			NEWPART:BreakJoints()
			NEWPART.Parent = PARENT
			return NEWPART
		end

		local function weldBetween(a, b)
			local weldd = Instance.new("ManualWeld")
			weldd.Part0 = a
			weldd.Part1 = b
			weldd.C0 = CFrame.new()
			weldd.C1 = b.CFrame:inverse() * a.CFrame
			weldd.Parent = a
			return weldd
		end


		function QuaternionFromCFrame(cf)
			local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
			local trace = m00 + m11 + m22
			if trace > 0 then 
				local s = math.sqrt(1 + trace)
				local recip = 0.5 / s
				return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
			else
				local i = 0
				if m11 > m00 then
					i = 1
				end
				if m22 > (i == 0 and m00 or m11) then
					i = 2
				end
				if i == 0 then
					local s = math.sqrt(m00 - m11 - m22 + 1)
					local recip = 0.5 / s
					return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
				elseif i == 1 then
					local s = math.sqrt(m11 - m22 - m00 + 1)
					local recip = 0.5 / s
					return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
				elseif i == 2 then
					local s = math.sqrt(m22 - m00 - m11 + 1)
					local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
				end
			end
		end

		function QuaternionToCFrame(px, py, pz, x, y, z, w)
			local xs, ys, zs = x + x, y + y, z + z
			local wx, wy, wz = w * xs, w * ys, w * zs
			local xx = x * xs
			local xy = x * ys
			local xz = x * zs
			local yy = y * ys
			local yz = y * zs
			local zz = z * zs
			return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
		end

		function QuaternionSlerp(a, b, t)
			local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
			local startInterp, finishInterp;
			if cosTheta >= 0.0001 then
				if (1 - cosTheta) > 0.0001 then
					local theta = ACOS(cosTheta)
					local invSinTheta = 1 / SIN(theta)
					startInterp = SIN((1 - t) * theta) * invSinTheta
					finishInterp = SIN(t * theta) * invSinTheta
				else
					startInterp = 1 - t
					finishInterp = t
				end
			else
				if (1 + cosTheta) > 0.0001 then
					local theta = ACOS(-cosTheta)
					local invSinTheta = 1 / SIN(theta)
					startInterp = SIN((t - 1) * theta) * invSinTheta
					finishInterp = SIN(t * theta) * invSinTheta
				else
					startInterp = t - 1
					finishInterp = t
				end
			end
			return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
		end

		function Clerp(a, b, t)
			local qa = {QuaternionFromCFrame(a)}
			local qb = {QuaternionFromCFrame(b)}
			local ax, ay, az = a.x, a.y, a.z
			local bx, by, bz = b.x, b.y, b.z
			local _t = 1 - t
			return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
		end

		function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
			local frame = IT("Frame")
			frame.BackgroundTransparency = TRANSPARENCY
			frame.BorderSizePixel = BORDERSIZEPIXEL
			frame.Position = POSITION
			frame.Size = SIZE
			frame.BackgroundColor3 = COLOR
			frame.BorderColor3 = BORDERCOLOR
			frame.Name = NAME
			frame.Parent = PARENT
			return frame
		end

		function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
			local label = IT("TextLabel")
			label.BackgroundTransparency = 1
			label.Size = UD2(1, 0, 1, 0)
			label.Position = UD2(0, 0, 0, 0)
			label.TextColor3 = TEXTCOLOR
			label.TextStrokeTransparency = STROKETRANSPARENCY
			label.TextTransparency = TRANSPARENCY
			label.FontSize = TEXTFONTSIZE
			label.Font = TEXTFONT
			label.BorderSizePixel = BORDERSIZEPIXEL
			label.TextScaled = false
			label.Text = TEXT
			label.Name = NAME
			label.Parent = PARENT
			return label
		end

		function NoOutlines(PART)
			PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
		end

		function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
			local NEWWELD = IT(TYPE)
			NEWWELD.Part0 = PART0
			NEWWELD.Part1 = PART1
			NEWWELD.C0 = C0
			NEWWELD.C1 = C1
			NEWWELD.Parent = PARENT
			return NEWWELD
		end

		local S = IT("Sound")
		function CreateSound(ID, PARENT, VOLUME, PITCH, DOESLOOP)
			local NEWSOUND = nil
			coroutine.resume(coroutine.create(function()
				NEWSOUND = S:Clone()
				NEWSOUND.Parent = PARENT
				NEWSOUND.Volume = VOLUME
				NEWSOUND.Pitch = PITCH
				NEWSOUND.SoundId = "rbxassetid://"..ID
				NEWSOUND:play()
				if DOESLOOP == true then
					NEWSOUND.Looped = true
				else
					repeat wait(1) until NEWSOUND.Playing == false
					NEWSOUND:remove()
				end
			end))
			return NEWSOUND
		end

		function CFrameFromTopBack(at, top, back)
			local right = top:Cross(back)
			return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
		end

		function WACKYEFFECT(Table)
			local TYPE = (Table.EffectType or "Sphere")
			local SIZE = (Table.Size or VT(1,1,1))
			local ENDSIZE = (Table.Size2 or VT(0,0,0))
			local TRANSPARENCY = (Table.Transparency or 0)
			local ENDTRANSPARENCY = (Table.Transparency2 or 1)
			local CFRAME = (Table.CFrame or Torso.CFrame)
			local MOVEDIRECTION = (Table.MoveToPos or nil)
			local ROTATION1 = (Table.RotationX or 0)
			local ROTATION2 = (Table.RotationY or 0)
			local ROTATION3 = (Table.RotationZ or 0)
			local MATERIAL = (Table.Material or "Neon")
			local COLOR = (Table.Color or C3(1,1,1))
			local TIME = (Table.Time or 45)
			local SOUNDID = (Table.SoundID or nil)
			local SOUNDPITCH = (Table.SoundPitch or nil)
			local SOUNDVOLUME = (Table.SoundVolume or nil)
			local USEBOOMERANGMATH = (Table.UseBoomerangMath or false)
			local BOOMERANG = (Table.Boomerang or 0)
			local SIZEBOOMERANG = (Table.SizeBoomerang or 0)
			coroutine.resume(coroutine.create(function()
				local PLAYSSOUND = false
				local SOUND = nil
				if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
					PLAYSSOUND = true
					SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
				end
				EFFECT.Color = COLOR
				local MSH = nil
				if TYPE == "Sphere" then
					MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0,0,0))
				elseif TYPE == "Block" or TYPE == "Box" then
					MSH = IT("BlockMesh",EFFECT)
					MSH.Scale = SIZE
				elseif TYPE == "Wave" then
					MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0,0,-SIZE.X/8))
				elseif TYPE == "Ring" then
					MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X,SIZE.X,0.1), VT(0,0,0))
				elseif TYPE == "Slash" then
					MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
				elseif TYPE == "Round Slash" then
					MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
				elseif TYPE == "Swirl" then
					MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, VT(0,0,0))
				elseif TYPE == "Skull" then
					MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0,0,0))
				elseif TYPE == "Crystal" then
					MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0,0,0))
				end
				if MSH ~= nil then
					local BOOMR1 = 1+BOOMERANG/50
					local BOOMR2 = 1+SIZEBOOMERANG/50
					local MOVESPEED = nil
					if MOVEDIRECTION ~= nil then
						if USEBOOMERANGMATH == true then
							MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)*BOOMR1
						else
							MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)
						end
					end
					local GROWTH = nil
					if USEBOOMERANGMATH == true then
						GROWTH = (SIZE - ENDSIZE)*(BOOMR2+1)
					else
						GROWTH = (SIZE - ENDSIZE)
					end
					local TRANS = TRANSPARENCY - ENDTRANSPARENCY
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
					else
						EFFECT.CFrame = CFRAME
					end
					if USEBOOMERANGMATH == true then
						for LOOP = 1, TIME+1 do
							Swait()
							MSH.Scale = MSH.Scale - (VT((GROWTH.X)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Y)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Z)*((1 - (LOOP/TIME)*BOOMR2)))*BOOMR2)/TIME
							if TYPE == "Wave" then
								MSH.Offset = VT(0,0,-MSH.Scale.Z/8)
							end
							EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
							if TYPE == "Block" then
								EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
							else
								EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
							end
							if MOVEDIRECTION ~= nil then
								local ORI = EFFECT.Orientation
								EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-(MOVESPEED)*((1 - (LOOP/TIME)*BOOMR1)))
								EFFECT.CFrame = CF(EFFECT.Position)*ANGLES(RAD(ORI.X),RAD(ORI.Y),RAD(ORI.Z))
							end
						end
					else
						for LOOP = 1, TIME+1 do
							Swait()
							MSH.Scale = MSH.Scale - GROWTH/TIME
							if TYPE == "Wave" then
								MSH.Offset = VT(0,0,-MSH.Scale.Z/8)
							end
							EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
							if TYPE == "Block" then
								EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
							else
								EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
							end
							if MOVEDIRECTION ~= nil then
								local ORI = EFFECT.Orientation
								EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
								EFFECT.CFrame = CF(EFFECT.Position)*ANGLES(RAD(ORI.X),RAD(ORI.Y),RAD(ORI.Z))
							end
						end
					end
					EFFECT.Transparency = 1
					if PLAYSSOUND == false then
						EFFECT:remove()
					else
						repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
						EFFECT:remove()
					end
				else
					if PLAYSSOUND == false then
						EFFECT:remove()
					else
						repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
						EFFECT:remove()
					end
				end
			end))
		end

		function MakeForm(PART,TYPE)
			if TYPE == "Cyl" then
				local MSH = IT("CylinderMesh",PART)
			elseif TYPE == "Ball" then
				local MSH = IT("SpecialMesh",PART)
				MSH.MeshType = "Sphere"
			elseif TYPE == "Wedge" then
				local MSH = IT("SpecialMesh",PART)
				MSH.MeshType = "Wedge"
			end
		end

		Debris = game:GetService("Debris")

		function CastProperRay(StartPos, EndPos, Distance, Ignore)
			local DIRECTION = CF(StartPos,EndPos).lookVector
			local Ignore = ((type(Ignore) == "table" and Ignore) or {Ignore})
			return game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(StartPos, DIRECTION * Distance), Ignore)
		end

		function Debree(Table)
			local KindOf = (Table.Variant or "Ring")
			local Position = (Table.Location or Torso.Position)
			local Coloration = (Table.Color or C3(1,1,1))
			local Texture = (Table.Material or "Slate")
			local Fling = (Table.Scatter or 1)
			local Number = (Table.Amount or 1)
			local Rocks = (Table.DebreeCount or 1)
			local Range = (Table.Distance or 1)
			local Scale = (Table.Size or 1)
			local Timer = (Table.Delay or 1.5)
			coroutine.resume(coroutine.create(function()
				local ScaleVector = VT(Scale,Scale,Scale)
				local Boulders = {}
				Position = CF(Position)
				if KindOf == "Ring" or KindOf == "Both" then
					for RockValue = 1, Number do
						local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale/4),math.ceil(Scale/4)),Range)
						local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
						BOULDER.CanCollide = true
						BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
						BOULDER.Color = Coloration
						table.insert(Boulders,BOULDER)
					end
				end
				if KindOf == "Loose" or KindOf == "Both" then
					for RockValue = 1, Rocks do
						local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale-(Scale/2)),math.ceil(Scale-(Scale/2))),0.7)
						local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, false)
						BOULDER.CanCollide = true
						BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
						BOULDER.Velocity = CF(BOULDER.Position-VT(0,4,0),BOULDER.CFrame*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))*CF(0,5,0).p).lookVector*MRANDOM(Fling-(Fling/1.5),Fling+(Fling/1.5))
						BOULDER.Color = Coloration
						table.insert(Boulders,BOULDER)
					end
				end
				if KindOf == "Random" then
					for RockValue = 1, Number do
						local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale/4),math.ceil(Scale/4)),MRANDOM(0,Range))
						local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
						BOULDER.CanCollide = true
						BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
						BOULDER.Color = Coloration
						table.insert(Boulders,BOULDER)
					end
				end
				wait(Timer)
				for E = 1, 45 do
					Swait()
					for A = 1, #Boulders do
						Boulders[A].Transparency = Boulders[A].Transparency + 1/45
					end
				end
				for A = 1, #Boulders do
					Boulders[A]:Destroy()
				end
			end))
		end

		local BASECOLOR = C3(0,0,0)
		local BMUSIC = IT("Sound",RootPart)
		local VOLUME = 1
		local PITCH = 1
		local SONGID = 1442022177
		local PLAYING = false
		local INTRO = false
		local SCREENS = {}
		local SCREENWELDS = {}
		local GUISTEXT = {}

		function ApplyDamage(Humanoid,Damage)
			if Damage > 0 then
				Damage = Damage * DAMAGEMULTIPLIER
				if Humanoid.Health < 2000 then
					if Humanoid.Health - Damage > 0 then
						Humanoid.Health = Humanoid.Health - Damage
					else
						breakJoints(Humanoid.Parent)
					end
				else
					breakJoints(Humanoid.Parent)
				end
			end
		end

		function ApplyAoE(POSITION,RANGE,MINDMG,MAXDMG,FLING,INSTAKILL)
			for index, CHILD in pairs(workspace:GetDescendants()) do
				if CHILD.ClassName == "Model" and CHILD ~= Character then
					local HUM = CHILD:FindFirstChildOfClass("Humanoid")
					if HUM then
						local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
						if TORSO then
							if (TORSO.Position - POSITION).Magnitude <= RANGE then
								if INSTAKILL == true then
									breakJoints(CHILD)
								else
									local DMG = MRANDOM(MINDMG,MAXDMG)
									ApplyDamage(HUM,DMG)
								end
								if FLING > 0 then
									for _, c in pairs(CHILD:GetChildren()) do
										if c:IsA("BasePart") then
											local bv = Instance.new("BodyVelocity") 
											bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
											bv.velocity = CF(POSITION,TORSO.Position).lookVector*FLING
											bv.Parent = c
											Debris:AddItem(bv,0.05)
										end
									end
								end
							end
						end
					end
				end
			end
		end


		function IntroThing()
			ATTACK = true
			Rooted = true
			RootJoint.C0 = CF(0,250,0)
			CONNECT = Mouse.KeyDown:connect(function(NEWKEY)
				local HITFLOOR,HITPOS = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
				if HITFLOOR then
					CONNECT:Disconnect()
					coroutine.resume(coroutine.create(function()
						PLAYING = true
					end))
					for i=0, 0.4, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.31, -0.65 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(60), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -1.4) * ANGLES(RAD(65), RAD(0), RAD(-15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(5), RAD(-35)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3 - 0.05 * COS(SINE / 12), -0.4) * ANGLES(RAD(20), RAD(90), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.1 - 0.05 * COS(SINE / 12), -0.4) * ANGLES(RAD(60), RAD(-90), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					for i = 1, 3 do
						WACKYEFFECT({EffectType = "Wave", Size = VT(0,5,0), Size2 = VT(i*12,5,i*12), Transparency = 0.6, Transparency2 = 1, CFrame = CF(HITPOS) * ANGLES(RAD(0), RAD(MRANDOM(0,360)), RAD(MRANDOM(-5,5))), MoveToPos = nil, RotationX = 0.1, RotationY = 1, RotationZ = -0.1, Material = "Neon", Color = C3(1,1,1), SoundID = 765590102, SoundPitch = MRANDOM(5,15)/10, SoundVolume = 5, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
					end
					Debree({Delay = 4,Variant = "Ring",Location = HITPOS,Color = HITFLOOR.Color,Size = 3,Distance = 15,Material = HITFLOOR.Material,Scatter = 1,Amount = 30,DebreeCount = 8})
					for i=0, 0.85, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.31, -0.65 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(60), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -1.4) * ANGLES(RAD(65), RAD(0), RAD(-15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(5), RAD(-35)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3 - 0.05 * COS(SINE / 12), -0.4) * ANGLES(RAD(20), RAD(90), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.1 - 0.05 * COS(SINE / 12), -0.4) * ANGLES(RAD(60), RAD(-90), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					for i=0, 1, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.31, -0.65 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(60), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-50 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.2 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -1.4) * ANGLES(RAD(65), RAD(0), RAD(-15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(5), RAD(-35)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3 - 0.05 * COS(SINE / 12), -0.4) * ANGLES(RAD(20), RAD(90), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.1 - 0.05 * COS(SINE / 12), -0.4) * ANGLES(RAD(60), RAD(-90), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					for i=0, 1, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(45), RAD(0), RAD(-45)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, 0.7) * ANGLES(RAD(-45), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(5), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					for i=0, 0.25, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(45), RAD(0), RAD(-35)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.45, -0.1) * ANGLES(RAD(30), RAD(-5), RAD(35)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(5), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					for i=0, 0.3, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.2, -0.8) * ANGLES(RAD(160), RAD(-5), RAD(-46)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.15, -0.3) * ANGLES(RAD(160), RAD(5), RAD(12)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					for i = 1, 3 do
						for i=0, 0.4, 0.1 / Animation_Speed do
							Swait()
							RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
							Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
							RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.2, -0.3) * ANGLES(RAD(160), RAD(-5), RAD(-12)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
							LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.1, -0.3) * ANGLES(RAD(160), RAD(5), RAD(12)) * LEFTSHOULDERC0, 1 / Animation_Speed)
							RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
							LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						end
						for i=0, 0.4, 0.1 / Animation_Speed do
							Swait()
							RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
							Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
							RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.1, -0.3) * ANGLES(RAD(160), RAD(-5), RAD(-12)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
							LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.2, -0.3) * ANGLES(RAD(160), RAD(5), RAD(12)) * LEFTSHOULDERC0, 1 / Animation_Speed)
							RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
							LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						end
					end
					for i = 1, 4 do
						Swait()
						local SCREENWELD = CreateWeldOrSnapOrMotor("Weld", RootPart, RootPart, SCREEN, CF(0,0,0) * ANGLES(RAD(0),RAD((360/6)*i),RAD(0)) * CF(0,0,3+(i/1.5)), CF(0,0,0))
						table.insert(SCREENS,SCREEN)
						table.insert(SCREENWELDS,SCREENWELD)
						local GUI = IT("SurfaceGui",SCREEN)
						for i = 1, 5 do
							local SCREENFRAME = CreateFrame(GUI, 1, 2, UD2(0, 0, ((1/5)*i)-1/5, 0), UD2(1, 0, 1/5, 0), C3(0,0,0), C3(0,0,0), "TESTING.exe")
							local TEXT = CreateLabel(SCREENFRAME, "[BOOTING UP...]", C3(1,1,1), Enum.FontSize.Size48, "Code", 0.5, 1, 1, "RunningTests")
							TEXT.TextXAlignment = "Left"
							TEXT.TextWrapped = true
							table.insert(GUISTEXT,TEXT)
						end
					end
					for i=0, 1, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.15, -0.25) * ANGLES(RAD(160), RAD(-5), RAD(12)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35, 0.15, -0.25) * ANGLES(RAD(160), RAD(5), RAD(-12)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					for i=0, 0.1, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(-5), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(5), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					ATTACK = false
					Rooted = false
				end
			end)
		end
		function Screening(Text,FinishesMoveEnd,WaitTillFinished)
			local SCREENWELD = CreateWeldOrSnapOrMotor("Weld", RootPart, RootPart, SCREEN, CF(0,0,0) * ANGLES(RAD(-12),RAD(180),RAD(0)) * CF(0,0,1.5), CF(0,0,0))
			local GUI = IT("SurfaceGui",SCREEN)
			local SCREENFRAME = CreateFrame(GUI, 1, 2, UD2(0, 0, 0, 0), UD2(1, 0, 1, 0), C3(0,0,0), C3(0,0,0), "TESTING.exe")
			local TEXT = CreateLabel(SCREENFRAME, Text, C3(1,1,1), Enum.FontSize.Size48, "Code", 0.5, 1, 1, "RunningTests")
			TEXT.TextScaled = true
			coroutine.resume(coroutine.create(function()
				coroutine.resume(coroutine.create(function()
					for i = 1, 5 do
						Swait()
						SCREEN.Transparency = SCREEN.Transparency - 0.1/5
					end
				end))
				if WaitTillFinished == false then
					for i=0, 1.7, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 - 0.04 * COS(SINE / 24), 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0 - 2.5 * COS(SINE / 24)), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15 - 7 * COS(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.3, 0.45 + 0.1 * COS(SINE / 12), -0.2) * ANGLES(RAD(45), RAD(0), RAD(-15)) * ANGLES(RAD(0), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-44 - 1.5 * COS(SINE / 12)), RAD(0), RAD(45)) * ANGLES(RAD(0), RAD(-25), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-2 - 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2 + 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
				elseif WaitTillFinished == true then
					repeat
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 - 0.04 * COS(SINE / 24), 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0 - 2.5 * COS(SINE / 24)), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15 - 7 * COS(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.3, 0.45 + 0.1 * COS(SINE / 12), -0.2) * ANGLES(RAD(45), RAD(0), RAD(-15)) * ANGLES(RAD(0), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-44 - 1.5 * COS(SINE / 12)), RAD(0), RAD(45)) * ANGLES(RAD(0), RAD(-25), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-2 - 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2 + 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
					until ATTACK == false
				end
				coroutine.resume(coroutine.create(function()
					SCREENWELD:Remove()
					SCREEN.Anchored = true
					for i = 1, 5 do
						Swait()
						SCREEN.Transparency = SCREEN.Transparency + 0.1/5
					end
					SCREEN:Remove()
				end))
				if FinishesMoveEnd == true then
					ATTACK = false
					Rooted = false
				end
			end))
			return SCREEN,TEXT
		end

		local TpTo = function()
			ATTACK = true
			Rooted = true
			local SCR, TEXT = Screening("",false,true)
			for i = 1, 35 do
				Swait()
				local TPSPOT = "TPTO: ["..math.ceil(Mouse.Hit.p.X).."."..math.ceil(Mouse.Hit.p.Y+3.15).."."..math.ceil(Mouse.Hit.p.Z).."]"
				TEXT.Text = TPSPOT
			end
			RightShoulder.C0 = RightShoulder.C0 * CF(0,-0.12,0)
			CreateSound(138204323, RightArm, 2, 1.3, false)
			CreateSound(1127492102, Torso, 2, 1, false)
			RootPart.CFrame = CF(Mouse.Hit.p+VT(0,3.15,0)) * ANGLES(RAD(0), RAD(RootPart.Orientation.Y), RAD(0))
			wait(0.1)
			ATTACK = false
			Rooted = false
		end

		local Kill = function()
			local TARGET = Mouse.Target
			if TARGET ~= nil then
				if TARGET.Parent:FindFirstChildOfClass("Humanoid") then
					local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")
					local ROOT = HUM.Parent:FindFirstChild("HumanoidRootPart") or HUM.Parent:FindFirstChild("Torso")
					if ROOT and HUM.Health > 0 then
						local FOE = ROOT.Parent
						ATTACK = true
						Rooted = false
						Screening(";Kill",true,false)
						wait(0.25)
						RightShoulder.C0 = RightShoulder.C0 * CF(0,-0.12,0)
						CreateSound(138204323, RightArm, 2, 1.3, false)
						for index, CHILD in pairs(FOE:GetChildren()) do
							if CHILD:IsA("BasePart") then
								if CHILD.Name == "Head" then
									WACKYEFFECT({Time = MRANDOM(10,30), EffectType = "Box", Size = VT(CHILD.Size.Z,CHILD.Size.Y,CHILD.Size.Z), Size2 = VT(CHILD.Size.Z,CHILD.Size.Y,CHILD.Size.Z)*2, Transparency = CHILD.Transparency, Transparency2 = 1, CFrame = CHILD.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, SizeBoomerang = 0, Boomerang = 50})
								elseif CHILD.Name ~= "HumanoidRootPart" then
									WACKYEFFECT({Time = MRANDOM(10,30), EffectType = "Box", Size = CHILD.Size, Size2 = CHILD.Size*2, Transparency = CHILD.Transparency, Transparency2 = 1, CFrame = CHILD.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, SizeBoomerang = 0, Boomerang = 35})
								end
							end
						end
						breakJoints(FOE)
					end
				end
			end
		end
		local ATTAC = function()
			ATTACK = true
			Rooted = false
			for i=0, 1, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(-5), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(5), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			ATTACK = false
			Rooted = false
		end
		local LITTLEIDLE = false
		function UniqueIdleAnimation()
			coroutine.resume(coroutine.create(function()
				for i=0, 0.1, 0.1 / Animation_Speed do
					Swait()
					if ATTACK == true or ANIM ~= "Idle" then
						break
					end
					RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 - 0.04 * COS(SINE / 24), 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0 - 2.5 * COS(SINE / 24)), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-45 - 1.5 * COS(SINE / 12)), RAD(0), RAD(-45)) * ANGLES(RAD(0), RAD(25), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.1, -0.3) * ANGLES(RAD(80), RAD(5), RAD(12)) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-2 - 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2 + 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
				for i=0, 0.4, 0.1 / Animation_Speed do
					Swait()
					if ATTACK == true or ANIM ~= "Idle" then
						break
					end
					RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 - 0.04 * COS(SINE / 24), 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0 - 2.5 * COS(SINE / 24)), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-45 - 1.5 * COS(SINE / 12)), RAD(0), RAD(-45)) * ANGLES(RAD(0), RAD(25), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.1, -0.3) * ANGLES(RAD(160), RAD(5), RAD(12)) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-2 - 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2 + 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
				for i=0, 1.3, 0.1 / Animation_Speed do
					Swait()
					if ATTACK == true or ANIM ~= "Idle" then
						break
					end
					RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 - 0.04 * COS(SINE / 24), 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0 - 2.5 * COS(SINE / 24)), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-45 - 1.5 * COS(SINE / 12)), RAD(0), RAD(-45)) * ANGLES(RAD(0), RAD(25), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.15, -0.3) * ANGLES(RAD(160), RAD(5), RAD(12)) * LEFTSHOULDERC0, 0.2 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-2 - 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2 + 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
				for i=0, 0.3, 0.1 / Animation_Speed do
					Swait()
					if ATTACK == true or ANIM ~= "Idle" then
						break
					end
					RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 - 0.04 * COS(SINE / 24), 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0 - 2.5 * COS(SINE / 24)), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-45 - 1.5 * COS(SINE / 12)), RAD(0), RAD(-45)) * ANGLES(RAD(0), RAD(25), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.05, -0.3) * ANGLES(RAD(160), RAD(5), RAD(12)) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-2 - 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2 + 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
				for i=0, 0.1, 0.1 / Animation_Speed do
					Swait()
					if ATTACK == true or ANIM ~= "Idle" then
						break
					end
					RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 - 0.04 * COS(SINE / 24), 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0 - 2.5 * COS(SINE / 24)), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-45 - 1.5 * COS(SINE / 12)), RAD(0), RAD(-45)) * ANGLES(RAD(0), RAD(25), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.1, -0.3) * ANGLES(RAD(80), RAD(5), RAD(12)) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-2 - 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2 + 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
				LITTLEIDLE = false
			end))
		end

		local COLOR = C3(1,1,1)
		local SKILLFONT = "Legacy"
		local SIZE = 2.5
		local MOUSE = 2097542191
		local MELEE = 2097543015
		local BODY = 2097543382
		local PROJECTILE = 2097544084
		local AOE = 2097544884
		local ULTIMATE = 2097545381

		local ATTACKS = {{";TpTo","x",BODY,TpTo},{";Kill","v",MOUSE,Kill}}
		local GUIS = {}

		for i = 1, #ATTACKS do
			local SKILLFRAME = CreateFrame(WEAPONGUI, 0.8, 2, UD2(1-(0.3*(SIZE/5)), 0, 1-((0.08*(SIZE/5))*i), 0), UD2(0.3*(SIZE/5), 0, 0.06*(SIZE/4), 0), C3(0,0,0), COLOR, "Skill Frame")
			local SKILLTEXT = CreateLabel(SKILLFRAME, "["..ATTACKS[i][1].."]", COLOR, SIZE, SKILLFONT, 0, 2, 0, "Skill text")
			SKILLTEXT.TextXAlignment = "Right"
			local BUTTONDISPLAY = CreateLabel(SKILLFRAME, "["..string.upper(ATTACKS[i][2]).."]", COLOR, SIZE-1, SKILLFONT, 0, 2, 0, "Skill text")
			BUTTONDISPLAY.TextXAlignment = "Left"
			if ATTACKS[i][3] then
				local IMAGETODISPLAY = IT("ImageLabel",SKILLFRAME)
				IMAGETODISPLAY.Image = "rbxassetid://"..ATTACKS[i][3]
				IMAGETODISPLAY.Size = UD2(0.2,0,1,0)
				IMAGETODISPLAY.Position = UD2(0.065,0,0,0)
				IMAGETODISPLAY.BackgroundTransparency = 1
				IMAGETODISPLAY.ZIndex = 0
			end
			table.insert(GUIS,SKILLTEXT)
		end

		Mouse.Button1Down:connect(function(NEWKEY)

		end)
		Mouse.Button1Up:connect(function(NEWKEY)

		end)
		Mouse.KeyDown:connect(function(NEWKEY)
			KEYHOLD = true
			if NEWKEY == "m" then
				if SC == false then
					SC = true
				else
					SC = false
				end
			end
			if ATTACK == false then
				for E = 1, #ATTACKS do
					if ATTACKS[E][4] ~= nil then
						if NEWKEY == ATTACKS[E][2] then
							ATTACKS[E][4]()
						end
					end
				end
			end
		end)
		Mouse.KeyUp:connect(function(NEWKEY)
			KEYHOLD = false
		end)

		function unanchor()
			for _, c in pairs(Character:GetChildren()) do
				if c:IsA("BasePart") and c ~= RootPart then
					c.Anchored = false
				end
			end
			if UNANCHOR == true then
				RootPart.Anchored = false
			else
				RootPart.Anchored = true
			end
		end

		Humanoid.Changed:connect(function(Jump)
			if Jump == "Jump" and (Disable_Jump == true) then
				Humanoid.Jump = false
			end
		end)

		local MOVINGSCREENS = false
		local TIMESTAMP = 0
		while true do
			Swait()
			script.Parent = WEAPONGUI
			ANIMATE.Parent = nil
			ANIMATOR.Parent = nil
			for _,v in next, Humanoid:GetPlayingAnimationTracks() do
				v:Stop();
			end
			SINE = SINE + CHANGE
			local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
			local TORSOVERTICALVELOCITY = RootPart.Velocity.y
			local HITFLOOR = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
			local WALKSPEEDVALUE = 8 / (Humanoid.WalkSpeed / 16)
			if ANIM == "Walk" and TORSOVELOCITY > 1 then
				RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0.1 * COS(SINE / (WALKSPEEDVALUE/2))) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
				Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0) - Head.RotVelocity.Y / 30), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
				RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 0.875 - 0.125 * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE*2), 0.25 * SIN(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10+50 * COS(SINE / WALKSPEEDVALUE))), 0.6 / Animation_Speed)
				LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 0.875 + 0.125 * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE*2), -0.25 * SIN(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-10+50 * COS(SINE / WALKSPEEDVALUE))), 0.6 / Animation_Speed)
			elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) then
				RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
				Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
				RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.7 / Animation_Speed)
				LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.7 / Animation_Speed)
			end
			if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
				ANIM = "Jump"
				if ATTACK == false then
					RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(25 + 10 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(-25 - 10 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.4, -0.6) * ANGLES(RAD(1), RAD(90), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
			elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
				ANIM = "Fall"
				if ATTACK == false then
					RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(SINE / 6)), RAD(0), RAD(45 + 10 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(SINE / 6)), RAD(0), RAD(-45 - 10 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3, -0.7) * ANGLES(RAD(-25 + 5 * SIN(SINE / 12)), RAD(90), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.8, -0.3) * ANGLES(RAD(-10), RAD(-80), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
			elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
				ANIM = "Idle"
				if ATTACK == false then
					if MRANDOM(1,650) == 1 and LITTLEIDLE == false then
						LITTLEIDLE = true
						UniqueIdleAnimation()
					end
					if LITTLEIDLE == false then
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 - 0.04 * COS(SINE / 24), 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0 - 2.5 * COS(SINE / 24)), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(3 - 7 * COS(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-45 - 1.5 * COS(SINE / 12)), RAD(0), RAD(-45)) * ANGLES(RAD(0), RAD(25), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.35 + 0.1 * COS(SINE / 12), 0.2) * ANGLES(RAD(-44 - 1.5 * COS(SINE / 12)), RAD(0), RAD(45)) * ANGLES(RAD(0), RAD(-25), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-2 - 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.035 * COS(SINE / 24) - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2 + 2.5 * COS(SINE / 24)), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
				end
			elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
				ANIM = "Walk"
				if ATTACK == false then
					RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.05) * ANGLES(RAD(5), RAD(0), RAD(-7 * COS(SINE / (WALKSPEEDVALUE)))), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5 - 1 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(7 * COS(SINE / (WALKSPEEDVALUE)))), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(60 * COS(SINE / WALKSPEEDVALUE)), RAD(-5), RAD(5)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-60 * COS(SINE / WALKSPEEDVALUE)), RAD(5), RAD(-5)) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
				end
			end
			for _, c in pairs(Character:GetChildren()) do
				if c:IsA("Accessory") then
					if c.Name == "Nerd Glasses" then
						c:Destroy()
					end
				end
			end
			unanchor()
			Humanoid.MaxHealth = 1e3
			Humanoid.Health = 1e3
			if Rooted == false then
				Disable_Jump = false
				Humanoid.WalkSpeed = Speed
			elseif Rooted == true then
				Disable_Jump = true
				Humanoid.WalkSpeed = 0
			end
			BMUSIC.SoundId = "rbxassetid://"..SONGID
			BMUSIC.Looped = true
			BMUSIC.Pitch = PITCH
			BMUSIC.Volume = VOLUME
			BMUSIC.Playing = PLAYING
			BMUSIC.EmitterSize = 50
			if BMUSIC.Parent ~= RootPart then
				print("Fixing music")
				BMUSIC = IT("Sound",RootPart)
				BMUSIC.SoundId = "rbxassetid://"..SONGID
				BMUSIC.Looped = true
				BMUSIC.Pitch = PITCH
				BMUSIC.Volume = VOLUME
				BMUSIC.Playing = true
				BMUSIC.EmitterSize = 50
				BMUSIC.TimePosition = TIMESTAMP
				FIXING = true
			else
				if FIXING == false then
					TIMESTAMP = BMUSIC.TimePosition
				else
					FIXING = false
				end
			end
			if Head:FindFirstChild("face") then
				Head.face.Texture = "rbxassetid://62682458"
			end
			Humanoid.Name = "ADMIN"
			if INTRO == false and ATTACK == false then
				INTRO = true
				coroutine.resume(coroutine.create(function()
					IntroThing()
				end))
			end
			if #SCREENS > 0 then
				for E = 1, #SCREENS do
					SCREENS[E].Transparency = MRANDOM(90,99)/100
				end
			end
			if #SCREENWELDS > 0 then
				if SC == true then
					if MRANDOM(1,75) == 1 and MOVINGSCREENS == false then
						MOVINGSCREENS = true
						coroutine.resume(coroutine.create(function()
							wait(1)
							MOVINGSCREENS = false
						end))
						for E = 1, #SCREENWELDS do
							coroutine.resume(coroutine.create(function()
								local MATH1 = MRANDOM(-25,25)/10+1
								local MATH2 = MRANDOM(-45,45)
								for i = 1, 55 do
									Swait()
									SCREENWELDS[E].C0 = Clerp(SCREENWELDS[E].C0, CF(0,MATH1,0) * ANGLES(RAD(0), RAD(MATH2+180), RAD(0)) * CF(0,0,3+(E/1.5)),0.1)
								end
							end))
						end
					end
				elseif SC == false then
					for E = 1, #SCREENWELDS do
						if E == 1 then
							SCREENWELDS[E].C0 = Clerp(SCREENWELDS[E].C0, CF(0,-1 + 0.05 * COS(SINE / 12),0) * ANGLES(RAD(0), RAD(-40+180), RAD(0)) * CF(0,0,3.4),0.1)
						elseif E == 2 then
							SCREENWELDS[E].C0 = Clerp(SCREENWELDS[E].C0, CF(0,-1 + 0.05 * SIN(SINE / 12),0) * ANGLES(RAD(0), RAD(40+180), RAD(0)) * CF(0,0,3.4),0.1)
						elseif E == 3 then
							SCREENWELDS[E].C0 = Clerp(SCREENWELDS[E].C0, CF(0,1.3 + 0.05 * SIN(SINE / 12),0) * ANGLES(RAD(0), RAD(-38+180), RAD(0)) * CF(0,0,3.4),0.1)
						elseif E == 4 then
							SCREENWELDS[E].C0 = Clerp(SCREENWELDS[E].C0, CF(0,1.3 + 0.05 * COS(SINE / 12),0) * ANGLES(RAD(0), RAD(38+180), RAD(0)) * CF(0,0,3.4),0.1)
						end
					end
				end
			end
			local SECONDS = math.floor(workspace.DistributedGameTime)
			local MINUTES = math.floor(workspace.DistributedGameTime/60)
			local HOURS = math.floor(workspace.DistributedGameTime/60/60)
			local SECONDS = SECONDS - (MINUTES * 60)
			local MINUTES = MINUTES - (HOURS * 60)
			if #GUISTEXT > 0 then
				for E = 1, #GUISTEXT do
					local TXT = GUISTEXT[E]
					if E == 1 then
						TXT.Text = "SERVER STATS;"
					elseif E == 2 then
						TXT.Text = "SERVER TIME = ["..SECONDS..":"..MINUTES..":"..HOURS.."]"
					elseif E == 3 then
						TXT.Text = "WORKSPACE GRAVITY = ["..workspace.Gravity.."]"
					elseif E == 4 then
						TXT.Text = "SERVER JOBID = ["..game.JobId.."]"
					elseif E == 5 then
						TXT.Text = "SERVER VERSION = ["..game.PlaceVersion.."]"
					end
				end
			end
			local SPACEJECTS = {}
			for index, CHILD in pairs(workspace:GetChildren()) do
				table.insert(SPACEJECTS,CHILD)
			end
			table.insert(SPACEJECTS,game.Lighting)
			table.insert(SPACEJECTS,game.Workspace)
			local MALWARE = {"BlurEffect","BloomEffect","Fire","ParticleEmitter","Smoke"}
			if #GUISTEXT > 0 then
				if MRANDOM(1,125) == 1 then
					for E = 1, #GUISTEXT do
						local TXT = GUISTEXT[E]
						local TEXT = ""
						local DOINGS = {"MONITORING","CHECKING"}
						local OLDTEXT = string.sub(TXT.Text,3)
						if E > 5 then
							if E <= 15 then
								if MRANDOM(1,3) == 1 then
									repeat
										local MONITORME = SPACEJECTS[MRANDOM(1,#SPACEJECTS)]
										if MRANDOM(1,2) == 1 then
											TEXT = DOINGS[MRANDOM(1,#DOINGS)].."; ["..MONITORME.Name.."]..."
											for Z = 1, #MALWARE do
												if MONITORME:FindFirstChildOfClass(MALWARE[Z]) then
													TEXT = "!FOUND MALICIOUS CONTENT IN ["..MONITORME.Name.."]; FOUND: ["..MALWARE[Z].."]"
													if TEXT ~= OLDTEXT then
														CreateSound(136075117, TXT.Parent.Parent, 0.6, MRANDOM(8,12)/10)
													end
													TXT.TextColor3 = C3(1,0,0)
													break
												else
													TXT.TextColor3 = C3(1,1,1)
												end
											end
											break
										end
										if MRANDOM(1,6) == 1 and TXT.TextColor3 == C3(1,1,1) then
											local ES = {"SUCCES.","!FAILURE!"}
											TEXT = "TESTING FILE #"..MRANDOM(100,999).." ["..ES[MRANDOM(1,#ES)].."]"
										end
									until TEXT ~= ""
									local DESIREDTEXT = ">>"..TEXT
									TXT.Text = DESIREDTEXT
								end
							elseif E > 15 then
								local N = E-15
								local POP = 0
								repeat
									for index, CHILD in pairs(Players:GetChildren()) do
										POP = POP + 1
										if POP == N then
											TEXT = "MONITORING USER; ".."["..CHILD.Name.."]..."
											break
										else
											TEXT = "NOP"
										end
									end
								until TEXT ~= ""
								if TEXT ~= "NOP" then
									local DESIREDTEXT = ">>"..TEXT
									TXT.Text = DESIREDTEXT
								else
									TXT.Text = ""
								end
							end
						end
					end
				end
			end
		end
	elseif isCmd(cmd, {"goner"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		function notify(title,text,duration)
			game.StarterGui:SetCore("SendNotification", {
				Title = title or "", 
				Text = text or "",
				Duration = duration or 5
			})
		end
		local genv = (getgenv and (getgenv() ~= getfenv()) and getgenv()) or _G
		local char = Player.Character or Player.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
		local simRadius = gethiddenproperty and gethiddenproperty(Player,"SimulationRadius")
		local requiredRadius = 20
		local isR15 = hum.RigType == Enum.HumanoidRigType.R15
		local forcefield = char:FindFirstChildOfClass("ForceField")
		local fakeHum = hum:Clone()
		local hrp = char:WaitForChild("HumanoidRootPart")
		local hrpCF = hrp.CFrame
		local stopAlign = false
		local stopAntiVoid = false
		local limbs = {}
		local hatHandles = {}
		local reanimConnections = {}

		runCommand("clip")

		if simRadius and simRadius < requiredRadius then
			repeat
				notify("Please wait",`Waiting for bigger SimulationRadius ({tostring(math.floor(simRadius))}/{tostring(requiredRadius)})`, 2)
				task.wait(2)
			until gethiddenproperty(Player,"SimulationRadius") >= requiredRadius
			if Player.Character == nil or Player.Character ~= char or hum.Parent == nil or hum.Health <= 0 then return end
		end

		if forcefield then forcefield:Destroy() end
		char.Archivable = true

		local rig = (not isR15) and char:Clone()

		if isR15 then
			local canGetObjects, loadedRig = pcall(function() return game:GetObjects("rbxassetid://18418211383")[1] end)
			local r6Rig = isTesting and rStorage:WaitForChild("R6Rig") or canGetObjects and loadedRig or loadstring(httpget("https://gist.githubusercontent.com/someunknowndude/ad264038a91f7fa11bec2f67dad3feaf/raw"))()
			local humDesc = players:GetCharacterAppearanceAsync(Player.UserId)
			local r6Head = r6Rig.Head
			local r15Head = char.Head
			local surfaceAppearance = r15Head:FindFirstChildOfClass("SurfaceAppearance")
			local face = r15Head:FindFirstChild("face")

			if surfaceAppearance then 
				surfaceAppearance:Clone().Parent = r6Head
			else
				--if face then r6Head.face.Texture = face.Texture end
				--r6Head.face.Transparency = 0
			end

			for i,v in pairs(r15Head:GetChildren()) do
				if not v:IsA("Attachment") then continue end
				v:Clone().Parent = r6Head
			end

			for i,v in pairs(humDesc:GetDescendants()) do
				if v:IsA("BodyColors") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic") then
					v.Parent = r6Rig
					continue
				end
				if v:IsA("Accessory") or v:IsA("Hat") then
					r6Rig:WaitForChild("Humanoid"):AddAccessory(v)
				end
			end


			rig = r6Rig
		else
			local mesh = char.Head:FindFirstChildOfClass("SpecialMesh")
			local face = char.Head:FindFirstChild("face")
			if mesh and face then
				delete(face)
			end
		end	

		local rigHRP = rig:WaitForChild("HumanoidRootPart")
		local rigHum = rig:FindFirstChild("Humanoid")

		rig.Name = "wacky reanim rig"


		for i,v in pairs(char:GetChildren()) do
			if not v:IsA("BasePart") then continue end
			table.insert(limbs, {v,rig[v.Name]})
		end


		local accessories = hum:GetAccessories()
		local rigAccessories = rigHum:GetAccessories()

		for i,v in pairs(accessories) do
			if not isR15 then
				table.insert(hatHandles,{v.Handle,rigAccessories[i].Handle})
				continue
			end
			for _,rigAcc in pairs(rigAccessories) do
				local handle = rigAcc.Handle
				local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle
				local texture = handle == mesh and mesh.TextureID or mesh.TextureId
				if not (rigAcc.Name == v.Name and mesh.MeshId == v.Handle.MeshId and texture == v.Handle.TextureID) then continue end
				table.insert(hatHandles,{v.Handle,rigAcc.Handle})
				continue 
			end
		end

		local clock = os and os.clock or tick
		local cos = math.cos
		local sin = math.sin
		local cfNew = CFrame.new
		local cfZero = CFrame.identity
		local v3New = Vector3.new
		local v3Zero = Vector3.zero

		local changedMaxSimRad = pcall(sethiddenproperty, Player, "MaximumSimulationRadius", 1000)
		local changedSimRad = pcall(sethiddenproperty, Player, "SimulationRadius", 1000)
		local netlessCF = cfZero
		local sineValue = 0


		local function align(part0, part1, offset)
			if stopAlign then return end
			if part0 and part0.Parent and part1 and part1.Parent then
				local part0_mass = part1.Mass * 5
				part0.AssemblyLinearVelocity = v3New(part1.AssemblyLinearVelocity.X * part0_mass, sineValue, part1.AssemblyLinearVelocity.Z * part0_mass)
				part0.AssemblyAngularVelocity = part1.AssemblyAngularVelocity

				if isnetworkowner(part0) then
					part0.CFrame = part1.CFrame * offset
				end
			end
		end

		local function setCamera(model)
			local oldCamCF = workspace.CurrentCamera.CFrame
			workspace.CurrentCamera.CameraSubject = model.Humanoid
			workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Once(function()
				workspace.CurrentCamera.CFrame = oldCamCF
			end)
		end

		local function disableCollisions(model,canTouchAndCast)
			for _, part in next, model:GetDescendants() do
				if part and part:IsA("BasePart") then
					part.CanCollide = false
					part.CanQuery = canTouchAndCast
					part.CanTouch = canTouchAndCast
				end
			end
		end

		local function makeTransparent(model)
			for i,v in pairs(model:GetDescendants()) do
				if not (v:IsA("BasePart") or v:IsA("Decal")) then continue end
				v.Transparency = 1
			end
		end

		local function breakJoints(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("JointInstance") then continue end
				delete(v)
			end
		end

		local function removeScripts(model)
			for i,v in pairs(model:GetChildren()) do
				if not (v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") or v.Name == "Animate") then continue end
				delete(v)
			end
		end

		local function removeTouchTriggers(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("TouchTransmitter") then continue end
				delete(v)
			end
		end

		local function onPostSim()
			for _, data in next, limbs do
				align(data[1], data[2],netlessCF)
			end

			for _, data in next, hatHandles do
				align(data[1], data[2], netlessCF)
			end
		end

		local function onPreSim()
			netlessCF = cfNew(0.01 * sin(clock()*16), 0, 0.01 * math.cos(clock()*16))
			sineValue = 40 - 3 * sin(clock()*10)

			if stopAntiVoid or rigHRP.Position.Y > (workspace.FallenPartsDestroyHeight + 50) then return end
			rigHRP.CFrame = hrpCF
			rigHRP.AssemblyLinearVelocity = v3Zero
			rigHRP.AssemblyAngularVelocity = v3Zero
		end


		rigHRP.CFrame = hrpCF
		rig.Parent = workspace
		Player.Character = rig
		setCamera(rig)
		rig.Animate.Enabled = false
		rig.Animate.Enabled = true
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		repeat task.wait() until limbs[3][1].CanCollide
		task.wait(0.05)
		delete(hum)
		repeat task.wait() until hum.Parent == nil
		task.wait()
		fakeHum.Parent = char
		task.wait()
		table.insert(reanimConnections, game:GetService("RunService").PreSimulation:Connect(onPreSim))
		table.insert(reanimConnections, game:GetService("RunService").PostSimulation:Connect(onPostSim))
		table.insert(reanimConnections, game:GetService("RunService").Stepped:Connect(function()
			disableCollisions(char,false)
			disableCollisions(rig,true)
		end))

		breakJoints(char)
		makeTransparent(char)
		removeScripts(char)
		removeTouchTriggers(char)

		genv.LoadLibrary = function(lib) return loadstring(httpget("https://raw.githubusercontent.com/Roblox/Core-Scripts/master/CoreScriptsRoot/Libraries/" .. lib .. ".lua"))() end

		local reset = Instance.new("BindableEvent")
		reset.Event:Connect(function()
			if stopAlign then
				local hum = character:FindFirstChildOfClass("Humanoid")
				if not hum then return character:BreakJoints() end
				hum.Health = 0
				return
			end
			notify("Resetting", "Please wait ~6 seconds", 6)
			stopAntiVoid = true
			rigHRP.Anchored = true
			rigHRP.CFrame = CFrame.new(0,workspace.FallenPartsDestroyHeight + 5,0)
			task.wait(0.5)
			stopAlign = true
			rigHum:ChangeState(Enum.HumanoidStateType.Dead)
			Player.CharacterAdded:Wait()
			rig:Destroy()
			for i,v in pairs(reanimConnections) do
				v:Disconnect()
			end
		end)

		game.StarterGui:SetCore("ResetButtonCallback", reset)

		notify("Success!", "reanim loaded!")
		delete = delete or _G.delete

		local function breakJoints(instance)
			for i,v in pairs(instance:GetDescendants()) do
				if not (v:IsA("Weld") or v:IsA("WeldConstraint") or v:IsA("JointInstance")) then continue end
				delete(v)
			end
		end

		local script = game:GetObjects("rbxassetid://10561777706")[1]
		local MODULE = script
		local PLAYER = Player
		local CHARACTER = PLAYER.Character
		local HUM = CHARACTER.Humanoid

		local ROOT = HUM.Torso
		local HEAD = CHARACTER.Head
		local TORSO = CHARACTER.Torso
		local RIGHTARM = CHARACTER["Right Arm"]
		local LEFTARM = CHARACTER["Left Arm"]
		local RIGHTLEG = CHARACTER["Right Leg"]
		local LEFTLEG = CHARACTER["Left Leg"]
		local ROOTJOINT = ROOT["RootJoint"]
		local NECK = TORSO["Neck"]
		local RIGHTSHOULDER = TORSO["Right Shoulder"]
		local LEFTSHOULDER = TORSO["Left Shoulder"]
		local RIGHTHIP = TORSO["Right Hip"]
		local LEFTHIP = TORSO["Left Hip"]
		local MOUSEPOS = ROOT.Position

		IT = Instance.new
		CF = CFrame.new
		VT = Vector3.new
		RAD = math.rad
		C3 = Color3.new
		UD2 = UDim2.new
		BRICKC = BrickColor.new
		ANGLES = CFrame.Angles
		EULER = CFrame.fromEulerAnglesXYZ
		COS = math.cos
		ACOS = math.acos
		SIN = math.sin
		ASIN = math.asin
		ABS = math.abs
		MRANDOM = math.random
		FLOOR = math.floor

		Mouse = PLAYER:GetMouse()
		MOUSE = Mouse
		--------------------------------------------------------------
		--//====================================================\\--
		--||                  BACKGROUND VALUES
		--\\====================================================//--

		local ANIM_SPEED = 3
		local MOUSE = Mouse
		local FRAME_SPEED = 1 / 60 -- (1 / 30) OR (1 / 60)
		local CHANGE = 2 / ANIM_SPEED
		local DAMAGEMULTIPLIER = 1
		local ANIM = "Idle"
		local KEYHOLD = false
		local MOUSEHOLD = false
		local SINE = 0
		local ATTACKING = false
		local Debris = game:GetService("Debris")
		local Effects = IT("Folder",CHARACTER)
		Effects.Name = "FXFolder"
		local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
		local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
		local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
		local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))

		--//====================================================\\--
		--||                     HEARTBEAT
		--\\====================================================//--

		ArtificialHB = Instance.new("BindableEvent", script)
		ArtificialHB.Name = "ArtificialHB"

		script:WaitForChild("ArtificialHB")

		frame = FRAME_SPEED
		tf = 0
		allowframeloss = false
		tossremainder = false
		lastframe = tick()
		script.ArtificialHB:Fire()

		game:GetService("RunService").Heartbeat:connect(function(s, p)
			tf = tf + s
			if tf >= frame then
				if allowframeloss then
					ArtificialHB:Fire()
					lastframe = tick()
				else
					for i = 1, math.floor(tf / frame) do
						ArtificialHB:Fire()
					end
					lastframe = tick()
				end
				if tossremainder then
					tf = 0
				else
					tf = tf - frame * math.floor(tf / frame)
				end
			end
		end)

		function PositiveAngle(NUMBER)
			if NUMBER >= 0 then
				NUMBER = 0
			end
			return NUMBER
		end

		function NegativeAngle(NUMBER)
			if NUMBER <= 0 then
				NUMBER = 0
			end
			return NUMBER
		end

		function Swait(NUMBER)
			if NUMBER == 0 or NUMBER == nil then
				ArtificialHB.Event:wait()
			else
				for i = 1, NUMBER do
					ArtificialHB.Event:wait()
				end
			end
		end

		--//====================================================\\--
		--||                       CLERP
		--\\====================================================//--

		function QuaternionFromCFrame(cf)
			local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
			local trace = m00 + m11 + m22
			if trace > 0 then 
				local s = math.sqrt(1 + trace)
				local recip = 0.5 / s
				return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
			else
				local i = 0
				if m11 > m00 then
					i = 1
				end
				if m22 > (i == 0 and m00 or m11) then
					i = 2
				end
				if i == 0 then
					local s = math.sqrt(m00 - m11 - m22 + 1)
					local recip = 0.5 / s
					return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
				elseif i == 1 then
					local s = math.sqrt(m11 - m22 - m00 + 1)
					local recip = 0.5 / s
					return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
				elseif i == 2 then
					local s = math.sqrt(m22 - m00 - m11 + 1)
					local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
				end
			end
		end

		function QuaternionToCFrame(px, py, pz, x, y, z, w)
			local xs, ys, zs = x + x, y + y, z + z
			local wx, wy, wz = w * xs, w * ys, w * zs
			local xx = x * xs
			local xy = x * ys
			local xz = x * zs
			local yy = y * ys
			local yz = y * zs
			local zz = z * zs
			return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
		end

		function QuaternionSlerp(a, b, t)
			local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
			local startInterp, finishInterp;
			if cosTheta >= 0.0001 then
				if (1 - cosTheta) > 0.0001 then
					local theta = ACOS(cosTheta)
					local invSinTheta = 1 / SIN(theta)
					startInterp = SIN((1 - t) * theta) * invSinTheta
					finishInterp = SIN(t * theta) * invSinTheta
				else
					startInterp = 1 - t
					finishInterp = t
				end
			else
				if (1 + cosTheta) > 0.0001 then
					local theta = ACOS(-cosTheta)
					local invSinTheta = 1 / SIN(theta)
					startInterp = SIN((t - 1) * theta) * invSinTheta
					finishInterp = SIN(t * theta) * invSinTheta
				else
					startInterp = t - 1
					finishInterp = t
				end
			end
			return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
		end

		function Clerp(a, b, t)
			local qa = {QuaternionFromCFrame(a)}
			local qb = {QuaternionFromCFrame(b)}
			local ax, ay, az = a.x, a.y, a.z
			local bx, by, bz = b.x, b.y, b.z
			local _t = 1 - t
			return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
		end

		--//====================================================\\--
		--||                     FUNCTIONS
		--\\====================================================//--

		function WeldParts(A,B)
			local WLD = IT("ManualWeld")
			WLD.Part0 = A
			WLD.Part1 = B
			WLD.C1 = B.CFrame:inverse() * A.CFrame
			WLD.Parent = A
			return WLD
		end

		--NewSound({ID = 0,PARENT = ROOT,VOLUME = 0.5,PITCH = 1,LOOP = false,MAXDISTANCE = 1000,EMITTERSIZE = 10,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
		function NewSound(TABLE)
			local ID = "rbxassetid://"..(TABLE.ID or 0)
			local PARENT = (TABLE.PARENT or ROOT)
			local VOLUME = (TABLE.VOLUME or 0.5)
			local PITCH = (TABLE.PITCH or 1)
			local LOOP = (TABLE.LOOP or false)
			local MAXDISTANCE = (TABLE.MAXDISTANCE or 100)
			local EMITTERSIZE = (TABLE.EMITTERSIZE or 10)
			local PLAYING = (TABLE.PLAYING or true)
			local PLAYONREMOVE = (TABLE.PLAYONREMOVE or false)
			local DOESDEBRIS = (TABLE.DOESDEBRIS or true)
			if ID ~= "rbxassetid://0" then
				local SOUND = IT("Sound",PARENT)
				SOUND.SoundId = ID
				SOUND.Volume = VOLUME
				SOUND.Pitch = PITCH
				SOUND.Looped = LOOP
				SOUND.MaxDistance = MAXDISTANCE
				SOUND.EmitterSize = EMITTERSIZE
				SOUND.PlayOnRemove = PLAYONREMOVE
				if DOESDEBRIS == true and PLAYING == true and LOOP == false then
					Debris:AddItem(SOUND,SOUND.TimeLength+5)
				end
				if PLAYING == true then
					SOUND:Play()
				end
				return SOUND
			end
		end

		function OofOuchBlood(LOCATION,TO,AMOUNT)
		end

		function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
			local NEWMESH = IT(MESH)
			if MESH == "SpecialMesh" then
				NEWMESH.MeshType = MESHTYPE
				if MESHID ~= "nil" and MESHID ~= "" then
					NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
				end
				if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
					NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
				end
			end
			NEWMESH.Offset = OFFSET or VT(0, 0, 0)
			NEWMESH.Scale = SCALE
			NEWMESH.Parent = PARENT
			return NEWMESH
		end

		function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
			local NEWPART = IT("Part")
			NEWPART.formFactor = FORMFACTOR
			NEWPART.Reflectance = REFLECTANCE
			NEWPART.Transparency = TRANSPARENCY
			NEWPART.CanCollide = false
			NEWPART.Locked = true
			NEWPART.Anchored = true
			if ANCHOR == false then
				NEWPART.Anchored = false
			end
			NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
			NEWPART.Name = NAME
			NEWPART.Size = SIZE
			NEWPART.Position = ROOT.Position
			NEWPART.Material = MATERIAL
			NEWPART:BreakJoints()
			NEWPART.Parent = PARENT
			return NEWPART
		end

		function Raycast(POSITION, DIRECTION, RANGE, TABLE)
			local TABLE = ((type(TABLE) == "table" and TABLE) or {TABLE})
			return game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(POSITION, DIRECTION * RANGE), TABLE)
		end

		function CameraShake(AREA,RANGE,SHAKE,TIMER)
		end

		--Debree({Delay = 1.5,Variant = "",Location = ROOT.Position,Color = C3(1,1,1),Size = 1,Distance = 1,Material = "Slate",Scatter = 1,Amount = 1,DebreeCount = 1})
		function Debree(Table)
			local KindOf = (Table.Variant or "Ring")
			local Position = (Table.Location or ROOT.Position)
			local Coloration = (Table.Color or C3(1,1,1))
			local Texture = (Table.Material or "Slate")
			local Fling = (Table.Scatter or 1)
			local Number = (Table.Amount or 1)
			local Rocks = (Table.DebreeCount or 1)
			local Range = (Table.Distance or 1)
			local Scale = (Table.Size or 1)
			local Timer = (Table.Delay or 1.5)
			coroutine.resume(coroutine.create(function()
				local ScaleVector = VT(Scale,Scale,Scale)
				local Boulders = {}
				Position = CF(Position)
				if KindOf == "Ring" or KindOf == "Both" then
					for RockValue = 1, Number do
						local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale/4),math.ceil(Scale/4)),Range)
						local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
						BOULDER.CanCollide = true
						BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
						BOULDER.Color = Coloration
						table.insert(Boulders,BOULDER)
					end
				end
				if KindOf == "Loose" or KindOf == "Both" then
					for RockValue = 1, Rocks do
						local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale-(Scale/2)),math.ceil(Scale-(Scale/2))),0.7)
						local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, false)
						BOULDER.CanCollide = true
						BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
						BOULDER.Velocity = CF(BOULDER.Position-VT(0,4,0),BOULDER.CFrame*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))*CF(0,5,0).p).lookVector*MRANDOM(Fling-(Fling/1.5),Fling+(Fling/1.5))
						BOULDER.Color = Coloration
						table.insert(Boulders,BOULDER)
					end
				end
				if KindOf == "Random" then
					for RockValue = 1, Number do
						local LOCATION = Position * ANGLES(RAD(0), RAD((360/Number)*RockValue), RAD(0))*CF(0,MRANDOM(-math.ceil(Scale/4),math.ceil(Scale/4)),MRANDOM(0,Range))
						local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
						BOULDER.CanCollide = true
						BOULDER.CFrame = LOCATION*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
						BOULDER.Color = Coloration
						table.insert(Boulders,BOULDER)
					end
				end
				wait(Timer)
				for E = 1, 45 do
					Swait()
					for A = 1, #Boulders do
						Boulders[A].Transparency = Boulders[A].Transparency + 1/45
					end
				end
				for A = 1, #Boulders do
					Boulders[A]:Destroy()
				end
			end))
		end

		function Chatter(Text,Timer)
			local chat = coroutine.wrap(function()
				if CHARACTER:FindFirstChild("SpeechBoard")~= nil then
					CHARACTER:FindFirstChild("SpeechBoard"):destroy()
				end
				local naeeym2 = IT("BillboardGui",CHARACTER)
				naeeym2.Size = UD2(0,100,0,40)
				naeeym2.StudsOffset = Vector3.new(0,2,0)
				naeeym2.Adornee = HEAD
				naeeym2.Name = "SpeechBoard"
				naeeym2.AlwaysOnTop = true
				local tecks2 = IT("TextLabel",naeeym2)
				tecks2.BackgroundTransparency = 1
				tecks2.BorderSizePixel = 0
				tecks2.Text = ""
				tecks2.Font = "Legacy"
				tecks2.TextSize = 15
				tecks2.TextStrokeTransparency = 0
				tecks2.TextColor3 = Color3.new(1,1,1)
				tecks2.TextStrokeColor3 = Color3.new(0,0,0)
				tecks2.Size = UDim2.new(1,0,0.5,0)
				for i = 1,string.len(Text),1 do
					if naeeym2.Parent ~= CHARACTER then 
						break
					end
					NewSound({ID = 418252437,PARENT = HEAD,VOLUME = 1,PITCH = MRANDOM(8,12)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					tecks2.Text = string.sub(Text,1,i)
					wait(Timer)
				end
				wait(1)
				naeeym2:Destroy()
			end)
			chat()
		end

		function SpawnPuddle(POSITION,IGNR,GOO)
			local HIT,POS,NOR = Raycast(POSITION, CFrame.new(POSITION,POSITION-Vector3.new(0,1,0)).lookVector, 12, {IGNR,CHARACTER})
			if HIT then
				coroutine.resume(coroutine.create(function()
					local GOREPART = CreatePart(3, Effects, "Slate", 0, 1, "Pearl", "Gore", VT(3,0,3), true)
					local SURFACE = script.PuddleSurface:Clone()
					SURFACE.Parent = GOREPART
					if GOO == true then
						SURFACE.Image.ImageColor3 = C3(0,0,0)
					end
					GOREPART.CFrame = CFrame.new(POS,POS+NOR)*CFrame.Angles(math.rad(-90),math.rad(math.random(0,360)),0)
					for i = 1, math.random(25,65) do
						Swait()
						GOREPART.Size = GOREPART.Size + Vector3.new(0.1,0,0.1)
					end
					wait(math.random(10,25)/50)
					for i = 1, 25 do
						Swait()
						SURFACE.Image.ImageTransparency = SURFACE.Image.ImageTransparency + 1/25
					end
					GOREPART:Remove()
				end))
			end
		end

		function Dismember(MAN,DOWHAT)
			if MAN == nil then return end
			if MAN.Name == PLAYER.Name then return end
			for index, CHILD in pairs(MAN:GetDescendants()) do
				if CHILD:IsA("Script") or CHILD:IsA("LocalScript") then
					delete(CHILD)
				end
			end
			if DOWHAT == "Ragdoll" then
				local HUM = MAN:FindFirstChildOfClass("HumanoidRootPart")
				if HUM then
					delete(HUM)
				end
			else
				local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
				local HED = MAN:FindFirstChild("Head")
				local RA = MAN:FindFirstChild("Right Arm") or MAN:FindFirstChild("RightUpperArm")
				local LA = MAN:FindFirstChild("Left Arm") or MAN:FindFirstChild("LeftUpperArm")
				local RL = MAN:FindFirstChild("Right Leg") or MAN:FindFirstChild("RightUpperLeg")
				local LL = MAN:FindFirstChild("Left Leg") or MAN:FindFirstChild("LeftUpperLeg")
				if TORSO and HED then
					if DOWHAT == "Head" then
						if HED then
							delete(HED)
						end
					elseif DOWHAT == "RightArm" then
						if RA then
							delete(RA)
						end
					elseif DOWHAT == "LeftArm" then
						if LA then
							delete(LA)
						end
					elseif DOWHAT == "Legs" then
						if RL then delete(RL) end
						if LL then delete(LL) end
					end
				end
				spawn(function()
					task.wait(1)
					delete(HED or TORSO)
				end)
			end
		end

		function Speak(ID)
		end

		--//====================================================\\--
		--||                     CHARACTER
		--\\====================================================//--

		local ARMOR = IT("Model",CHARACTER)
		ARMOR.Name = "Goner"
		local PARTS = {}

		local SWORD = MODULE.Sword
		SWORD.Parent = ARMOR
		SWORD.Anchored = false
		SWORD.Transparency = 1
		local GRIPC0 = CF(0,-0.9,0)*ANGLES(RAD(90),RAD(90),0)
		local HOLD = IT("ManualWeld")
		HOLD.Part0 = RIGHTARM
		HOLD.Part1 = SWORD
		HOLD.C0 = GRIPC0
		HOLD.C1 = CF(0,-SWORD.Size.Y/3,0)
		HOLD.Parent = RIGHTARM
		HOLD.Name = "GripWeld"
		local TRAIL = SWORD.Trail
		local SOUND_SNAP = 150315649
		local SUBMERGED = false
		table.insert(PARTS,SWORD)
		local GUI = MODULE.ControlsGUI
		GUI.Parent = PLAYER.PlayerGui
		GUI.ToggleButton.MouseButton1Click:Connect(function()
			if GUI.ToggleButton.Controls.Visible == false then
				GUI.ToggleButton.Controls.Visible = true
			elseif GUI.ToggleButton.Controls.Visible == true then
				GUI.ToggleButton.Controls.Visible = false
			end
		end)

		--//====================================================\\--
		--||                     ABILITIES
		--\\====================================================//--

		function Slash()
			ATTACKING = true
			for i=0, 0.2, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * ANGLES(RAD(25), RAD(180), RAD(0)) * RIGHTSHOULDERC0, 2 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)), 2 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			TRAIL.Enabled = true
			NewSound({ID = 211059653,PARENT = SWORD,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			for i=0, 0.1, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(0), RAD(0), RAD(-90)) * RIGHTSHOULDERC0, 0.65 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)), 0.75 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(-5), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			for index, CHILD in pairs(workspace:GetChildren()) do
				if CHILD:FindFirstChildOfClass("Humanoid") and CHILD ~= CHARACTER and CHILD.Name ~= PLAYER.Name then
					local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
					local ROOT2 = HUMAN.Torso
					if ROOT2 and HUMAN.Health > 0 then
						if (ROOT2.Position - ROOT.CFrame*CF(0,0,-2).p).Magnitude < 4.5 then
							local HEAD = CHILD:FindFirstChild("Head")
							if HEAD then
								local FACE = HEAD:FindFirstChild("face")
								if FACE then
									FACE.Texture = "http://www.roblox.com/asset/?id=145854465"
									FACE.Transparency = 0.5
								end
							end
							Dismember(CHILD,"Ragdoll")
							Dismember(CHILD,"Head")
							NewSound({ID = 264486467,PARENT = ROOT2,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
							NewSound({ID = SOUND_SNAP,PARENT = ROOT2,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
							for i = 1, 7 do
								OofOuchBlood(ROOT2.Position,CF(ROOT2.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
							end
							coroutine.resume(coroutine.create(function()
								for i = 1, 25 do
									SpawnPuddle(ROOT2.Position,CHILD,false)
									Swait()
								end
							end))
						end
					end
				end
			end
			for i=0, 0.3, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(0), RAD(0), RAD(-90)) * RIGHTSHOULDERC0, 0.65 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)), 0.75 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(-5), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
			end
			TRAIL.Enabled = false
			ATTACKING = false
		end

		function Execute(INPUT)
			local TARGET = nil
			local DIST = 6
			for index, CHILD in pairs(workspace:GetChildren()) do
				if CHILD:FindFirstChildOfClass("Humanoid") and CHILD ~= CHARACTER and CHILD.Name ~= PLAYER.Name then
					local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
					local ROOT2 = HUMAN.Torso
					if ROOT2 and HUMAN.Health > 0 then
						if (ROOT2.Position - ROOT.Position).Magnitude < DIST then
							TARGET = CHILD
							DIST = (ROOT2.Position - ROOT.Position).Magnitude
						end
					end
				end
			end
			if TARGET and (SUBMERGED == false or ((INPUT == "x" or INPUT == "z" or INPUT == "c") and SUBMERGED == true)) then
				local DedFace = function()
					local HEAD = TARGET:FindFirstChild("Head")
					if HEAD then
						local FACE = HEAD:FindFirstChild("face")
						if FACE then
							FACE.Texture = "http://www.roblox.com/asset/?id=145854465"
							FACE.Transparency = 0.5
						end
					end
				end
				local TARGETSTATIC = nil
				local SOUND = NewSound({ID = 2737898305,PARENT =nil,VOLUME = 3,PITCH = 1,LOOP = true,MAXDISTANCE = 125,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = false})
				SOUND.Name = "Static"
				Swait()
				local TARGETTORSO = TARGET:FindFirstChild("Torso") or TARGET:FindFirstChild("UpperTorso")
				local GRABA = IT("Attachment")
				GRABA.Position = VT(0,-1.5,0)
				local GRABB = IT("Attachment")
				local GRAB = IT("BallSocketConstraint")
				GRAB.Attachment0 = GRABA
				GRAB.Attachment1 = GRABB
				local GYRO = IT("BodyGyro")
				GYRO.D = 20
				GYRO.P = 5000
				GYRO.MaxTorque = VT(0,4000000,0)
				GYRO.CFrame = CF(TARGETTORSO.Position,ROOT.Position)
				GYRO.Parent = nil
				ATTACKING = true
				ROOT.Anchored = true
				if INPUT == "z" then
					for i=0, 1, 0.1 / ANIM_SPEED do
						Swait()
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(90)) * ANGLES(RAD(25), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 0.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(85), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					end
					TRAIL.Enabled = true
					NewSound({ID = 211059653,PARENT = SWORD,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					for i=0, 0.1, 0.1 / ANIM_SPEED do
						Swait()
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(35), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(85), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					end
					CameraShake(ROOT.Position,4.6,15,25)
					Dismember(TARGET,"Ragdoll")
					Dismember(TARGET,"Head")
					DedFace()
					GYRO:Remove()
					NewSound({ID = 264486467,PARENT = TARGETTORSO,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					for i = 1, 7 do
						OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
					end
					coroutine.resume(coroutine.create(function()
						for i = 1, 25 do
							SpawnPuddle(TARGETTORSO.Position,TARGET,false)
							Swait()
						end
					end))
					for i=0, 0.9, 0.1 / ANIM_SPEED do
						Swait()
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-1)), 1.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.5, -0.85) * ANGLES(RAD(35), RAD(0), RAD(-90)) * ANGLES(RAD(25), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(85), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					end
					TRAIL.Enabled = false
				elseif INPUT == "x" then
					for i=0, 1, 0.1 / ANIM_SPEED do
						Swait()
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(0), RAD(90)) * ANGLES(RAD(25), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 0.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(125), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					end
					TRAIL.Enabled = true
					NewSound({ID = 536642316,PARENT = SWORD,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					for i=0, 0.1, 0.1 / ANIM_SPEED do
						Swait()
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-10)), 1.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.35, -0.85) * ANGLES(RAD(-25), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(125), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					end
					CameraShake(ROOT.Position,4.6,15,25)
					Dismember(TARGET,"Ragdoll")
					Dismember(TARGET,"Legs")
					DedFace()
					GYRO:Remove()
					NewSound({ID = 264486467,PARENT = TARGETTORSO,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					for i = 1, 7 do
						OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
					end
					coroutine.resume(coroutine.create(function()
						for i = 1, 25 do
							SpawnPuddle(TARGETTORSO.Position,TARGET,false)
							Swait()
						end
					end))
					for i=0, 0.9, 0.1 / ANIM_SPEED do
						Swait()
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(-1)), 1.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.1, 0.35, -0.85) * ANGLES(RAD(-25), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(85)) * ANGLES(RAD(0),RAD(90),RAD(0)), 1.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(125), RAD(-10), RAD(20)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
					end
					TRAIL.Enabled = false
				elseif INPUT == "c" then
					if SUBMERGED == false then
						GRABA:Remove()
						GRABB:Remove()
						local DEAD = false
						Dismember(TARGET,"Ragdoll")
						coroutine.resume(coroutine.create(function()
							repeat
								Swait()
								TARGETTORSO.CFrame = Clerp(TARGETTORSO.CFrame,ROOT.CFrame*CF(0,-3,-1.5) * ANGLES(RAD(-90), RAD(0), RAD(0)),0.3)
							until DEAD == true
							coroutine.resume(coroutine.create(function()
								for i = 1, 25 do
									SpawnPuddle(TARGETTORSO.Position+VT(0,1,0),TARGET,false)
									Swait()
								end
							end))
							DedFace()
						end))
						for i=0, 1.5, 0.1 / ANIM_SPEED do
							Swait()
							ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
							HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
							LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-5)) * CF(0,-0.75,0) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
							RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
						end
						for i = 1, 7 do
							OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,15)
						end
						CameraShake(ROOT.Position,4.6,15,25)
						Dismember(TARGET,"LeftArm")
						local ARM = TARGET:FindFirstChild("Left Arm") or TARGET:FindFirstChild("LeftUpperArm")
						if ARM then
							local BV = IT("BodyVelocity")
							BV.MaxForce = BV.MaxForce * 500
							BV.Velocity = CF(ARM.Position,ROOT.Position+VT(0,2,0)).lookVector*65
							BV.Parent = ARM
							Debris:AddItem(BV,0.05)
						end
						NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1.1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
						for i=0, 0.3, 0.1 / ANIM_SPEED do
							Swait()
							ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
							HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
							LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 1) * ANGLES(RAD(90), RAD(0), RAD(-5)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
							RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
						end
						for i=0, 0.3, 0.1 / ANIM_SPEED do
							Swait()
							ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
							HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
							LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.5) * ANGLES(RAD(90), RAD(0), RAD(85)) * CF(0,-1.25,0) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
							RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
						end
						for i = 1, 7 do
							OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,15)
						end
						CameraShake(ROOT.Position,4.6,15,25)
						Dismember(TARGET,"RightArm")
						local ARM = TARGET:FindFirstChild("Right Arm") or TARGET:FindFirstChild("RightUpperArm")
						if ARM then
							local BV = IT("BodyVelocity")
							BV.MaxForce = BV.MaxForce * 500
							BV.Velocity = CF(ARM.Position,ROOT.Position+VT(0,2,0)).lookVector*65
							BV.Parent = ARM
							Debris:AddItem(BV,0.05)
						end
						NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 6,PITCH = 1.1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
						DEAD = true
						for i=0, 0.3, 0.1 / ANIM_SPEED do
							Swait()
							ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1) * ANGLES(RAD(30), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
							HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(70)), 1.5 / ANIM_SPEED)
							LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 1) * ANGLES(RAD(90), RAD(0), RAD(85)) * CF(0,0.75,0) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
							RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1.5 / ANIM_SPEED)
						end
					else
						local POS = ROOT.Position
						Dismember(TARGET,"Ragdoll")
						TARGET.Parent = Effects
						for i = 1, 60 do
							Swait()
							SpawnPuddle(TARGETTORSO.Position,TARGET,true)
							TARGETTORSO.CFrame = TARGETTORSO.CFrame*CF(0,-0.1,0)
						end
						for i = 1, 7 do
							OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,50,-1).p,3)
						end
						TARGET:Remove()
					end
				elseif INPUT == "v" then
					GRABA:Remove()
					GRABB:Remove()
					local DEAD = false
					coroutine.resume(coroutine.create(function()
						repeat
							Swait()
							TARGETTORSO.CFrame = Clerp(TARGETTORSO.CFrame,ROOT.CFrame*CF(0,-3,-1.2) * ANGLES(RAD(-90), RAD(0), RAD(0)),0.3)
						until DEAD == true
						DedFace()
						Dismember(TARGET,"Head")
						coroutine.resume(coroutine.create(function()
							for i = 1, 25 do
								SpawnPuddle(TARGETTORSO.Position+VT(0,1,0),TARGET,false)
								Swait()
							end
						end))
					end))
					for i=0, 0.5, 0.1 / ANIM_SPEED do
						Swait()
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0.3, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(20)), 1.5 / ANIM_SPEED)
					end
					for i = 1, MRANDOM(6,12) do
						for i=0, 0.5, 0.1 / ANIM_SPEED do
							Swait()
							ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
							RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
							HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
							LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
							RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, 0.3, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(20)), 1.5 / ANIM_SPEED)
						end
						for i=0, 0.1, 0.1 / ANIM_SPEED do
							Swait()
							ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
							RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
							HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
							LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
							RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(-20)), 1.5 / ANIM_SPEED)
						end
						CameraShake(ROOT.Position,4.6,15,25)
						NewSound({ID = SOUND_SNAP,PARENT = TARGETTORSO,VOLUME = 1,PITCH = 1.25,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
						for i = 1, 7 do
							OofOuchBlood(TARGETTORSO.Position,CF(TARGETTORSO.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,15)
						end
						for i=0, 0.2, 0.1 / ANIM_SPEED do
							Swait()
							ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
							RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
							HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
							LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
							RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
							LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(-20)), 1.5 / ANIM_SPEED)
						end
					end
					DEAD = true
					for i=0, 0.6, 0.1 / ANIM_SPEED do
						Swait()
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.025) * ANGLES(RAD(10), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 1.5 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35), RAD(5), RAD(0)) * RIGHTSHOULDERC0, 1.5 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 1.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 1.5 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, -1) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1.5 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(-20)), 1.5 / ANIM_SPEED)
					end
				end
				GYRO:Remove()
				if (INPUT ~= "c" or SUBMERGED == false) then
					Speak(2291326656)
				end
				if TARGETSTATIC then
					TARGETSTATIC:Remove()
				end
				GRABA:Remove()
				GRABB:Remove()
				ROOT.Anchored = false
				ATTACKING = false
			end
		end

		function Shriek()
			ROOT.Anchored = true
			ATTACKING = true
			for i=0, 0.15, 0.1 / ANIM_SPEED do
				Swait()
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.2) * ANGLES(RAD(0), RAD(0), RAD(10)), 2 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(5), RAD(0)), 2 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.7, 0) * ANGLES(RAD(25), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 2 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 2 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(45), RAD(-10), RAD(25)) * LEFTSHOULDERC0, 2 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.8, -0.4) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(-20)), 2 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -0.8, -0.4) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(20)), 2 / ANIM_SPEED)
			end
			local FACE = IT("Attachment",HEAD)
			local SPEAK = MODULE.Voice:Clone()
			SPEAK.Size = NumberSequence.new(0,25)
			SPEAK.Parent = FACE
			SPEAK.Enabled = true
			Speak(2466752906)
			CameraShake(ROOT.Position,65,8,150)
			for i=0, 1.75, 0.1 / ANIM_SPEED do
				Swait()
				for index, CHILD in pairs(workspace:GetChildren()) do
					if CHILD:FindFirstChildOfClass("Humanoid") and CHILD ~= CHARACTER and CHILD.Name ~= PLAYER.Name then
						local HUMAN = CHILD:FindFirstChildOfClass("Humanoid")
						local ROOT2 = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
						if ROOT2 and HUMAN.Health > 0 and CHILD:FindFirstChild("Head") then
							if (ROOT2.Position - ROOT.Position).Magnitude < 45 then
								local HED = CHILD:FindFirstChild("Head")
								Dismember(CHILD,"Ragdoll")
								for i = 1, 7 do
									OofOuchBlood(HED.Position,CF(HED.Position)*ANGLES(0,RAD(MRANDOM(0,359)),0)*CF(0,1,-1).p,45)
								end
								NewSound({ID = 264486467,PARENT = ROOT2,VOLUME = 2,PITCH = 0.7,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
								NewSound({ID = SOUND_SNAP,PARENT = ROOT2,VOLUME = 6,PITCH = 1,LOOP = false,MAXDISTANCE = 100,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
								coroutine.resume(coroutine.create(function()
									for i = 1, 8 do
										SpawnPuddle(ROOT2.Position+VT(0,1,0),CHILD,false)
										Swait()
									end
								end))
								Dismember(CHILD,"Head")
							end
						end
					end
				end
				ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 0.5 / ANIM_SPEED)
				NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-25+MRANDOM(-5,5)), RAD(5+MRANDOM(-5,5)), RAD(MRANDOM(-5,5))), 0.5 / ANIM_SPEED)
				RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
				HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
				LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, -0.3) * ANGLES(RAD(45+MRANDOM(-5,5)), RAD(-10+MRANDOM(-5,5)), RAD(-25+MRANDOM(-5,5))) * ANGLES(RAD(-75), RAD(0), RAD(0)) * LEFTSHOULDERC0, 0.5 / ANIM_SPEED)
				RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
				LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
			end
			SPEAK.Enabled = false
			Debris:AddItem(FACE,1)
			ATTACKING = false
			ROOT.Anchored = false
		end

		function Speech(INPUT)
			ATTACKING = true
			if INPUT == "t" then
				Speak(2316600989)
			elseif INPUT == "y" then
				Speak(2290634374)
			elseif INPUT == "u" then
				Speak(2291325961)
			end
			ATTACKING = false
		end

		--//====================================================\\--
		--||                       WRAP
		--\\====================================================//--
		Mouse.Button1Up:Connect(function()
			MOUSEHOLD = false
		end)
		Mouse.Button1Down:connect(function()
			if SUBMERGED == false then
				MOUSEHOLD = true
				Slash()
			end
		end)
		Mouse.KeyDown:Connect(function(V2)
			KEYHOLD = true
			if V2 == "e" then
				if ROOT:FindFirstChild("BGM_MUSIC") then
					ROOT:FindFirstChild("BGM_MUSIC"):Remove()
				else
					local M = NewSound({ID = 2598782592,PARENT = ROOT,VOLUME = 1.5,PITCH = 0.4,LOOP = true,MAXDISTANCE = 300,EMITTERSIZE = 300,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
					M.Name = "BGM_MUSIC"
				end
			elseif V2 == "z" or V2 == "x" or V2 == "c" or V2 == "v" then
				Execute(V2)
			elseif V2 == "g" and SUBMERGED == false then
				Shriek()
			elseif V2 == "q" then
				if SUBMERGED == false then
					SUBMERGED = true
				else
					ROOT.Anchored = false
					SUBMERGED = false
					ROOT.CFrame = ROOT.CFrame*CF(0,3,0)
				end
			elseif V2 == "w" and SUBMERGED == true and ATTACKING == false then
				repeat
					ROOT.CFrame = CF(ROOT.Position,VT(MOUSEPOS.X,ROOT.Position.Y,MOUSEPOS.Z))*CF(0,0,-0.5)
					Swait()
				until KEYHOLD == false or SUBMERGED == false or ATTACKING == true
			elseif V2 == "s" and SUBMERGED == true and ATTACKING == false then
				repeat
					ROOT.CFrame = CF(ROOT.Position,VT(MOUSEPOS.X,ROOT.Position.Y,MOUSEPOS.Z))*CF(0,0,0.25)
					Swait()
				until KEYHOLD == false or SUBMERGED == false or ATTACKING == true
			elseif V2 == "a" and SUBMERGED == true and ATTACKING == false then
				repeat
					ROOT.CFrame = CF(ROOT.Position,VT(MOUSEPOS.X,ROOT.Position.Y,MOUSEPOS.Z))*CF(-0.1,0,0)
					Swait()
				until KEYHOLD == false or SUBMERGED == false or ATTACKING == true
			elseif V2 == "d" and SUBMERGED == true and ATTACKING == false then
				repeat
					ROOT.CFrame = CF(ROOT.Position,VT(MOUSEPOS.X,ROOT.Position.Y,MOUSEPOS.Z))*CF(0.1,0,0)
					Swait()
				until KEYHOLD == false or SUBMERGED == false or ATTACKING == true
			elseif V2 == "t" or V2 == "y" or V2 == "u" then
				Speech(V2)
			end
		end) 

		local TWITCH = 0
		while true do
			Swait()
			SINE = SINE + CHANGE
			if CHARACTER:FindFirstChild("Animate") then
				CHARACTER:FindFirstChild("Animate"):Destroy()
			end
			if CHARACTER:FindFirstChild("Sound") then
				CHARACTER:FindFirstChild("Sound"):Destroy()
			end
			for _,v in next, HUM:GetPlayingAnimationTracks() do
				v:Stop();
			end
			local TORSOVELOCITY = (ROOT.Velocity * VT(1, 0, 1)).magnitude
			local TORSOVERTICALVELOCITY = ROOT.Velocity.y
			local HITFLOOR,HITPOS = Raycast(ROOT.Position, (CF(ROOT.Position, ROOT.Position + VT(0, -1, 0))).lookVector, 4+HUM.HipHeight, CHARACTER)
			local WALKSPEEDVALUE = 10
			local SITTING = HUM.Sit
			if ANIM == "Walk" and TORSOVELOCITY > 1 and ATTACKING == false and SITTING == false then
				ROOTJOINT.C1 = Clerp(ROOTJOINT.C1, ROOTC0 * CF(0, 0, -0.015 * COS(SINE / (WALKSPEEDVALUE / 2))) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 * (HUM.WalkSpeed / 16) / ANIM_SPEED)
				NECK.C1 = Clerp(NECK.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - HEAD.RotVelocity.Y / 30), 0.2 * (HUM.WalkSpeed / 16) / ANIM_SPEED)
				RIGHTHIP.C1 = Clerp(RIGHTHIP.C1, CF(0.5, 0.875 - 0.3 * SIN(SINE / WALKSPEEDVALUE), -0.5 * COS(SINE / WALKSPEEDVALUE) +0.2+ 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(35 * COS(SINE / WALKSPEEDVALUE))), 0.6 / ANIM_SPEED)
				LEFTHIP.C1 = Clerp(LEFTHIP.C1, CF(-0.5, 0.875 + 0.3 * SIN(SINE / WALKSPEEDVALUE), 0.5 * COS(SINE / WALKSPEEDVALUE) +0.2+ -0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(35 * COS(SINE / WALKSPEEDVALUE))), 0.6 / ANIM_SPEED)
			elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) or ATTACKING == true or SITTING == true then
				ROOTJOINT.C1 = Clerp(ROOTJOINT.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
				NECK.C1 = Clerp(NECK.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
				RIGHTHIP.C1 = Clerp(RIGHTHIP.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
				LEFTHIP.C1 = Clerp(LEFTHIP.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / ANIM_SPEED)
			end
			if SITTING == false then
				if HITFLOOR then
					if SUBMERGED == false then
						HUM.JumpPower = 50
						HUM.WalkSpeed = 8
						if TORSOVELOCITY < 1 and HITFLOOR ~= nil then
							ANIM = "Idle"
							if MRANDOM(1,15) == 1 and ATTACKING == false then
								SpawnPuddle(HITPOS+VT(0,0.5,0),CHARACTER,true)
							end
							if ATTACKING == false then
								ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(10)), 0.5 / ANIM_SPEED)
								NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(5), RAD(0)), 0.5 / ANIM_SPEED)
								RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 0.5 / ANIM_SPEED)
								HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(-5),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
								LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(-10), RAD(0)) * LEFTSHOULDERC0, 0.5 / ANIM_SPEED)
								RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
								LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 0.5 / ANIM_SPEED)
							end
						elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
							ANIM = "Walk"
							if MRANDOM(1,5) == 1 and ATTACKING == false then
								SpawnPuddle(HITPOS+VT(0,0.5,0),CHARACTER,true)
							end
							if ATTACKING == false then
								ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.05) * ANGLES(RAD(5), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
								NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5 - 1 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
								RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5-0.015 * COS(SINE / (WALKSPEEDVALUE / 2)), 0) * ANGLES(RAD(25), RAD(20), RAD(5)) * RIGHTSHOULDERC0, 0.75 / ANIM_SPEED)
								HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(5)), 0.5 / ANIM_SPEED)
								LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.45, 0.5-0.015 * SIN(SINE / (WALKSPEEDVALUE / 2)), -0.5) * ANGLES(RAD(95), RAD(-5), RAD(-5)) * LEFTSHOULDERC0, 0.75 / ANIM_SPEED)
								RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(-15)), 2 / ANIM_SPEED)
								LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(15)), 2 / ANIM_SPEED)
							end
						end
					elseif SUBMERGED == true then
						HUM.JumpPower = 0
						HUM.WalkSpeed = 0
						MOUSEPOS = Mouse.Hit.Position
						if MRANDOM(1,2) == 1 then
							SpawnPuddle(HITPOS+VT(0,0.5,0),CHARACTER,true)
						end
						ANIM = "Submerged"
						ROOT.Anchored = true
						if ATTACKING == false then
							ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -1.5) * ANGLES(RAD(90), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
							NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(0), RAD(0)), 0.25 / ANIM_SPEED)
							RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 0.75 / ANIM_SPEED)
							HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(90)), 0.5 / ANIM_SPEED)
							LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 0.75 / ANIM_SPEED)
							RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / ANIM_SPEED)
							LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / ANIM_SPEED)
						end
						ROOT.CFrame = CF(HITPOS+VT(0,0.05,0))*ANGLES(0,RAD(ROOT.Orientation.Y),0)
					end
				else
					SUBMERGED = false
					ANIM = "Midair"
					if ATTACKING == false then
						ROOT.Anchored = false
						ROOTJOINT.C0 = Clerp(ROOTJOINT.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-10), RAD(0), RAD(0)), 1 / ANIM_SPEED)
						NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(20), RAD(0), RAD(0)), 1 / ANIM_SPEED)
						RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / ANIM_SPEED)
						HOLD.C0 = Clerp(HOLD.C0, GRIPC0 * CF(0,0,0) * ANGLES(RAD(0),RAD(0),RAD(0)), 0.5 / ANIM_SPEED)
						LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / ANIM_SPEED)
						RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 1 / ANIM_SPEED)
						LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1 / ANIM_SPEED)
					end
				end
			else
				SUBMERGED = false
				ANIM = "Sit"
				if ATTACKING == false then
					ROOTJOINT.C0 = Clerp(ROOTJOINT.C0,ROOTC0 * CF(0, 0, -0.5) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.25 / ANIM_SPEED)
					NECK.C0 = Clerp(NECK.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.25 / ANIM_SPEED)
					RIGHTSHOULDER.C0 = Clerp(RIGHTSHOULDER.C0, CF(1.5, 0.65, 0) * ANGLES(RAD(50), RAD(10), RAD(-45))*CF(0,-0.25,0) * RIGHTSHOULDERC0, 1.25 / ANIM_SPEED)
					LEFTSHOULDER.C0 = Clerp(LEFTSHOULDER.C0, CF(-1.5, 0.65, 0) * ANGLES(RAD(50), RAD(-10), RAD(45))*CF(0,-0.25,0) * LEFTSHOULDERC0, 1.25 / ANIM_SPEED)
					RIGHTHIP.C0 = Clerp(RIGHTHIP.C0, CF(1, -0.25, -1) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1.25 / ANIM_SPEED)
					LEFTHIP.C0 = Clerp(LEFTHIP.C0, CF(-1, -0.25, -1) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-10)), 1.25 / ANIM_SPEED)
				end
			end
			if TWITCH > 0 then
				TWITCH = TWITCH - 1
				NECK.C0 = NECK.C0 * ANGLES(RAD(MRANDOM(-5,5)), RAD(MRANDOM(-5,5)), RAD(MRANDOM(-5,5)))
			else
				if MRANDOM(1,25) == 1 then
					TWITCH = MRANDOM(2,12)
				end
			end
		end
	elseif isCmd(cmd, {"moon"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		local function breakJoints(instance)
			for i,v in pairs(instance:GetDescendants()) do
				if not (v:IsA("Weld") or v:IsA("WeldConstraint") or v:IsA("JointInstance")) then continue end
				delete(v)
			end
		end

		iz = (Player.Name)

		is = (Player.Character)


		for i,v in pairs(is:GetChildren()) do
			if v.ClassName == 'Accessory' then
				delete(v)
			end
		end

		for i,v in pairs(is:GetChildren()) do
			if v.ClassName == 'Shirt' then
				delete(v)
			end
		end

		for i,v in pairs(is:GetChildren()) do
			if v.ClassName == 'Pants' then
				delete(v)
			end
		end

		local function findRemoteEvent(name)
			local replicatedStorage = game:GetService("ReplicatedStorage")
			local workspace = game:GetService("Workspace")
			for _, parent in ipairs({replicatedStorage, workspace}) do
				for _, child in ipairs(parent:GetDescendants()) do
					if child:IsA("RemoteEvent") and child.Name == name then
						return child
					end
				end
			end
			return nil
		end

		wait()

		hat1 = Instance.new('Hat')
		hat1.Parent = Players[iz].Character

		handle = Instance.new('Part')
		handle.Name = 'Handle'
		handle.Parent = hat1

		handlemesh = Instance.new('SpecialMesh')
		handlemesh.MeshType = 'FileMesh'
		handlemesh.MeshId = 'http://www.roblox.com/asset/?id=23265118'
		handlemesh.TextureId = 'rbxassetid://252864626'
		handlemesh.Parent = handle

		hat2 = Instance.new('Hat')
		hat2.Parent = Players[iz].Character

		shirt = Instance.new('Shirt')
		shirt.Parent = is
		shirt.ShirtTemplate = 'http://www.roblox.com/asset/?id=274490358'

		shirt = Instance.new('Pants')
		shirt.Parent = is
		shirt.PantsTemplate = 'http://www.roblox.com/asset/?id=274490617'

		sound = Instance.new('Sound')
		sound.SoundId = 'http://www.roblox.com/asset/?id=476296898'
		sound.Looped = true
		sound.Parent = is.Torso

		local player = Player
		repeat wait() until player.Character.Humanoid
		local humanoid = player.Character.Humanoid
		local mouse = player:GetMouse()

		local anim = Instance.new("Animation")
		anim.AnimationId = "http://www.roblox.com/Asset?ID=27789359"

		mouse.KeyDown:connect(function(key)
			if key == "z" then
				local anim = Instance.new("Animation")
				anim.AnimationId = "http://www.roblox.com/Asset?ID=27789359"
				sound:Play()
				local playAnim = humanoid:LoadAnimation(anim)
				playAnim:Play()
			end
		end)

		mouse.KeyDown:connect(function(key)
			if key == "x" then
				sound:Stop()
				local playAnim = humanoid:LoadAnimation(anim)
				anim.AnimationId = "http://www.roblox.com/Asset?ID=0"
				playAnim:Play()
				playAnim:Stop()
				print('Dance is stopped')

			end
		end)






		iz = (Player.Name)

		is = (Player.Character)

		is.Head.Transparency = 1

		for i,v in pairs(is:GetChildren()) do
			if v.ClassName == 'Hat' then
				delete(v)
			end
		end

		for i,v in pairs(is:GetChildren()) do
			if v.ClassName == 'Shirt' then
				delete(v)
			end
		end

		for i,v in pairs(is:GetChildren()) do
			if v.ClassName == 'Pants' then
				delete(v)
			end
		end


		local function breakJoints(instance)
			for i,v in pairs(instance:GetDescendants()) do
				if not (v:IsA("Weld") or v:IsA("WeldConstraint") or v:IsA("JointInstance")) then continue end
				delete(v)
			end
		end

		wait()

		hat1 = Instance.new('Hat')
		hat1.Parent = Players[iz].Character

		handle = Instance.new('Part')
		handle.Name = 'Handle'
		handle.Parent = hat1

		handlemesh = Instance.new('SpecialMesh')
		handlemesh.MeshType = 'FileMesh'
		handlemesh.MeshId = 'http://www.roblox.com/asset/?id=23265118'
		handlemesh.TextureId = 'rbxassetid://252864626'
		handlemesh.Parent = handle

		hat2 = Instance.new('Hat')
		hat2.Parent = Players[iz].Character

		shirt = Instance.new('Shirt')
		shirt.Parent = is
		shirt.ShirtTemplate = 'http://www.roblox.com/asset/?id=274490358'

		shirt = Instance.new('Pants')
		shirt.Parent = is
		shirt.PantsTemplate = 'http://www.roblox.com/asset/?id=274490617'

		sound = Instance.new('Sound')
		sound.SoundId = 'http://www.roblox.com/asset/?id=476296898'
		sound.Looped = true
		sound.Parent = is.Torso

		local player = Player
		repeat wait() until player.Character.Humanoid
		local humanoid = player.Character.Humanoid
		local mouse = player:GetMouse()

		local anim = Instance.new("Animation")
		anim.AnimationId = "http://www.roblox.com/Asset?ID=27789359"


		local msg = Instance.new("Hint")
		msg.Parent = game.Workspace
		msg.Text = "Click 'z' to get started."
		is.Humanoid.WalkSpeed = 0

		mouse.KeyDown:connect(function(key)
			if key == "z" then
				sound:Play()
				msg:Destroy()
				is.Humanoid.WalkSpeed = 30
				is.Animate.walk.WalkAnim.AnimationId = 'http://www.roblox.com/Asset?ID=252557606'
			end
		end)

		function onTouch(part)
			local remote = findRemoteEvent("AC6_FE_Sounds")
			local humanoid = part.Parent:findFirstChild("Humanoid")
			remote:FireServer("newSound", "Sound1", is.Torso, "rbxassetid://160432334", 1, 1, false)
			remote:FireServer("playSound", "Sound1")

			remote:FireServer("newSound", "Sound2", is.Torso, "rbxassetid://170040190", 1, 1, false)
			remote:FireServer("playSound", "Sound1")
			if (humanoid ~=nil) then
				breakJoints(humanoid.Parent)
			end
		end 

		is.Torso.Touched:connect(onTouch)
	elseif isCmd(cmd, {"kdv2"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		function notify(title,text,duration)
			game.StarterGui:SetCore("SendNotification", {
				Title = title or "", 
				Text = text or "",
				Duration = duration or 5
			})
		end
		local genv = (getgenv and (getgenv() ~= getfenv()) and getgenv()) or _G
		local char = Player.Character or Player.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
		local simRadius = gethiddenproperty and gethiddenproperty(Player,"SimulationRadius")
		local requiredRadius = 20
		local isR15 = hum.RigType == Enum.HumanoidRigType.R15
		local forcefield = char:FindFirstChildOfClass("ForceField")
		local fakeHum = hum:Clone()
		local hrp = char:WaitForChild("HumanoidRootPart")
		local hrpCF = hrp.CFrame
		local stopAlign = false
		local stopAntiVoid = false
		local limbs = {}
		local hatHandles = {}
		local reanimConnections = {}

		runCommand("clip")

		if simRadius and simRadius < requiredRadius then
			repeat
				notify("Please wait",`Waiting for bigger SimulationRadius ({tostring(math.floor(simRadius))}/{tostring(requiredRadius)})`, 2)
				task.wait(2)
			until gethiddenproperty(Player,"SimulationRadius") >= requiredRadius
			if Player.Character == nil or Player.Character ~= char or hum.Parent == nil or hum.Health <= 0 then return end
		end

		if forcefield then forcefield:Destroy() end
		char.Archivable = true

		local rig = (not isR15) and char:Clone()

		if isR15 then
			local canGetObjects, loadedRig = pcall(function() return game:GetObjects("rbxassetid://18418211383")[1] end)
			local r6Rig = isTesting and rStorage:WaitForChild("R6Rig") or canGetObjects and loadedRig or loadstring(httpget("https://gist.githubusercontent.com/someunknowndude/ad264038a91f7fa11bec2f67dad3feaf/raw"))()
			local humDesc = players:GetCharacterAppearanceAsync(Player.UserId)
			local r6Head = r6Rig.Head
			local r15Head = char.Head
			local surfaceAppearance = r15Head:FindFirstChildOfClass("SurfaceAppearance")
			local face = r15Head:FindFirstChild("face")

			if surfaceAppearance then 
				surfaceAppearance:Clone().Parent = r6Head
			else
				--if face then r6Head.face.Texture = face.Texture end
				--r6Head.face.Transparency = 0
			end

			for i,v in pairs(r15Head:GetChildren()) do
				if not v:IsA("Attachment") then continue end
				v:Clone().Parent = r6Head
			end

			for i,v in pairs(humDesc:GetDescendants()) do
				if v:IsA("BodyColors") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic") then
					v.Parent = r6Rig
					continue
				end
				if v:IsA("Accessory") or v:IsA("Hat") then
					r6Rig:WaitForChild("Humanoid"):AddAccessory(v)
				end
			end


			rig = r6Rig
		else
			local mesh = char.Head:FindFirstChildOfClass("SpecialMesh")
			local face = char.Head:FindFirstChild("face")
			if mesh and face then
				delete(face)
			end
		end	

		local rigHRP = rig:WaitForChild("HumanoidRootPart")
		local rigHum = rig:FindFirstChild("Humanoid")

		rig.Name = "wacky reanim rig"


		for i,v in pairs(char:GetChildren()) do
			if not v:IsA("BasePart") then continue end
			table.insert(limbs, {v,rig[v.Name]})
		end


		local accessories = hum:GetAccessories()
		local rigAccessories = rigHum:GetAccessories()

		for i,v in pairs(accessories) do
			if not isR15 then
				table.insert(hatHandles,{v.Handle,rigAccessories[i].Handle})
				continue
			end
			for _,rigAcc in pairs(rigAccessories) do
				local handle = rigAcc.Handle
				local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle
				local texture = handle == mesh and mesh.TextureID or mesh.TextureId
				if not (rigAcc.Name == v.Name and mesh.MeshId == v.Handle.MeshId and texture == v.Handle.TextureID) then continue end
				table.insert(hatHandles,{v.Handle,rigAcc.Handle})
				continue 
			end
		end

		local clock = os and os.clock or tick
		local cos = math.cos
		local sin = math.sin
		local cfNew = CFrame.new
		local cfZero = CFrame.identity
		local v3New = Vector3.new
		local v3Zero = Vector3.zero

		local changedMaxSimRad = pcall(sethiddenproperty, Player, "MaximumSimulationRadius", 1000)
		local changedSimRad = pcall(sethiddenproperty, Player, "SimulationRadius", 1000)
		local netlessCF = cfZero
		local sineValue = 0


		local function align(part0, part1, offset)
			if stopAlign then return end
			if part0 and part0.Parent and part1 and part1.Parent then
				local part0_mass = part1.Mass * 5
				part0.AssemblyLinearVelocity = v3New(part1.AssemblyLinearVelocity.X * part0_mass, sineValue, part1.AssemblyLinearVelocity.Z * part0_mass)
				part0.AssemblyAngularVelocity = part1.AssemblyAngularVelocity

				if isnetworkowner(part0) then
					part0.CFrame = part1.CFrame * offset
				end
			end
		end

		local function setCamera(model)
			local oldCamCF = workspace.CurrentCamera.CFrame
			workspace.CurrentCamera.CameraSubject = model.Humanoid
			workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Once(function()
				workspace.CurrentCamera.CFrame = oldCamCF
			end)
		end

		local function disableCollisions(model,canTouchAndCast)
			for _, part in next, model:GetDescendants() do
				if part and part:IsA("BasePart") then
					part.CanCollide = false
					part.CanQuery = canTouchAndCast
					part.CanTouch = canTouchAndCast
				end
			end
		end

		local function makeTransparent(model)
			for i,v in pairs(model:GetDescendants()) do
				if not (v:IsA("BasePart") or v:IsA("Decal")) then continue end
				v.Transparency = 1
			end
		end

		local function breakJoints(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("JointInstance") then continue end
				delete(v)
			end
		end

		local function removeScripts(model)
			for i,v in pairs(model:GetChildren()) do
				if not (v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") or v.Name == "Animate") then continue end
				delete(v)
			end
		end

		local function removeTouchTriggers(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("TouchTransmitter") then continue end
				delete(v)
			end
		end

		local function onPostSim()
			for _, data in next, limbs do
				align(data[1], data[2],netlessCF)
			end

			for _, data in next, hatHandles do
				align(data[1], data[2], netlessCF)
			end
		end

		local function onPreSim()
			netlessCF = cfNew(0.01 * sin(clock()*16), 0, 0.01 * math.cos(clock()*16))
			sineValue = 40 - 3 * sin(clock()*10)

			if stopAntiVoid or rigHRP.Position.Y > (workspace.FallenPartsDestroyHeight + 50) then return end
			rigHRP.CFrame = hrpCF
			rigHRP.AssemblyLinearVelocity = v3Zero
			rigHRP.AssemblyAngularVelocity = v3Zero
		end


		rigHRP.CFrame = hrpCF
		rig.Parent = workspace
		Player.Character = rig
		setCamera(rig)
		rig.Animate.Enabled = false
		rig.Animate.Enabled = true
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		repeat task.wait() until limbs[3][1].CanCollide
		task.wait(0.05)
		delete(hum)
		repeat task.wait() until hum.Parent == nil
		task.wait()
		fakeHum.Parent = char
		task.wait()
		table.insert(reanimConnections, game:GetService("RunService").PreSimulation:Connect(onPreSim))
		table.insert(reanimConnections, game:GetService("RunService").PostSimulation:Connect(onPostSim))
		table.insert(reanimConnections, game:GetService("RunService").Stepped:Connect(function()
			disableCollisions(char,false)
			disableCollisions(rig,true)
		end))

		breakJoints(char)
		makeTransparent(char)
		removeScripts(char)
		removeTouchTriggers(char)

		genv.LoadLibrary = function(lib) return loadstring(httpget("https://raw.githubusercontent.com/Roblox/Core-Scripts/master/CoreScriptsRoot/Libraries/" .. lib .. ".lua"))() end

		local reset = Instance.new("BindableEvent")
		reset.Event:Connect(function()
			if stopAlign then
				local hum = character:FindFirstChildOfClass("Humanoid")
				if not hum then return character:BreakJoints() end
				hum.Health = 0
				return
			end
			notify("Resetting", "Please wait ~6 seconds", 6)
			stopAntiVoid = true
			rigHRP.Anchored = true
			rigHRP.CFrame = CFrame.new(0,workspace.FallenPartsDestroyHeight + 5,0)
			task.wait(0.5)
			stopAlign = true
			rigHum:ChangeState(Enum.HumanoidStateType.Dead)
			Player.CharacterAdded:Wait()
			rig:Destroy()
			for i,v in pairs(reanimConnections) do
				v:Disconnect()
			end
		end)

		game.StarterGui:SetCore("ResetButtonCallback", reset)

		notify("Success!", "reanim loaded!")
		-----------//KRYSTAL DANCE V2\\-----------
--[[Movelist
Q = The Swoosher
E = The nutty
R = Spin me right round!
T = Plum juice dance
Y = Moonwalk
U = Slav dance
P = Barrel roll
F = The Jerky
G = The Shuffle
H = The Spongebob
J = Here comes the money!
K = Runnin' in the 90's
---------]]

		--Krystal dance! The old famous script that sadly has been broken(sorta), i've decided to rework this thing because... nostalgia.--
		--This is one of the first scripts i've ever ran on SB, seeing this back again really reminds me of how much of a noob i was.--
		--Credits to Krystalteam, they made the original krystal dance! Be sure to respect them or else...--
		--#makeoldscriptsgreatagain--

		Player=Player
		Character=Player.Character
		hum = Character.Humanoid
		LeftArm=Character["Left Arm"]
		LeftLeg=Character["Left Leg"]
		RightArm=Character["Right Arm"]
		RightLeg=Character["Right Leg"]
		Root=Character["HumanoidRootPart"]
		Head=Character["Head"]
		Torso=Character["Torso"]
		Neck=Torso["Neck"]
		mouse = Player:GetMouse()
		walking = false
		jumping = false
		attacking = false
		firsttime = false
		tauntdebounce = false
		position = nil
		MseGuide = true
		running = false
		settime = 0
		sine = 0
		t = 0
		ws = 14
		change = 1
		combo1 = true
		dancing = false
		equip = false
		dgs = 75
		combo2 = false
		switch1 = true
		switch2 = false
		firsttime2 = false
		combo3 = false
		gunallowance = false
		shooting = false
		RunSrv = game:GetService("RunService")
		RenderStepped = game:GetService("RunService").RenderStepped
		removeuseless = game:GetService("Debris")

		screenGui = Instance.new("ScreenGui")
		screenGui.Parent = script.Parent

		local HEADLERP = Instance.new("ManualWeld")
		HEADLERP.Parent = Head
		HEADLERP.Part0 = Head
		HEADLERP.Part1 = Head
		HEADLERP.C0 = CFrame.new(0, -1.5, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

		local TORSOLERP = Instance.new("ManualWeld")
		TORSOLERP.Parent = Root
		TORSOLERP.Part0 = Torso
		TORSOLERP.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

		local ROOTLERP = Instance.new("ManualWeld")
		ROOTLERP.Parent = Root
		ROOTLERP.Part0 = Root
		ROOTLERP.Part1 = Torso
		ROOTLERP.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

		local RIGHTARMLERP = Instance.new("ManualWeld")
		RIGHTARMLERP.Parent = RightArm
		RIGHTARMLERP.Part0 = RightArm
		RIGHTARMLERP.Part1 = Torso
		RIGHTARMLERP.C0 = CFrame.new(-1.5, 0, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

		local LEFTARMLERP = Instance.new("ManualWeld")
		LEFTARMLERP.Parent = LeftArm
		LEFTARMLERP.Part0 = LeftArm
		LEFTARMLERP.Part1 = Torso
		LEFTARMLERP.C0 = CFrame.new(1.5, 0, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

		local RIGHTLEGLERP = Instance.new("ManualWeld")
		RIGHTLEGLERP.Parent = RightLeg
		RIGHTLEGLERP.Part0 = RightLeg
		RIGHTLEGLERP.Part1 = Torso
		RIGHTLEGLERP.C0 = CFrame.new(-0.5, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

		local LEFTLEGLERP = Instance.new("ManualWeld")
		LEFTLEGLERP.Parent = LeftLeg
		LEFTLEGLERP.Part0 = LeftLeg
		LEFTLEGLERP.Part1 = Torso
		LEFTLEGLERP.C0 = CFrame.new(0.5, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

		local function weldBetween(a, b)
			local weld = Instance.new("ManualWeld", a)
			weld.Part0 = a
			weld.Part1 = b
			weld.C0 = a.CFrame:inverse() * b.CFrame
			return weld
		end

		function MAKETRAIL(PARENT,POSITION1,POSITION2,LIFETIME,COLOR)
			A = Instance.new("Attachment", PARENT)
			A.Position = POSITION1
			A.Name = "A"
			B = Instance.new("Attachment", PARENT)
			B.Position = POSITION2
			B.Name = "B"
			tr1 = Instance.new("Trail", PARENT)
			tr1.Attachment0 = A
			tr1.Attachment1 = B
			tr1.Enabled = true
			tr1.Lifetime = LIFETIME
			tr1.TextureMode = "Static"
			tr1.LightInfluence = 0
			tr1.Color = COLOR
			tr1.Transparency = NumberSequence.new(0, 1)
		end
		local function findRemoteEvent(name)
			local replicatedStorage = game:GetService("ReplicatedStorage")
			local workspace = game:GetService("Workspace")
			for _, parent in ipairs({replicatedStorage, workspace}) do
				for _, child in ipairs(parent:GetDescendants()) do
					if child:IsA("RemoteEvent") and child.Name == name then
						return child
					end
				end
			end
			return nil
		end
		local remote = findRemoteEvent("AC6_FE_Sounds")
		if not remote then return end
		remote:FireServer("newSound", "IntroSound", workspace, "rbxassetid://236146895", 1, 2, false)
		remote:FireServer("playSound", "IntroSound")


		fedora = Instance.new("Part",Character)
		fedora.Size = Vector3.new(2,2,2)
		fedora.CFrame = Head.CFrame
		fedora.CanCollide = false
		fedora.Transparency = 1
		fedoraweld = Instance.new("Weld",fedora)
		fedoraweld.Part0 = fedora
		fedoraweld.Part1 = Head
		fedoraweld.C0 = fedora.CFrame:inverse() * Head.CFrame * CFrame.new(0,-.75,0)


		for i,v in pairs(Character:GetChildren()) do
			if v.ClassName == "Shirt" or v.ClassName == "Pants" or v.ClassName == "Hat" or v.ClassName == "CharacterMesh" or v.ClassName == "Shirt Graphic" then
				v:Remove()
			end
		end

		coroutine.wrap(function()
			while wait() do
				hum.WalkSpeed = ws
			end
		end)()
		godmode = coroutine.wrap(function()
			for i,v in pairs(Character:GetChildren()) do
				if v:IsA("BasePart") and v ~= Root then
					v.Anchored = false
				end
			end
		end)
		godmode()

		coroutine.wrap(function()
			for i,v in pairs(Character:GetChildren()) do
				if v.Name == "Animate" then v:Remove()
				end
			end
		end)()

		ArtificialHB = Instance.new("BindableEvent", script)
		ArtificialHB.Name = "Heartbeat"
		script:WaitForChild("Heartbeat")

		frame = 1 / 60
		tf = 0
		allowframeloss = false
		tossremainder = false


		lastframe = tick()
		script.Heartbeat:Fire()


		game:GetService("RunService").Heartbeat:connect(function(s, p)
			tf = tf + s
			if tf >= frame then
				if allowframeloss then
					script.Heartbeat:Fire()
					lastframe = tick()
				else
					for i = 1, math.floor(tf / frame) do
						script.Heartbeat:Fire()
					end
					lastframe = tick()
				end
				if tossremainder then
					tf = 0
				else
					tf = tf - frame * math.floor(tf / frame)
				end
			end
		end)

		function swait(num)
			if num == 0 or num == nil then
				game:service("RunService").Stepped:wait(0)
			else
				for i = 0, num do
					game:service("RunService").Stepped:wait(0)
				end
			end
		end

		for _,n in pairs(Character:GetChildren()) do
			if n:IsA("Accessory") then end
		end
		for _,x in pairs(Character:GetChildren()) do
			if x:IsA("Decal") then x:Remove() end
		end

		intro = true
		ws = 0

		bigfedora = Instance.new("Part",Character)
		bigfedora.Size = Vector3.new(2,2,2)
		bigfedora.CFrame = bigfedora.CFrame:inverse() * Root.CFrame * CFrame.new(math.random(-60,60),-.2,math.random(-60,60)) * CFrame.Angles(0,math.rad(math.random(-180,180)),0)
		bigfedora.CanCollide = false
		bigfedora.Anchored = true
		bigfedora.Transparency = 1
		bigfedora.Name = "mbigf"
		mbigfedora = Instance.new("SpecialMesh", bigfedora)
		mbigfedora.MeshType = "FileMesh"
		mbigfedora.Scale = Vector3.new(6, 7, 7)
		mbigfedora.MeshId,mbigfedora.TextureId = 'http://www.roblox.com/asset/?id=13640868','http://www.roblox.com/asset/?id=18987684'
		for i = 1, 60 do
			bigfedora.CFrame = bigfedora.CFrame:lerp(CFrame.new(Root.Position) * CFrame.new(0,-.1,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.09)
			swait()
		end
		wait(.25)
		for i = 1, 50 do
			bigfedora.CFrame = bigfedora.CFrame:lerp(CFrame.new(fedora.Position),.05)
			swait()
		end
		zmc = 0
		for i = 1, 29 do
			zmc = zmc + 2
			mbigfedora.Scale = mbigfedora.Scale - Vector3.new(.25,.25,.25)
			bigfedora.CFrame = bigfedora.CFrame * CFrame.Angles(math.rad(0),math.rad(zmc),0)
			swait()
		end
		bigfedora:Remove()

		ws = 14

		function SOUND(PARENT,ID,VOL,LOOP,REMOVE)
			so = Instance.new("Sound")
			so.Parent = PARENT
			so.SoundId = "rbxassetid://"..ID
			so.Volume = VOL
			so.Looped = LOOP

			so:Play()
			removeuseless:AddItem(so,REMOVE)
		end

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='k' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 0
					change = .5
					attacking = true
					jam = Instance.new("Sound",Torso)
					jam.SoundId = "rbxassetid://665751753"
					jam.Volume = 8
					jam.Looped = true
					jam.TimePosition = 22.3
					jam:Play()
					lol90 = 0
					coroutine.wrap(function()
						while dancing do
							lol90 = lol90 + 11
							ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(1 * math.sin(sine/10),.1 + .8 * math.sin(sine/3),0) * CFrame.Angles(math.rad(0),math.rad(0 * math.sin(sine/8)),math.rad(8 * math.sin(sine/7))),.25)
							ROOTLERP.C1 = ROOTLERP.C1:lerp(CFrame.new(0 * math.sin(sine/14),0,0) * CFrame.Angles(math.rad(0),math.rad(lol90),0),.25)
							LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.4,1.45,0) * CFrame.Angles(math.rad(180),math.rad(-5 * math.sin(sine/3)),math.rad(-6 * math.sin(sine/3))),0.25)
							RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.4,1.45,0) * CFrame.Angles(math.rad(180),math.rad(5 * math.sin(sine/3)),math.rad(6 * math.sin(sine/3))), 0.25)
							RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3, 2 , 0) * CFrame.Angles(0, math.rad(0), math.rad(-10 + 5 * math.sin(sine/3))), 0.25)
							LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3, 2.0, 0) * CFrame.Angles(0, math.rad(0), math.rad(10 - 5 * math.sin(sine/3))), 0.25)
							swait()
						end
						ws = 14
						jam:Remove()
						ROOTLERP.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
						attacking = false
					end)()
				end
			end
		end)

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='j' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 3
					change = .5
					attacking = true
					g1 = Instance.new("BodyGyro", Root)
					g1.D = 175
					g1.P = 20000
					g1.MaxTorque = Vector3.new(0,9000,0)
					herecomesthemoney = Instance.new("Sound",Torso)
					herecomesthemoney.Pitch = 1
					herecomesthemoney.SoundId = "rbxassetid://2426693638"
					herecomesthemoney.Volume = 8
					herecomesthemoney.Looped = true
					herecomesthemoney:Play()
					robuxpile = Instance.new("Part",Torso)
					robuxpile.Transparency = 1
					robuxpile.Size = Vector3.new(1,1,1)
					robuxpile.CFrame = LeftArm.CFrame
					robuxpile.CanCollide = false
					robuxpileweld = Instance.new("Weld",robuxpile)
					robuxpileweld.Part0 = robuxpile
					robuxpileweld.Part1 = Torso
					robuxpileweld.C0 = robuxpile.CFrame:inverse() * LeftArm.CFrame * CFrame.new(1,-.7,1.4)
					mrobuxpile = Instance.new("SpecialMesh", robuxpile)
					mrobuxpile.MeshType = "FileMesh"
					mrobuxpile.Scale = Vector3.new(0.85, .85, .85)
					mrobuxpile.MeshId,mrobuxpile.TextureId = 'http://www.roblox.com/asset/?id=1285245','http://www.roblox.com/asset/?id=8587344'
					coroutine.wrap(function()
						coroutine.wrap(function()
							while wait(.35) do
								if not dancing then break end
								local robux = Instance.new("Part",Torso)
								robux.CFrame = robuxpile.CFrame * CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
								robux.Anchored = false
								robux.Transparency = 1
								robux.CanCollide = false
								robux.Size = Vector3.new(1,1,1)
								removeuseless:AddItem(robux,4)
								mrobux = Instance.new("SpecialMesh", robux)
								mrobux.MeshType = "FileMesh"
								mrobux.Scale = Vector3.new(1.25, 1.25, 1.25)
								mrobux.MeshId,mrobux.TextureId = 'http://www.roblox.com/asset/?id=667285348','http://www.roblox.com/asset/?id=665939136'
								bov = Instance.new("BodyVelocity",robux)
								bov.maxForce = Vector3.new(99999,99999,99999)
								robux.CFrame = CFrame.new(robux.Position,mouse.Hit.p)
								bov.velocity = robux.CFrame.lookVector*45
								removeuseless:AddItem(bov,.1)
							end
						end)()
						while dancing do
							g1.CFrame = g1.CFrame:lerp(CFrame.new(Root.Position,mouse.Hit.p),.4)
							ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(0,-.3,0) * CFrame.Angles(math.rad(20),math.rad(0 * math.sin(sine/8)),math.rad(0)),.25)
							LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1,.5 + .5 * math.sin(sine/2),.5) * CFrame.Angles(math.rad(-97),math.rad(40 - 20 * math.sin(sine/2)),math.rad(0)), 0.25)
							RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1,.5,.5) * CFrame.Angles(math.rad(-87),math.rad(-20),math.rad(0)), 0.25)
							RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3, 2 , .5) * CFrame.Angles(math.rad(20), math.rad(0), math.rad(-10)), 0.25)
							LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3, 2.0, .5) * CFrame.Angles(math.rad(20), math.rad(0), math.rad(10)), 0.25)
							swait()
						end
						ws = 14
						removeuseless:AddItem(g1,.001)
						robuxpile:Remove()
						attacking = false
					end)()
				end
			end
		end)

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='h' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 0
					change = .5
					attacking = true
					jellyfishjam = Instance.new("Sound",Torso)
					jellyfishjam.SoundId = "rbxassetid://840189092"
					jellyfishjam.Volume = 8
					jellyfishjam.Looped = true
					jellyfishjam.TimePosition = 14.8
					jellyfishjam:Play()
					coroutine.wrap(function()
						while dancing do
							for i = 1, 15 do
								if not dancing then break end
								ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(.5,-.4 + .1 * math.sin(sine/4),0) * CFrame.Angles(math.rad(0),math.rad(20 * math.sin(sine/8)),math.rad(20)),.25)
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(50 + 3 * math.sin(sine/12)),math.rad(3 - 1 * math.sin(sine/12))),.3)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(-50 - 3 * math.sin(sine/12)),math.rad(-3 + 1 * math.sin(sine/12))), .3)
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(0.25, 2.05,-0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-35)), 0.25)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.31, 2.05,-0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(14)), 0.25)
								swait()
							end
							for i = 1, 15 do
								if not dancing then break end
								ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(0,-.1 * math.sin(sine/4),0) * CFrame.Angles(math.rad(0),math.rad(20 * math.sin(sine/8)),math.rad(0)),.25)
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(50 + 3 * math.sin(sine/12)),math.rad(3 - 1 * math.sin(sine/12))),.3)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(-50 - 3 * math.sin(sine/12)),math.rad(-3 + 1 * math.sin(sine/12))), .3)
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.25, .7,1.5) * CFrame.Angles(math.rad(72), math.rad(25), math.rad(-2)), 0.25)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3, 2.0, 0) * CFrame.Angles(0, math.rad(0), math.rad(10)), 0.25)
								swait()
							end
							for i = 1, 15 do
								if not dancing then break end
								ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(-.5,-.4 + .1 * math.sin(sine/4),0) * CFrame.Angles(math.rad(0),math.rad(20 * math.sin(sine/8)),math.rad(-20)),.25)
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(50 + 3 * math.sin(sine/12)),math.rad(3 - 1 * math.sin(sine/12))),.3)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(-50 - 3 * math.sin(sine/12)),math.rad(-3 + 1 * math.sin(sine/12))), .3)
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3, 2 , 0) * CFrame.Angles(0, math.rad(0), math.rad(-10)), 0.25)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(-0.25, 2.05,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(35)), 0.25)
								swait()
							end
							for i = 1, 15 do
								if not dancing then break end
								ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(-.5,-.1,0) * CFrame.Angles(math.rad(0),math.rad(20 * math.sin(sine/8)),math.rad(0)),.25)
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(50 + 3 * math.sin(sine/12)),math.rad(3 - 1 * math.sin(sine/12))),.3)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(-50 - 3 * math.sin(sine/12)),math.rad(-3 + 1 * math.sin(sine/12))), .3)
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.31, 2.05,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-14)), 0.3)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.25, .7,1.5) * CFrame.Angles(math.rad(72), math.rad(-25), math.rad(-2)), 0.25)
								swait()
							end
							swait()
						end
						ws = 14
						attacking = false
					end)()
				end
			end
		end)

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='g' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 0
					change = .5
					attacking = true
					deadmau7 = Instance.new("Sound",Torso)
					deadmau7.SoundId = "rbxassetid://168166611"
					deadmau7.Volume = 8
					deadmau7.Looped = true
					deadmau7:Play()
					coroutine.wrap(function()
						coroutine.wrap(function()
							while dancing do
								ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(2 * math.sin(sine/9),-.4 + .1 * math.sin(sine/3),0) * CFrame.Angles(math.rad(0),math.rad(20 * math.sin(sine/9)),0),.25)
								swait()
							end
						end)()
						while dancing do
							for i = 1, 28 do
								if not dancing then break end
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(50 + 3 * math.sin(sine/12)),math.rad(3 - 1 * math.sin(sine/12))),.2)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.2,1.5,0) * CFrame.Angles(math.rad(180 - 7 * math.sin(sine/3)),math.rad(7 * math.sin(sine/3)),math.rad(7*math.sin(sine/3))), 0.2)
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.5, .7,1) * CFrame.Angles(math.rad(75 - 10 * math.sin(sine/2)), math.rad(0), math.rad(0)), 0.25)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.31, 2.05,-.1) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(-2)), 0.3)
								swait()
							end
							for i = 1, 28 do
								if not dancing then break end
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.9,.65 + .4 * math.sin(sine/12),1.2) * CFrame.Angles(math.rad(-35 - 15 * math.sin(sine/12)),math.rad(50 + 3 * math.sin(sine/12)),math.rad(3 - 1 * math.sin(sine/12))),.2)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.2,1.5,0) * CFrame.Angles(math.rad(180 - 7 * math.sin(sine/3)),math.rad(7 * math.sin(sine/3)),math.rad(7*math.sin(sine/3))), 0.2)
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.31, 2.05,.1) * CFrame.Angles(math.rad(-10), math.rad(0), math.rad(-8)), 0.25)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5, .7,1.1) * CFrame.Angles(math.rad(75 - 10 * math.sin(sine/2)), math.rad(0), math.rad(-2)), 0.25)
								swait()
							end
							swait()
						end
						ws = 14
						deadmau7:Remove()
						attacking = false
					end)()
				end
			end
		end)

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='f' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 6
					change = .5
					attacking = true
					bennyhill = Instance.new("Sound",Torso)
					bennyhill.SoundId = "rbxassetid://138211362"
					bennyhill.Volume = 8
					bennyhill.Looped = true
					bennyhill:Play()
					coroutine.wrap(function()
						while dancing do
							ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(0,-.4,0) * CFrame.Angles(math.rad(20 + 5 * math.sin(sine/2)),math.rad(10 * math.sin(sine/4)),0),.25)
							RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,.89 - .4 * -math.sin(sine/2),.49) * CFrame.Angles(math.rad(-70 + 20 * -math.sin(sine/2)),0,math.rad(0)),.25)
							LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,.89 - .4 * math.sin(sine/2),.49) * CFrame.Angles(math.rad(-70  + 20 * math.sin(sine/2)),0,math.rad(0)),.25)
							RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.33, 2, -.2 + .3 * math.sin(sine/2)) * CFrame.Angles(math.rad(-20 - 20 * -math.sin(sine/2)), math.rad(0), math.rad(-8)), 0.25)
							LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.33, 2.0,-.2 - .3 * math.sin(sine/2)) * CFrame.Angles(math.rad(-20 - 20 * math.sin(sine/2)), math.rad(0), math.rad(8)), 0.25)
							swait()
						end
						ws = 14
						bennyhill:Remove()
						attacking = false
					end)()
				end
			end
		end)

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='p' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 0
					change = .5
					attacking = true
					barrelspin = 0
					barrelrollsound = Instance.new("Sound",Torso)
					barrelrollsound.SoundId = "rbxassetid://505320170"
					barrelrollsound.Volume = 8
					barrelrollsound.Looped = true
					barrelrollsound:Play()
					barrol = Instance.new("Part",Torso)
					barrol.Transparency = 1
					barrol.Size = Vector3.new(1,1,1)
					barrol.CFrame = Torso.CFrame
					barrol.CanCollide = false
					barrolweld = Instance.new("Weld",barrol)
					barrolweld.Part0 = barrol
					barrolweld.Part1 = Torso
					barrolweld.C0 = barrol.CFrame:inverse() * Torso.CFrame * CFrame.new(0,0,0)
					mbarrol = Instance.new("SpecialMesh", barrol)
					mbarrol.MeshType = "FileMesh"
					mbarrol.Scale = Vector3.new(1.05, .95, 1.05)
					mbarrol.MeshId,mbarrol.TextureId = 'http://www.roblox.com/asset/?id=29873142','http://www.roblox.com/asset/?id=31082268'
					coroutine.wrap(function()
						while dancing do
							ROOTLERP.C0 = ROOTLERP.C0:Lerp(CFrame.new(5 * math.sin(sine/8),-1.8,0) * CFrame.Angles(math.rad(-90),math.rad(180 * math.sin(sine/8)),0),.25)
							RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,1.5,0) * CFrame.Angles(math.rad(180),0,math.rad(0)),.25)
							LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,1.5,0) * CFrame.Angles(math.rad(180),0,math.rad(0)),.25)
							LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(.5,2,0) * CFrame.Angles(0,0,0),.25)
							RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-.5,2,0) * CFrame.Angles(0,0,0),.25)
							swait()
						end
						ws = 14
						barrol:Remove()
						attacking = false
					end)()
				end
			end
		end)

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='q' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 0
					change = .5
					spinningmove = 0
					dbwouldlovethis = Instance.new("Sound",Torso)
					dbwouldlovethis.SoundId = "rbxassetid://1532157598"
					dbwouldlovethis.Volume = 8
					dbwouldlovethis.Looped = true
					dbwouldlovethis:Play()
					attacking = true
					coroutine.wrap(function()
						while dancing do
							spinningmove = spinningmove + 10
							RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.52, 1.9, -.35) * CFrame.Angles(math.rad(-30), math.rad(0), math.rad(0)),.2)
							LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.52, 1.9, .35) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)),.2)
							ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(.2 * math.sin(sine/3), -.52, .2 * math.sin(sine/4)) * CFrame.Angles(math.rad(180),math.rad(spinningmove),math.rad(15 * math.sin(sine/9))),.2)
							LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.4,1.45,0) * CFrame.Angles(math.rad(180),math.rad(-1),math.rad(-3 * math.sin(sine/2))),0.3)
							RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.4,1.45,0) * CFrame.Angles(math.rad(180),math.rad(1),math.rad(3 * math.sin(sine/2))), 0.3)
							swait()
						end
						ws = 14
						dbwouldlovethis:Remove()
						attacking = false
					end)()
				end
			end
		end)


		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='u' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 6
					change = .5
					attacking = true
					slavdance = Instance.new("Sound",Torso)
					slavdance.SoundId = "rbxassetid://2341226836"
					slavdance.Volume = 6
					slavdance.Looped = true
					slavdance:Play()
					coroutine.wrap(function()
						while dancing do
							for i = 1, 17 do
								if not dancing then break end
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.52, 1.5, -.5) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0)),.2)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.52, 1.2, .55) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)),.2)
								ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.8 + .1 * math.sin(sine/3), 0) * CFrame.Angles(math.rad(22 - 2 * math.sin(sine/3)),math.rad(0),math.rad(0)),.2)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1,-.2,.4) * CFrame.Angles(math.rad(-87 + .01 * math.sin(sine/9)),math.rad(80 - 3 * math.sin(sine/9)),math.rad(0)), 0.3)
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.7,-.2,.4) * CFrame.Angles(math.rad(-87 - .01 * math.sin(sine/9)),math.rad(-88 + .7 * math.sin(sine/9)),math.rad(0)), 0.3)
								swait()
							end
							for i = 1, 17 do
								if not dancing then break end
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.52, 1.2, .55) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)),.2)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.52, 1.5, -.5) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0)),.2)
								ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.8 + .1 * math.sin(sine/3), 0) * CFrame.Angles(math.rad(22 - 2 * math.sin(sine/3)),math.rad(0),math.rad(0)),.2)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1,-.2,.4) * CFrame.Angles(math.rad(-87 + .01 * math.sin(sine/9)),math.rad(80 - 3 * math.sin(sine/9)),math.rad(0)), 0.3)
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.7,-.2,.4) * CFrame.Angles(math.rad(-87 - .01 * math.sin(sine/9)),math.rad(-88 + .7 * math.sin(sine/9)),math.rad(0)), 0.3)
								swait()
							end
							swait()
						end
						ws = 14
						slavdance:Remove()
						attacking = false
					end)()
				end
			end
		end)

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='y' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 0
					change = .5
					walkforward = 0
					walkrotation = 0
					attacking = true
					truelegend = Instance.new("Sound",Torso)
					truelegend.SoundId = "rbxassetid://487872908"
					truelegend.TimePosition = 13.98
					truelegend.Volume = 8
					truelegend.Looped = true
					truelegend:Play()
					coroutine.wrap(function()
						while dancing do
							for i = 1, 100 do
								if not dancing then break end
								walkforward = walkforward + .1
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.31, 2.05 , .1 * math.sin(sine/4)) * CFrame.Angles(math.rad(10 * math.sin(sine/4)), math.rad(0), math.rad(-8)), 0.3)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.31, 2.05, -.15 * math.sin(sine/4)) * CFrame.Angles(math.rad(-10 * math.sin(sine/4)), math.rad(0), math.rad(8)), 0.3)
								ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2, walkforward) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.2)
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,0,0) * CFrame.Angles(0,0,math.rad(0)),.3)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,0,0) * CFrame.Angles(0,0,math.rad(0)),.3)
								swait()
							end
							for i = 1, 50 do
								if not dancing then break end
								walkrotation = walkrotation + 15
								ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2, walkforward) * CFrame.Angles(math.rad(0),math.rad(walkrotation),math.rad(-0)),.2)
								swait()
							end
							walkrotation = 0
							for i = 1, 100 do
								if not dancing then break end
								walkforward = walkforward - .1
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.31, 2 , .1 * math.sin(sine/4)) * CFrame.Angles(math.rad(10 * math.sin(sine/4)), math.rad(0), math.rad(-8)), 0.3)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.31, 2, -.15 * math.sin(sine/4)) * CFrame.Angles(math.rad(-10 * math.sin(sine/4)), math.rad(0), math.rad(8)), 0.3)
								ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2, walkforward) * CFrame.Angles(math.rad(0),math.rad(-180),math.rad(-0)),.2)
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.3,.7,.2) * CFrame.Angles(math.rad(220),math.rad(0),math.rad(-30)), 0.4)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,0,0) * CFrame.Angles(0,0,math.rad(0)),.3)
								swait()
							end
							for i = 1, 50 do
								if not dancing then break end
								walkrotation = walkrotation + 15
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,0,0) * CFrame.Angles(0,0,math.rad(0)),.1)
								ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2, walkforward) * CFrame.Angles(math.rad(0),math.rad(walkrotation),math.rad(-0)),.2)
								swait()
							end
							walkrotation = 0
							swait()
						end
						ws = 14
						truelegend:Remove()
						attacking = false
					end)()
				end
			end
		end)

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='t' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 0
					change = .5
					attacking = true
					plummusic = Instance.new("Sound",Torso)
					plummusic.Volume = 8
					plummusic.Looped = true
					plummusic.SoundId = "rbxassetid://2526093213"
					plummusic:Play()
					coroutine.wrap(function()
						while dancing do
							for i = 1, 20 do
								if not dancing then break end
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.33, 2 , .05) * CFrame.Angles(math.rad(3), math.rad(0), math.rad(-8)), 0.2)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.33, 2.0, -.05) * CFrame.Angles(math.rad(-3), math.rad(0), math.rad(8)), 0.2)
								ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2, 0) * CFrame.Angles(math.rad(0),math.rad(0*math.sin(sine/4)),math.rad(15)),.2)
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(.5,1.98,.05) * CFrame.Angles(0,0,math.rad(-140)),.2)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1,1.3,.05) * CFrame.Angles(0,0,math.rad(50)),.2)
								swait()
							end
							for i = 1, 20 do
								if not dancing then break end
								RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.33, 2, .05) * CFrame.Angles(math.rad(3), math.rad(0), math.rad(-8)), 0.2)
								LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.33, 2.0, -.05) * CFrame.Angles(math.rad(-3), math.rad(0), math.rad(8)), 0.2)
								ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2, 0) * CFrame.Angles(math.rad(0),math.rad(0*math.sin(sine/4)),math.rad(-15)),.2)
								RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1,1.4,.05) * CFrame.Angles(0,0,math.rad(-50)),.2)
								LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(-.6,2,.05) * CFrame.Angles(0,0,math.rad(140)),.2)
								swait()
							end
							swait()
						end
						ws = 14
						plummusic:Remove()
						attacking = false
					end)()
				end
			end
		end)

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='e' then
				if dancing then
					dancing = false
				else
					dancing = true
					ws = 0
					change = .5
					attacking = true
					mrozo = Instance.new("Sound",Torso)
					mrozo.Volume = 8
					mrozo.SoundId = "rbxassetid://335701357"
					mrozo.Looped = true
					mrozo.TimePosition = 10
					mrozo:Play()
					coroutine.wrap(function()
						while dancing do
							RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3, 2 , 0) * CFrame.Angles(0, math.rad(0), math.rad(-10)), 0.1)
							LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3, 2.0, 0) * CFrame.Angles(0, math.rad(0), math.rad(10)), 0.1)
							ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2, 0) * CFrame.Angles(math.rad(0),math.rad(0*math.sin(sine/4)),math.rad(15*math.sin(sine/4))),.2)
							RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.3 + .3 * math.sin(sine/3.5),.5 * -math.sin(sine/3.5),.1) * CFrame.Angles(math.rad(0 * math.sin(sine/2)),0,math.rad(30 * math.sin(sine/3.5))),.2)
							LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.3 + .3 * math.sin(sine/3.5),.5 * math.sin(sine/3.5),.1) * CFrame.Angles(math.rad(0 * math.sin(sine/2)),0,math.rad(30 * math.sin(sine/3.5))),.2)
							swait()
						end
						mrozo:Remove()
						ws = 14
						attacking = false
					end)()
				end
			end
		end)

		mouse.KeyDown:connect(function(Press)
			Press=Press:lower()
			if Press=='r' then
				if dancing then
					dancing = false
				else
					ws = 6
					recordbaby = 0
					dancing = true
					change = .5
					attacking = true
					spinme = Instance.new("Sound",Torso)
					spinme.Volume = 8
					spinme.SoundId = "rbxassetid://145799973"
					spinme.Looped = true
					spinme:Play()
					coroutine.wrap(function()
						while dancing do
							recordbaby = recordbaby + 10
							RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.27, 2 , .1 * math.sin(sine/4)) * CFrame.Angles(math.rad(10 * math.sin(sine/4)), math.rad(0), math.rad(-8)), 0.3)
							LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.27, 2.0, -.1 * math.sin(sine/4)) * CFrame.Angles(math.rad(-10 * math.sin(sine/4)), math.rad(0), math.rad(8)), 0.3)
							ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(.5 * math.sin(sine/5), -.2, .5 * math.sin(sine/4)) * CFrame.Angles(math.rad(0),math.rad(recordbaby),math.rad(0)),.3)
							RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-.5,1.98,0) * CFrame.Angles(0,0,math.rad(-90)),.3)
							LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(.5,1.98,0) * CFrame.Angles(0,0,math.rad(90)),.3)
							swait()
						end
						spinme:Remove()
						ws = 14
						attacking = false
					end)()
				end
			end
		end)

		function ray(pos, dir, rang, ignoredesc)
			return workspace:FindPartOnRay(Ray.new(pos, dir.unit * rang), ignoredesc)
		end

		function ray2(startpos, endpos, distance, ignore)
			local dir = CFrame.new(startpos,endpos).lookVector
			return ray(startpos, dir, distance, ignore)
		end

		checks1 = coroutine.wrap(function() -------Checks
			while true do
				hf = ray(Root.Position,(CFrame.new(Root.Position,Root.Position+Vector3.new(0,-1,0))).lookVector,3*3,Character)
				if Root.Velocity.y > 1 then
					position = "Jump"
				elseif Root.Velocity.y < -1 then
					position = "Falling"
				elseif Root.Velocity.Magnitude < 2 then
					position = "Idle"
				elseif Root.Velocity.Magnitude > 2 then
					position = "Walking"
				elseif Root.Velocity.Magnitude > 20 then
					position = "Running"
				else
				end
				wait()
			end
		end)
		checks1()

		function ray(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
			return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
		end

		function ray2(StartPos, EndPos, Distance, Ignore)
			local DIRECTION = CFrame.new(StartPos,EndPos).lookVector
			return ray(StartPos, DIRECTION, Distance, Ignore)
		end

		OrgnC0 = Neck.C0
		local movelimbs = coroutine.wrap(function()
			while RunSrv.RenderStepped:wait() do
				TrsoLV = Torso.CFrame.lookVector
				Dist = nil
				Diff = nil
				if not MseGuide then
					print("Failed to recognize")
				else
					local _, Point = Workspace:FindPartOnRay(Ray.new(Head.CFrame.p, mouse.Hit.lookVector), Workspace, false, true)
					Dist = (Head.CFrame.p-Point).magnitude
					Diff = Head.CFrame.Y-Point.Y
					local _, Point2 = Workspace:FindPartOnRay(Ray.new(LeftArm.CFrame.p, mouse.Hit.lookVector), Workspace, false, true)
					Dist2 = (LeftArm.CFrame.p-Point).magnitude
					Diff2 = LeftArm.CFrame.Y-Point.Y
					HEADLERP.C0 = CFrame.new(0, -1.5, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
					Neck.C0 = Neck.C0:lerp(OrgnC0*CFrame.Angles((math.tan(Diff/Dist)*1), 0, (((Head.CFrame.p-Point).Unit):Cross(Torso.CFrame.lookVector)).Y*1), .1)
				end
			end
		end)
		movelimbs()
		immortal = {}
		for i,v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") and v.Name ~= "lmagic" and v.Name ~= "rmagic" then
				if v ~= Root and v ~= Torso and v ~= Head and v ~= RightArm and v ~= LeftArm and v ~= RightLeg and v.Name ~= "lmagic" and v.Name ~= "rmagic" and v ~= LeftLeg then
					v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
				end
				table.insert(immortal,{v,v.Parent,v.Material,v.Color,v.Transparency})
			elseif v:IsA("JointInstance") then
				table.insert(immortal,{v,v.Parent,nil,nil,nil})
			end
		end
		for e = 1, #immortal do
			if immortal[e] ~= nil then
				local STUFF = immortal[e]
				local PART = STUFF[1]
				local PARENT = STUFF[2]
				local MATERIAL = STUFF[3]
				local COLOR = STUFF[4]
				local TRANSPARENCY = STUFF[5]
				if levitate then
					if PART.ClassName == "Part" and PART ~= Root and PART.Name ~= eyo1 and PART.Name ~= eyo2 and PART.Name ~= "lmagic" and PART.Name ~= "rmagic" then
						PART.Material = MATERIAL
						PART.Color = COLOR
						--PART.Transparency = TRANSPARENCY
					end
					PART.AncestryChanged:connect(function()
						PART.Parent = PARENT
					end)
				else
					if PART.ClassName == "Part" and PART ~= Root and PART.Name ~= "lmagic" and PART.Name ~= "rmagic" then
						PART.Material = MATERIAL
						PART.Color = COLOR
						--PART.Transparency = TRANSPARENCY
					end
					PART.AncestryChanged:connect(function()
						PART.Parent = PARENT
					end)
				end
			end
		end
		function immortality()
			for e = 1, #immortal do
				if immortal[e] ~= nil then
					local STUFF = immortal[e]
					local PART = STUFF[1]
					local PARENT = STUFF[2]
					local MATERIAL = STUFF[3]
					local COLOR = STUFF[4]
					local TRANSPARENCY = STUFF[5]
					if PART.ClassName == "Part" and PART == Root then
						PART.Material = MATERIAL
						PART.Color = COLOR
						--PART.Transparency = TRANSPARENCY
					end
					if PART.Parent ~= PARENT then
						hum:Remove()
						PART.Parent = PARENT
						hum = Instance.new("Humanoid",Character)
					end
				end
			end
		end

		local anims = coroutine.wrap(function()
			while true do
				settime = 0.05
				sine = sine + change
				if position == "Jump" and attacking == false then
					change = 1
					spin = false
					for i,v in pairs(Torso:GetChildren()) do if v:IsA("Sound") then v:Remove() end end
					LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.1)
					RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),0,0),.1)
					LEFTARMLERP.C1 = LEFTARMLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.4)
					ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
					LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.4,.1,-.2) * CFrame.Angles(math.rad(20),math.rad(-3),math.rad(-4)), 0.2)
					RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.5, 2, 0) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(0)), 0.2)
					LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5, 1.0, .9) * CFrame.Angles(math.rad(20), math.rad(0), math.rad(0)), 0.2)
				elseif position == "Falling" and attacking == false then
					change = 1
					spin = false
					for i,v in pairs(Torso:GetChildren()) do if v:IsA("Sound") then v:Remove() end end
					ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(0)), 0.15)
					LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.1)
					RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),0,0),.1)
					LEFTARMLERP.C1 = LEFTARMLERP.C1:lerp(CFrame.new(0,0,0) * CFrame.Angles(0,0,0),.4)
					RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.5, 2, 0) * CFrame.Angles(math.rad(8), math.rad(4), math.rad(0)), 0.2)
					LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5, 2, 0) * CFrame.Angles(math.rad(8), math.rad(-4), math.rad(0)), 0.2)
					LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,.94 + .02 * math.sin(sine/12),-0) * CFrame.Angles(math.rad(28 + 5 * math.sin(sine/12)),math.rad(0),math.rad(45)), 0.2)
					RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,.94 + .02 * math.sin(sine/12),-0) * CFrame.Angles(math.rad(28 + 5 * math.sin(sine/12)),math.rad(0),math.rad(-45)), 0.2)
				elseif position == "Walking" and attacking == false and running == false then
					change = 1.2
					walking = true
					spin = false
					for i,v in pairs(Torso:GetChildren()) do if v:IsA("Sound") then v:Remove() end end
					RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5 + Root.RotVelocity.Y / 85,.35,-.5*math.sin(sine/11)) * CFrame.Angles(math.rad(35*math.sin(sine/11)),math.rad(0*math.sin(sine/11)),math.rad(-10 + Root.RotVelocity.Y / 10, math.sin(-20 * math.sin(sine/4)))),.3)
					LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5 + Root.RotVelocity.Y / 85,.45,.5*math.sin(sine/11)) * CFrame.Angles(math.rad(-55*math.sin(sine/11)),math.rad(-5*math.sin(sine/8)),math.rad(10 + Root.RotVelocity.Y / 10, math.sin(20 * math.sin(sine/4)))),.3)
					ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.15 * 0.6*-math.sin(sine/5.5), 0) * CFrame.Angles(math.rad(10), math.rad(12 * -math.sin(sine/11)), math.rad(0) + Root.RotVelocity.Y / 30, math.cos(25 * math.cos(sine/10))), 0.3)
					RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.5, 1.92 - 0.35 * math.cos(sine/11)/2.8, -.2  + 0.2 - math.sin(sine/11)/3.4) * CFrame.Angles(math.rad(25 - 25) + -math.sin(sine/11)/2.3, math.rad(0)*math.cos(sine/1), math.rad(0), math.cos(-15 * 25 * math.cos(sine/11))), 0.3)
					LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5, 1.92 + 0.35 * math.cos(sine/11)/2.8, -.2 + 0.2 + math.sin(sine/11)/3.4) * CFrame.Angles(math.rad(25 - 25) - -math.sin(sine/11)/2.3, math.rad(0)*math.cos(sine/1), math.rad(0) , math.cos(-15 * 25 * math.cos(sine/11))), 0.3)
				elseif position == "Idle" and attacking == false and running == false then
					change = .5
					spin = true
					for i,v in pairs(Torso:GetChildren()) do if v:IsA("Sound") then v:Remove() end end
					ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2 + -.1 * math.sin(sine/12), 0) * CFrame.Angles(math.rad(6 * -math.sin(sine/12)),math.rad(0),math.rad(0)),.1)
					LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,.27 + .02 * math.sin(sine/12),.20 * -math.sin(sine/12)) * CFrame.Angles(math.rad(20 * math.sin(sine/12)),math.rad(0),math.rad(10)), 0.1)
					RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,.27 + .02 * math.sin(sine/12),.20 * -math.sin(sine/12)) * CFrame.Angles(math.rad(20 * math.sin(sine/12)),math.rad(0),math.rad(-10)), 0.1)
					RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3, 2 - .1 * math.sin(sine/12), 0) * CFrame.Angles(math.rad(6 * -math.sin(sine/12)), math.rad(0), math.rad(-10)), 0.1)
					LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3, 2.0 - .1 * math.sin(sine/12), 0) * CFrame.Angles(math.rad(6 * -math.sin(sine/12)), math.rad(0), math.rad(10)), 0.1)
				elseif position == "Running" and attacking == false then
					change = 1
					for i,v in pairs(Torso:GetChildren()) do if v:IsA("Sound") then v:Remove() end end
					RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(0, .5, 0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), 0.3)
					LEFTARMLERP.C1 = LEFTARMLERP.C1:lerp(CFrame.new(-1.24+.6*math.sin(sine/4)/1.4, 0.54, 0-0.8*math.sin(sine/4))*CFrame.Angles(math.rad(6+140*math.sin(sine/4)/1.2), math.rad(0), math.rad(20+70*math.sin(sine/4))), 0.3)
					LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(0,.5,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.3)
					ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.2, 0) * CFrame.Angles(math.rad(-20 - 0 * math.sin(sine/4)), math.rad(0 + 6 * math.sin(sine/4)), math.rad(0) + Root.RotVelocity.Y / 30, math.sin(10 * math.sin(sine/4))), 0.3)
					RIGHTLEGLERP.C1 = RIGHTLEGLERP.C1:lerp(CFrame.new(0,0,-.2 + .5*-math.sin(sine/4)),.3)
					RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.5, 1.6+0.1*math.sin(sine/4),.7*-math.sin(sine/4)) * CFrame.Angles(math.rad(15+ -50 * math.sin(sine/4)),0,0),.3)
					LEFTLEGLERP.C1 = LEFTLEGLERP.C1:lerp(CFrame.new(0,0,-.2 + .5*math.sin(sine/4)),.3)
					LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5, 1.6-0.1*math.sin(sine/4),.7*math.sin(sine/4)) * CFrame.Angles(math.rad(15 + 50 * math.sin(sine/4)),0,0),.3)
				end
				swait()
			end
		end)
		anims()
	elseif isCmd(cmd, {"john"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		local function breakJoints(instance)
			for i,v in pairs(instance:GetDescendants()) do
				if not (v:IsA("Weld") or v:IsA("WeldConstraint") or v:IsA("JointInstance")) then continue end
				delete(v)
			end
		end

		------------
		--John Doe--
		------------
		-----by-----
		--CKbackup--
		------------

		--Player Stuff--
		player = Player
		chara = player.Character

		ch = chara:GetChildren()
		for i = 1, #ch do
			if ch[i].Name == "Torso" then
				ch[i].roblox.Transparency = 1
			elseif ch[i].Name == "Head" then
				ch[i].face.Transparency = 1
				ch[i].Transparency = 1
			elseif ch[i].ClassName == "Accessory" or ch[i].ClassName == "Shirt" or ch[i].ClassName == "Pants" or ch[i].ClassName == "ShirtGraphic" then
				ch[i]:Destroy()
			end
		end

		chara["Left Arm"].BrickColor = BrickColor.new("Cool yellow")
		chara["Right Arm"].BrickColor = BrickColor.new("Cool yellow")
		chara["Left Leg"].BrickColor = BrickColor.new("Medium blue")
		chara["Right Leg"].BrickColor = BrickColor.new("Medium blue")
		chara.Torso.BrickColor = BrickColor.new("Bright yellow")

		--Outfit--
		New = function(Object, Parent, Name, Data)
			local Object = Instance.new(Object)
			for Index, Value in pairs(Data or {}) do
				Object[Index] = Value
			end
			Object.Parent = Parent
			Object.Name = Name
			return Object
		end

		function ScatterEff(part)
			local eff1 = Instance.new("ParticleEmitter",part)
			eff1.Size = NumberSequence.new(.1)
			eff1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.9,0),NumberSequenceKeypoint.new(1,1)})
			eff1.LightEmission = 1
			eff1.Lifetime = NumberRange.new(1)
			eff1.Speed = NumberRange.new(1)
			eff1.Rate = 100
			eff1.VelocitySpread = 10000
			eff1.Texture = "rbxassetid://347504241"
			eff1.Color = ColorSequence.new(Color3.new(1,0,0))
			local eff2 = Instance.new("ParticleEmitter",part)
			eff2.Size = NumberSequence.new(.1)
			eff2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.9,0),NumberSequenceKeypoint.new(1,1)})
			eff2.LightEmission = 1
			eff2.Lifetime = NumberRange.new(1)
			eff2.Speed = NumberRange.new(1)
			eff2.Rate = 100
			eff2.VelocitySpread = 10000
			eff2.Texture = "rbxassetid://347504259"
			eff2.Color = ColorSequence.new(Color3.new(1,0,0))
		end

		function BurningEff(part)
			local eff1 = Instance.new("ParticleEmitter",part)
			eff1.Size = NumberSequence.new(.1)
			eff1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.2,0),NumberSequenceKeypoint.new(1,1)})
			eff1.LightEmission = 1
			eff1.Lifetime = NumberRange.new(1)
			eff1.Speed = NumberRange.new(0)
			eff1.Rate = 100
			eff1.Texture = "rbxassetid://347504241"
			eff1.Acceleration = Vector3.new(0,10,0)
			eff1.Color = ColorSequence.new(Color3.new(1,0,0))
			local eff2 = Instance.new("ParticleEmitter",part)
			eff2.Size = NumberSequence.new(.1)
			eff2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.2,0),NumberSequenceKeypoint.new(1,1)})
			eff2.LightEmission = 1
			eff2.Lifetime = NumberRange.new(1)
			eff2.Speed = NumberRange.new(0)
			eff2.Rate = 100
			eff2.Texture = "rbxassetid://347504259"
			eff2.Acceleration = Vector3.new(0,10,0)
			eff2.Color = ColorSequence.new(Color3.new(1,0,0))
			local eff3 = Instance.new("ParticleEmitter",part)
			eff3.Size = NumberSequence.new(1)
			eff3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})
			eff3.LightEmission = 1
			eff3.Lifetime = NumberRange.new(1)
			eff3.Speed = NumberRange.new(0)
			eff3.Rate = 100
			eff3.Texture = "rbxasset://textures/particles/fire_main.dds"
			eff3.Acceleration = Vector3.new(0,10,0)
			eff3.Color = ColorSequence.new(Color3.new(1,0,0))
		end

		FakeHead = New("Model",chara,"FakeHead",{})
		MainPart = New("Part",FakeHead,"MainPart",{FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(2, 1, 1),CFrame = CFrame.new(2.29537678, 7.81603718, 0.746068954, 0.00980896503, 0.00110200304, 0.999957919, -0.000536994543, 1.00000548, -0.00109680078, -0.99994874, -0.0005262224, 0.00980964955),CanCollide = false,TopSurface = Enum.SurfaceType.Smooth,})
		Mesh = New("SpecialMesh",MainPart,"Mesh",{Scale = Vector3.new(1.25, 1.25, 1.25),})
		face = New("Decal",MainPart,"face",{Texture = "rbxasset://textures/face.png",})
		Weld = New("ManualWeld",MainPart,"Weld",{Part0 = MainPart,Part1 = chara.Head,C0 = CFrame.new(0, 0, 0, 0.00980896503, -0.000536994543, -0.99994874, 0.00110200304, 1.00000548, -0.0005262224, 0.999957919, -0.00109680078, 0.00980964955),C1 = CFrame.new(5.96046448e-008, -8.58306885e-006, 0, 0.00980896503, -0.000536994543, -0.99994874, 0.00110200304, 1.00000548, -0.0005262224, 0.999957919, -0.00109680078, 0.00980964955),})
		FakeHead.MainPart.BrickColor = BrickColor.new("Cool yellow")
		EyeFire = New("Part",FakeHead,"EyeFire",{BrickColor = BrickColor.new("Really red"),Material = Enum.Material.Neon,Size = Vector3.new(0.400000006, 0.200000003, 0.200000003),CFrame = CFrame.new(1.69668579, 8.11665249, 0.640022159, -0.00107900088, 0.999958038, -0.00980941113, -1.0000056, -0.00107390946, 0.000525554642, 0.000515007298, 0.00981007144, 0.999948859),CanCollide = false,Color = Color3.new(1, 0, 0),})
		Mesh = New("CylinderMesh",EyeFire,"Mesh",{Offset = Vector3.new(0.0500000007, 0, -0.0399999991),Scale = Vector3.new(1, 0.150000006, 1),})
		Weld = New("ManualWeld",EyeFire,"Weld",{Part0 = EyeFire,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.0010790003, -0.999999344, 0.000515000196, 0.999951363, -0.0010738963, 0.00981000345, -0.00980944186, 0.000525560055, 0.99995178),C1 = CFrame.new(0.100008011, 0.300009251, -0.600027919, 0.00980899762, -0.000536999898, -0.99995178, 0.00110200245, 0.999999344, -0.000526215415, 0.999951363, -0.00109678751, 0.00980958249),})
		Chest = New("Model",chara,"Chest",{})
		MainPart = New("Part",Chest,"MainPart",{Transparency = 1,Transparency = 1,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(2, 2, 1),CFrame = CFrame.new(2.2937007, 6.31611967, 0.746871948, 0.00980956201, 0.00110224239, 0.999954581, -0.000537135813, 1.00000238, -0.00109703222, -0.99995023, -0.000526354474, 0.00981019717),CanCollide = false,LeftSurface = Enum.SurfaceType.Weld,RightSurface = Enum.SurfaceType.Weld,})
		Weld = New("ManualWeld",MainPart,"Weld",{Part0 = MainPart,Part1 = chara.Torso,C0 = CFrame.new(0, 0, 0, 0.009809535, -0.000537137908, -0.99994725, 0.00110225554, 1.00000858, -0.000526368851, 0.999961257, -0.00109705783, 0.00981026888),C1 = CFrame.new(5.96046448e-008, -9.05990601e-006, -2.38418579e-007, 0.00980956666, -0.000537143264, -0.99995023, 0.00110225484, 1.00000238, -0.000526361808, 0.999954581, -0.00109704456, 0.00981020182),})
		CorruptedPart = New("Part",Chest,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.400000006, 0.800000072, 1),CFrame = CFrame.new(2.28977966, 7.11656427, 1.34486222, -0.00110228383, -0.00980954897, -0.9999578, -1.00000536, 0.000536905834, 0.00109708123, 0.000526248943, 0.99994868, -0.00981033035),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.0011022957, -0.999999225, 0.000526249292, -0.00980958622, 0.000536918582, 0.99995172, -0.999951243, 0.0010970803, -0.00981026702),C1 = CFrame.new(-0.598430753, 0.800122261, 0.00106739998, 0.00980956666, -0.000537143264, -0.99995023, 0.00110225484, 1.00000238, -0.000526361808, 0.999954581, -0.00109704456, 0.00981020182),})
		CorruptedPart = New("Part",Chest,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.400000006, 0.400000066, 1),CFrame = CFrame.new(2.29174757, 6.71645212, 1.54485857, -0.00110228383, -0.00980954897, -0.9999578, -1.00000536, 0.000536905834, 0.00109708123, 0.000526248943, 0.99994868, -0.00981033035),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.0011022957, -0.999999225, 0.000526249292, -0.00980958622, 0.000536918582, 0.99995172, -0.999951243, 0.0010970803, -0.00981026702),C1 = CFrame.new(-0.798183441, 0.399908543, 0.00543618202, 0.00980956666, -0.000537143264, -0.99995023, 0.00110225484, 1.00000238, -0.000526361808, 0.999954581, -0.00109704456, 0.00981020182),})
		LeftArm = New("Model",chara,"LeftArm",{})
		MainPart = New("Part",LeftArm,"MainPart",{Transparency = 1,Transparency = 1,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(1, 2, 1),CFrame = CFrame.new(1.90889204, 6.31596565, 3.24640989, -0.0484240092, -0.0324009918, 0.998301268, -0.00117100019, 0.999474883, 0.0323822871, -0.998826265, 0.000399069104, -0.0484365262),CanCollide = false,})
		Weld = New("ManualWeld",MainPart,"Weld",{Part0 = MainPart,Part1 = chara["Left Arm"],C0 = CFrame.new(0, 0, 0, -0.0484240092, -0.00117100019, -0.998826265, -0.0324009918, 0.999474883, 0.000399069104, 0.998301268, 0.0323822871, -0.0484365262),C1 = CFrame.new(0, -8.10623169e-006, -2.38418579e-007, -0.0484240092, -0.00117100019, -0.998826265, -0.0324009918, 0.999474883, 0.000399069104, 0.998301268, 0.0323822871, -0.0484365262),})
		CorruptedPart = New("Part",LeftArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.400000006, 0.200000003),CFrame = CFrame.new(1.48370504, 6.50245714, 2.8663168, -0.048417028, -0.0324150361, 0.998301387, -0.00116700074, 0.999474525, 0.03239654, -0.998826742, 0.000403525919, -0.0484294258),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.048417028, -0.00116700074, -0.998826623, -0.0324150361, 0.999474466, 0.000403525832, 0.998301208, 0.0323965363, -0.0484294109),C1 = CFrame.new(0.400017738, 0.200018406, -0.400015235, -0.0484240092, -0.00117100019, -0.998826265, -0.0324009918, 0.999474883, 0.000399069104, 0.998301268, 0.0323822871, -0.0484365262),})
		CorruptedPart = New("Part",LeftArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.600000024, 0.200000003),CFrame = CFrame.new(1.51924801, 6.60332775, 3.66543078, -0.048417028, -0.0324150361, 0.998301387, -0.00116700074, 0.999474525, 0.03239654, -0.998826742, 0.000403525919, -0.0484294258),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.048417028, -0.00116700074, -0.998826623, -0.0324150361, 0.999474466, 0.000403525832, 0.998301208, 0.0323965363, -0.0484294109),C1 = CFrame.new(-0.399997473, 0.300003052, -0.399972558, -0.0484240092, -0.00117100019, -0.998826265, -0.0324009918, 0.999474883, 0.000399069104, 0.998301268, 0.0323822871, -0.0484365262),})
		EffCorruptedPart = New("Part",LeftArm,"EffCorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(1, 1, 1),CFrame = CFrame.new(1.92512023, 5.81624889, 3.24619365, -0.048417028, -0.0324150361, 0.998301387, -0.00116700074, 0.999474525, 0.03239654, -0.998826742, 0.000403525919, -0.0484294258),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",EffCorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",EffCorruptedPart,"Weld",{Part0 = EffCorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.048417028, -0.00116700074, -0.998826623, -0.0324150361, 0.999474466, 0.000403525832, 0.998301208, 0.0323965363, -0.0484294109),C1 = CFrame.new(1.52587891e-005, -0.49998045, 2.90870667e-005, -0.0484240092, -0.00117100019, -0.998826265, -0.0324009918, 0.999474883, 0.000399069104, 0.998301268, 0.0323822871, -0.0484365262),})
		CorruptedPart = New("Part",LeftArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.800000072, 0.200000003),CFrame = CFrame.new(2.31463432, 6.72918367, 3.62673688, -0.048417028, -0.0324150361, 0.998301387, -0.00116700074, 0.999474525, 0.03239654, -0.998826742, 0.000403525919, -0.0484294258),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.048417028, -0.00116700074, -0.998826623, -0.0324150361, 0.999474466, 0.000403525832, 0.998301208, 0.0323965363, -0.0484294109),C1 = CFrame.new(-0.400012016, 0.400006294, 0.400012136, -0.0484240092, -0.00117100019, -0.998826265, -0.0324009918, 0.999474883, 0.000399069104, 0.998301268, 0.0323822871, -0.0484365262),})
		CorruptedPart = New("Part",LeftArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.200000003, 0.200000003),CFrame = CFrame.new(1.50631011, 6.40297413, 3.26581192, -0.048417028, -0.0324150361, 0.998301387, -0.00116700074, 0.999474525, 0.03239654, -0.998826742, 0.000403525919, -0.0484294258),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.048417028, -0.00116700074, -0.998826623, -0.0324150361, 0.999474466, 0.000403525832, 0.998301208, 0.0323965363, -0.0484294109),C1 = CFrame.new(1.3589859e-005, 0.100014687, -0.400020242, -0.0484240092, -0.00117100019, -0.998826265, -0.0324009918, 0.999474883, 0.000399069104, 0.998301268, 0.0323822871, -0.0484365262),})
		CorruptedPart = New("Part",LeftArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.400000036, 0.200000003),CFrame = CFrame.new(1.92179501, 6.51633835, 3.64602208, -0.048417028, -0.0324150361, 0.998301387, -0.00116700074, 0.999474525, 0.03239654, -0.998826742, 0.000403525919, -0.0484294258),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.048417028, -0.00116700074, -0.998826623, -0.0324150361, 0.999474466, 0.000403525832, 0.998301208, 0.0323965363, -0.0484294109),C1 = CFrame.new(-0.40000248, 0.200008869, 1.37090683e-005, -0.0484240092, -0.00117100019, -0.998826265, -0.0324009918, 0.999474883, 0.000399069104, 0.998301268, 0.0323822871, -0.0484365262),})
		BurningEff(EffCorruptedPart)
		LeftLeg = New("Model",chara,"LeftLeg",{})
		MainPart = New("Part",LeftLeg,"MainPart",{Transparency = 1,Transparency = 1,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(1, 2, 1),CFrame = CFrame.new(2.2865479, 1.31659603, 1.24781799, 0.00980953407, 0.00110225566, 0.999961138, -0.000537137908, 1.00000858, -0.00109705783, -0.99994719, -0.000526368851, 0.00981026888),CanCollide = false,BottomSurface = Enum.SurfaceType.Smooth,})
		Weld = New("ManualWeld",MainPart,"Weld",{Part0 = MainPart,Part1 = chara["Left Leg"],C0 = CFrame.new(0, 0, 0, 0.00980953407, -0.000537137908, -0.99994719, 0.00110225566, 1.00000858, -0.000526368851, 0.999961138, -0.00109705783, 0.00981026888),C1 = CFrame.new(0, -8.58306885e-006, -2.38418579e-007, 0.00980953407, -0.000537137908, -0.99994719, 0.00110225566, 1.00000858, -0.000526368851, 0.999961138, -0.00109705783, 0.00981026888),})
		EffCorruptedPart = New("Part",LeftLeg,"EffCorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(1, 0.200000048, 1),CFrame = CFrame.new(2.28007793, 0.400032878, 1.25993299, 1.00001979, -3.03611159e-007, -5.47617674e-007, 5.67175448e-007, 1.00001717, -5.60779881e-007, -1.86450779e-006, 9.50574758e-007, 0.99998951),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",EffCorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",EffCorruptedPart,"Weld",{Part0 = EffCorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 1, 5.86369708e-007, -2.15602267e-006, -2.8440752e-007, 0.999998569, 9.76819592e-007, -8.39119252e-007, -5.34477465e-007, 0.999998569),C1 = CFrame.new(-0.0116856098, -0.916567385, -0.00534534454, 0.00980953407, -0.000537137908, -0.99994719, 0.00110225566, 1.00000858, -0.000526368851, 0.999961138, -0.00109705783, 0.00981026888),})
		CorruptedPart = New("Part",LeftLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.600000024, 0.200000003),CFrame = CFrame.new(1.88013697, 0.800038397, 0.859943509, 1.00001979, -3.03611159e-007, -5.47617674e-007, 5.67175448e-007, 1.00001717, -5.60779881e-007, -1.86450779e-006, 9.50574758e-007, 0.99998951),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 1, 5.86369708e-007, -2.15602267e-006, -2.8440752e-007, 0.999998569, 9.76819592e-007, -8.39119252e-007, -5.34477465e-007, 0.999998569),C1 = CFrame.new(0.3841483, -0.516796231, -0.40962553, 0.00980953407, -0.000537137908, -0.99994719, 0.00110225566, 1.00000858, -0.000526368851, 0.999961138, -0.00109705783, 0.00981026888),})
		CorruptedPart = New("Part",LeftLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.800000012, 0.200000003),CFrame = CFrame.new(2.69002914, 0.915953577, 0.851962805, 0.999971032, 0.0011022269, -0.00980960391, -0.00109704852, 1.00001776, 0.000537177373, 0.00981036108, -0.000526409131, 0.999942601),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.999951303, -0.0010970087, 0.00981015898, 0.00110222446, 0.999999166, -0.000526388001, -0.00980970077, 0.00053719338, 0.99995172),C1 = CFrame.new(0.400011122, -0.399985313, 0.400013685, 0.00980953407, -0.000537137908, -0.99994719, 0.00110225566, 1.00000858, -0.000526368851, 0.999961138, -0.00109705783, 0.00981026888),})
		CorruptedPart = New("Part",LeftLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.800000012, 0.200000003),CFrame = CFrame.new(1.88013721, 0.900040269, 1.65993917, 1.00001979, -3.03611159e-007, -5.47617674e-007, 5.67175448e-007, 1.00001717, -5.60779881e-007, -1.86450779e-006, 9.50574758e-007, 0.99998951),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 1, 5.86369708e-007, -2.15602267e-006, -2.8440752e-007, 0.999998569, 9.76819592e-007, -8.39119252e-007, -5.34477465e-007, 0.999998569),C1 = CFrame.new(-0.415866137, -0.41721642, -0.40188694, 0.00980953407, -0.000537137908, -0.99994719, 0.00110225566, 1.00000858, -0.000526368851, 0.999961138, -0.00109705783, 0.00981026888),})
		CorruptedPart = New("Part",LeftLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.200000003, 0.200000003),CFrame = CFrame.new(1.88013721, 0.600035727, 1.25993288, 1.00001979, -3.03611159e-007, -5.47617674e-007, 5.67175448e-007, 1.00001717, -5.60779881e-007, -1.86450779e-006, 9.50574758e-007, 0.99998951),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 1, 5.86369708e-007, -2.15602267e-006, -2.8440752e-007, 0.999998569, 9.76819592e-007, -8.39119252e-007, -5.34477465e-007, 0.999998569),C1 = CFrame.new(-0.0157161951, -0.717007458, -0.405481935, 0.00980953407, -0.000537137908, -0.99994719, 0.00110225566, 1.00000858, -0.000526368851, 0.999961138, -0.00109705783, 0.00981026888),})
		CorruptedPart = New("Part",LeftLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.400000006, 0.200000003),CFrame = CFrame.new(2.28007793, 0.700037479, 1.65993929, 1.00001967, -3.84054147e-007, 3.90969217e-006, 6.35045581e-007, 1.00001717, -5.60838998e-007, -6.19795173e-006, 9.32147486e-007, 0.99998951),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 1, 6.5424797e-007, -6.48946025e-006, -3.64865258e-007, 0.999998629, 9.58411874e-007, 3.61912225e-006, -5.34497644e-007, 0.999998629),C1 = CFrame.new(-0.411835551, -0.616776347, -0.00175023079, 0.00980953407, -0.000537137908, -0.99994719, 0.00110225566, 1.00000858, -0.000526368851, 0.999961138, -0.00109705783, 0.00981026888),})
		CorruptedPart = New("Part",LeftLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 1.20000005, 0.200000003),CFrame = CFrame.new(2.68018699, 1.10004401, 1.65993941, 1.00001967, -3.84054147e-007, 3.90969217e-006, 6.35045581e-007, 1.00001717, -5.60838998e-007, -6.19795173e-006, 9.32147486e-007, 0.99998951),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 1, 6.5424797e-007, -6.48946025e-006, -3.64865258e-007, 0.999998629, 9.58411874e-007, 3.61912225e-006, -5.34497644e-007, 0.999998629),C1 = CFrame.new(-0.408125639, -0.216332912, 0.397896528, 0.00980953407, -0.000537137908, -0.99994719, 0.00110225566, 1.00000858, -0.000526368851, 0.999961138, -0.00109705783, 0.00981026888),})
		CorruptedPart = New("Part",LeftLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.600000024, 0.200000003),CFrame = CFrame.new(2.68596959, 0.816166699, 1.25195313, 0.999971032, 0.0011022269, -0.00980960391, -0.00109704852, 1.00001776, 0.000537177373, 0.00981036108, -0.000526409131, 0.999942601),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.999951303, -0.0010970087, 0.00981015898, 0.00110222446, 0.999999166, -0.000526388001, -0.00980970077, 0.00053719338, 0.99995172),C1 = CFrame.new(5.20944595e-005, -0.499986172, 0.399987936, 0.00980953407, -0.000537137908, -0.99994719, 0.00110225566, 1.00000858, -0.000526368851, 0.999961138, -0.00109705783, 0.00981026888),})
		ScatterEff(EffCorruptedPart)
		RightArm = New("Model",chara,"RightArm",{})
		MainPart = New("Part",RightArm,"MainPart",{Transparency = 1,Transparency = 1,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(1, 2, 1),CFrame = CFrame.new(2.011096, 6.31690788, -3.92582893, 0.00918400101, -0.262283146, 0.964947343, 0.259330034, 0.932596445, 0.251021653, -0.965745091, 0.247934431, 0.0765828639),CanCollide = false,})
		Weld = New("ManualWeld",MainPart,"Weld",{Part0 = MainPart,Part1 = chara["Right Arm"],C0 = CFrame.new(0, 0, 0, 0.00918400101, 0.259330034, -0.965745091, -0.262283146, 0.932596445, 0.247934431, 0.964947343, 0.251021653, 0.0765828639),C1 = CFrame.new(-2.86102295e-006, -9.05990601e-006, -2.38418579e-006, 0.00918400101, 0.259330034, -0.965745091, -0.262283146, 0.932596445, 0.247934431, 0.964947343, 0.251021653, 0.0765828639),})
		Hitbox = New("Part",RightArm,"Hitbox",{BrickColor = BrickColor.new("Really black"),Transparency = 1,Transparency = 1,Size = Vector3.new(1, 4, 1),CFrame = CFrame.new(22.2733669, 5.0842762, -22.1737366, -0.964945257, -0.262290984, 0.00919180829, -0.251027077, 0.93259424, 0.259333313, -0.0765930116, 0.247935042, -0.965744138),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Weld = New("ManualWeld",Hitbox,"Weld",{Part0 = Hitbox,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.964945257, -0.251027077, -0.0765930116, -0.262290984, 0.93259424, 0.247935042, 0.00919180829, 0.259333313, -0.965744138),C1 = CFrame.new(-1.52587891e-005, -1.00003147, -1.71661377e-005, 0.0091838371, 0.259330064, -0.965745151, -0.262283117, 0.932596445, 0.247934505, 0.964947283, 0.251021653, 0.0765827149),})
		CorruptedPart = New("Part",RightArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(1, 2, 1),CFrame = CFrame.new(2.011096, 6.3169179, -3.92581391, -0.964945257, -0.262290984, 0.00919180829, -0.251027077, 0.93259424, 0.259333313, -0.0765930116, 0.247935042, -0.965744138),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.964945138, -0.251027018, -0.0765930042, -0.262290984, 0.932594121, 0.247935027, 0.00919180084, 0.259333313, -0.965744197),C1 = CFrame.new(-1.1920929e-005, 1.28746033e-005, 3.57627869e-006, 0.00918400101, 0.259330034, -0.965745091, -0.262283146, 0.932596445, 0.247934431, 0.964947343, 0.251021653, 0.0765828639),})
		CorruptedPart = New("Part",RightArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(1, 0.600000024, 0.400000036),CFrame = CFrame.new(2.14866924, 6.03215551, -4.72580194, -0.964945078, 0.262291819, -0.00918725226, -0.251029015, -0.932593465, -0.259333432, -0.0765890032, -0.247936144, 0.965744317),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("SpecialMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),MeshType = Enum.MeshType.Wedge,})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.964944899, -0.251028955, -0.0765889958, 0.262291819, -0.932593465, -0.247936144, -0.00918724574, -0.259333432, 0.965744257),C1 = CFrame.new(0.699988842, -0.499982834, 7.62939453e-006, 0.00918400101, 0.259330034, -0.965745091, -0.262283146, 0.932596445, 0.247934431, 0.964947343, 0.251021653, 0.0765828639),})
		CorruptedPart = New("Part",RightArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(1, 1.20000005, 0.600000024),CFrame = CFrame.new(2.63876629, 4.02682734, -4.32773018, -0.964945078, 0.262291819, -0.00918725226, -0.251029015, -0.932593465, -0.259333432, -0.0765890032, -0.247936144, 0.965744317),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("SpecialMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),MeshType = Enum.MeshType.Wedge,})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.964944899, -0.251028955, -0.0765889958, 0.262291819, -0.932593465, -0.247936144, -0.00918724574, -0.259333432, 0.965744257),C1 = CFrame.new(-0.199987888, -2.39999342, 3.02791595e-005, 0.00918400101, 0.259330034, -0.965745091, -0.262283146, 0.932596445, 0.247934431, 0.964947343, 0.251021653, 0.0765828639),})
		CorruptedPart = New("Part",RightArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(1, 1, 0.600000024),CFrame = CFrame.new(1.62134135, 7.81954479, -3.94021821, 0.964945078, -0.262291819, -0.00918725226, 0.251029015, 0.932593465, -0.259333432, 0.0765890032, 0.247936144, 0.965744317),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("SpecialMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),MeshType = Enum.MeshType.Wedge,})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.964944899, 0.251028955, 0.0765889958, -0.262291819, 0.932593465, 0.247936144, -0.00918724574, -0.259333432, 0.965744257),C1 = CFrame.new(0.399995804, 1.5000124, -2.38418579e-007, 0.00918400101, 0.259330034, -0.965745091, -0.262283146, 0.932596445, 0.247934431, 0.964947343, 0.251021653, 0.0765828639),})
		CorruptedPart = New("Part",RightArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(1, 0.600000024, 0.400000036),CFrame = CFrame.new(2.35483098, 5.18234444, -4.53787422, -0.964945078, 0.262291819, -0.00918725226, -0.251029015, -0.932593465, -0.259333432, -0.0765890032, -0.247936144, 0.965744317),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("SpecialMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),MeshType = Enum.MeshType.Wedge,})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.964944899, -0.251028955, -0.0765889958, 0.262291819, -0.932593465, -0.247936144, -0.00918724574, -0.259333432, 0.965744257),C1 = CFrame.new(0.300010204, -1.29999256, 1.40666962e-005, 0.00918400101, 0.259330034, -0.965745091, -0.262283146, 0.932596445, 0.247934431, 0.964947343, 0.251021653, 0.0765828639),})
		CorruptedPart = New("Part",RightArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(1, 1, 0.600000024),CFrame = CFrame.new(1.88730097, 6.99068737, -4.57445002, -0.964945078, 0.262291819, -0.00918725226, -0.251029015, -0.932593465, -0.259333432, -0.0765890032, -0.247936144, 0.965744317),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("SpecialMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),MeshType = Enum.MeshType.Wedge,})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.964944899, -0.251028955, -0.0765889958, 0.262291819, -0.932593465, -0.247936144, -0.00918724574, -0.259333432, 0.965744257),C1 = CFrame.new(0.799996853, 0.50001812, 4.29153442e-006, 0.00918400101, 0.259330034, -0.965745091, -0.262283146, 0.932596445, 0.247934431, 0.964947343, 0.251021653, 0.0765828639),})
		CorruptedPart = New("Part",RightArm,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(1, 0.800000072, 0.600000024),CFrame = CFrame.new(2.37646794, 4.9594202, -4.07979012, -0.964945316, -0.262290984, 0.00918756705, -0.251028091, 0.932593942, 0.259333163, -0.0765890256, 0.247935995, -0.965744197),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, -0.964945138, -0.251028031, -0.0765890107, -0.262290955, 0.932593882, 0.247935966, 0.0091875596, 0.259333193, -0.965744257),C1 = CFrame.new(-0.199994564, -1.39999104, 1.52587891e-005, 0.00918400101, 0.259330034, -0.965745091, -0.262283146, 0.932596445, 0.247934431, 0.964947343, 0.251021653, 0.0765828639),})
		RightLeg = New("Model",chara,"RightLeg",{})
		MainPart = New("Part",RightLeg,"MainPart",{Transparency = 1,Transparency = 1,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(1, 2, 1),CFrame = CFrame.new(2.29641008, 1.31540966, 0.248092994, 0.00933599845, 0.00110999751, 0.999955773, -0.0030579993, 0.999994755, -0.00108149007, -0.99995178, -0.0030477671, 0.00933934376),CanCollide = false,BottomSurface = Enum.SurfaceType.Smooth,})
		Weld = New("ManualWeld",MainPart,"Weld",{Part0 = MainPart,Part1 = chara["Right Leg"],C0 = CFrame.new(0, 0, 0, 0.00933599845, -0.0030579993, -0.99995178, 0.00110999751, 0.999994755, -0.0030477671, 0.999955773, -0.00108149007, 0.00933934376),C1 = CFrame.new(2.98023224e-008, -8.58306885e-006, 2.38418579e-007, 0.00933599845, -0.0030579993, -0.99995178, 0.00110999751, 0.999994755, -0.0030477671, 0.999955773, -0.00108149007, 0.00933934376),})
		CorruptedPart = New("Part",RightLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.200000003, 0.200000003),CFrame = CFrame.new(2.70045996, 1.61376095, -0.149078026, 0.999955833, 0.00111049914, -0.0093326522, -0.00108199986, 0.999994755, 0.00305823679, 0.00933599938, -0.00304800388, 0.999951839),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.999955893, -0.00108199986, 0.00933599938, 0.00111049926, 0.999994755, -0.00304800388, -0.0093326522, 0.00305823679, 0.99995178),C1 = CFrame.new(0.400011688, 0.300008655, 0.400000095, 0.00933599845, -0.0030579993, -0.99995178, 0.00110999751, 0.999994755, -0.0030477671, 0.999955773, -0.00108149007, 0.00933934376),})
		CorruptedPart = New("Part",RightLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.600000024, 0.200000003),CFrame = CFrame.new(1.90071809, 1.81462395, -0.157150015, 0.999955714, 0.00111050205, -0.0093366541, -0.00108199974, 0.999994755, 0.00305724167, 0.00933999754, -0.00304700364, 0.999951899),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.999955773, -0.00108199974, 0.00933999848, 0.00111050217, 0.999994755, -0.00304700388, -0.00933665317, 0.00305724121, 0.99995178),C1 = CFrame.new(0.400002658, 0.50000751, -0.399999142, 0.00933599845, -0.0030579993, -0.99995178, 0.00110999751, 0.999994755, -0.0030477671, 0.999955773, -0.00108149007, 0.00933934376),})
		CorruptedPart = New("Part",RightLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.400000036, 0.200000003),CFrame = CFrame.new(1.896873, 1.71584904, 0.243133992, 0.999955714, 0.00111050205, -0.0093366541, -0.00108199974, 0.999994755, 0.00305724167, 0.00933999754, -0.00304700364, 0.999951899),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.999955773, -0.00108199974, 0.00933999848, 0.00111050217, 0.999994755, -0.00304700388, -0.00933665317, 0.00305724121, 0.99995178),C1 = CFrame.new(4.14252281e-006, 0.400008917, -0.399998784, 0.00933599845, -0.0030579993, -0.99995178, 0.00110999751, 0.999994755, -0.0030477671, 0.999955773, -0.00108149007, 0.00933934376),})
		CorruptedPart = New("Part",RightLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.800000072, 0.200000003),CFrame = CFrame.new(1.89314091, 1.71706903, 0.643112063, 0.999955714, 0.00111050205, -0.0093366541, -0.00108199974, 0.999994755, 0.00305724167, 0.00933999754, -0.00304700364, 0.999951899),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.999955773, -0.00108199974, 0.00933999848, 0.00111050217, 0.999994755, -0.00304700388, -0.00933665317, 0.00305724121, 0.99995178),C1 = CFrame.new(-0.399993181, 0.400005698, -0.399996519, 0.00933599845, -0.0030579993, -0.99995178, 0.00110999751, 0.999994755, -0.0030477671, 0.999955773, -0.00108149007, 0.00933934376),})
		EffCorruptedPart = New("Part",RightLeg,"EffCorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(1, 1.20000005, 1),CFrame = CFrame.new(2.29597116, 0.915416002, 0.249298006, 0.999955714, 0.00111051137, -0.00933665317, -0.00108199974, 0.999994755, 0.00305824191, 0.00933999754, -0.00304800365, 0.999951899),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",EffCorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",EffCorruptedPart,"Weld",{Part0 = EffCorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.999955773, -0.00108199974, 0.00933999848, 0.00111051148, 0.999994755, -0.00304800388, -0.00933665223, 0.00305824145, 0.99995178),C1 = CFrame.new(1.41263008e-005, -0.399995744, 5.00679016e-006, 0.00933599845, -0.0030579993, -0.99995178, 0.00110999751, 0.999994755, -0.0030477671, 0.999955773, -0.00108149007, 0.00933934376),})
		CorruptedPart = New("Part",RightLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.400000006, 0.200000003),CFrame = CFrame.new(2.300596, 1.71419013, -0.153122023, 0.999955714, 0.00111051137, -0.00933665317, -0.00108199974, 0.999994755, 0.00305824191, 0.00933999754, -0.00304800365, 0.999951899),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.999955773, -0.00108199974, 0.00933999848, 0.00111051148, 0.999994755, -0.00304800388, -0.00933665223, 0.00305824145, 0.99995178),C1 = CFrame.new(0.400015235, 0.400005817, 7.39097595e-006, 0.00933599845, -0.0030579993, -0.99995178, 0.00110999751, 0.999994755, -0.0030477671, 0.999955773, -0.00108149007, 0.00933934376),})
		CorruptedPart = New("Part",RightLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.600000024, 0.200000003),CFrame = CFrame.new(2.69322205, 1.81620288, 0.650299072, 0.999955714, 0.00111051137, -0.00933665317, -0.00108199974, 0.999994755, 0.00305824191, 0.00933999754, -0.00304800365, 0.999951899),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.999955773, -0.00108199974, 0.00933999848, 0.00111051148, 0.999994755, -0.00304800388, -0.00933665223, 0.00305824145, 0.99995178),C1 = CFrame.new(-0.400013447, 0.500005245, 0.400009155, 0.00933599845, -0.0030579993, -0.99995178, 0.00110999751, 0.999994755, -0.0030477671, 0.999955773, -0.00108149007, 0.00933934376),})
		CorruptedPart = New("Part",RightLeg,"CorruptedPart",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Granite,Size = Vector3.new(0.200000003, 0.400000006, 0.200000003),CFrame = CFrame.new(2.69684124, 1.71498096, 0.250625998, 0.999955714, 0.00111051137, -0.00933665317, -0.00108199974, 0.999994755, 0.00305824191, 0.00933999754, -0.00304800365, 0.999951899),CanCollide = false,BackSurface = Enum.SurfaceType.SmoothNoOutlines,BottomSurface = Enum.SurfaceType.SmoothNoOutlines,FrontSurface = Enum.SurfaceType.SmoothNoOutlines,LeftSurface = Enum.SurfaceType.SmoothNoOutlines,RightSurface = Enum.SurfaceType.SmoothNoOutlines,TopSurface = Enum.SurfaceType.SmoothNoOutlines,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
		Mesh = New("BlockMesh",CorruptedPart,"Mesh",{Scale = Vector3.new(1.10000002, 1.10000002, 1.10000002),})
		Weld = New("ManualWeld",CorruptedPart,"Weld",{Part0 = CorruptedPart,Part1 = MainPart,C0 = CFrame.new(0, 0, 0, 0.999955773, -0.00108199974, 0.00933999848, 0.00111051148, 0.999994755, -0.00304800388, -0.00933665223, 0.00305824145, 0.99995178),C1 = CFrame.new(-1.63316727e-005, 0.400005937, 0.400005102, 0.00933599845, -0.0030579993, -0.99995178, 0.00110999751, 0.999994755, -0.0030477671, 0.999955773, -0.00108149007, 0.00933934376),})
		ScatterEff(EffCorruptedPart)

		sa = RightArm:GetChildren()
		for i = 1, #sa do
			ScatterEff(sa[i])
		end

		local eff1 = Instance.new("ParticleEmitter",EyeFire)
		eff1.Size = NumberSequence.new(.1)
		eff1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.2,0),NumberSequenceKeypoint.new(1,1)})
		eff1.LightEmission = 1
		eff1.Lifetime = NumberRange.new(.5)
		eff1.Speed = NumberRange.new(1)
		eff1.EmissionDirection = "Front"
		eff1.Rate = 100
		eff1.Texture = "rbxassetid://347504241"
		eff1.Acceleration = Vector3.new(0,10,0)
		eff1.Color = ColorSequence.new(Color3.new(1,0,0))
		local eff2 = Instance.new("ParticleEmitter",EyeFire)
		eff2.Size = NumberSequence.new(.1)
		eff2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.2,0),NumberSequenceKeypoint.new(1,1)})
		eff2.LightEmission = 1
		eff2.Lifetime = NumberRange.new(.5)
		eff2.Speed = NumberRange.new(1)
		eff2.EmissionDirection = "Front"
		eff2.Rate = 100
		eff2.Texture = "rbxassetid://347504259"
		eff2.Acceleration = Vector3.new(0,10,0)
		eff2.Color = ColorSequence.new(Color3.new(1,0,0))
		local eff3 = Instance.new("ParticleEmitter",EyeFire)
		eff3.Size = NumberSequence.new(.1)
		eff3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})
		eff3.LightEmission = 1
		eff3.Lifetime = NumberRange.new(.5)
		eff3.Speed = NumberRange.new(1)
		eff3.EmissionDirection = "Front"
		eff3.Rate = 100
		eff3.Texture = "rbxasset://textures/particles/fire_main.dds"
		eff3.Acceleration = Vector3.new(0,10,0)
		eff3.Color = ColorSequence.new(Color3.new(1,0,0))
		local function findRemoteEvent(name)
			local replicatedStorage = game:GetService("ReplicatedStorage")
			local workspace = game:GetService("Workspace")
			for _, parent in ipairs({replicatedStorage, workspace}) do
				for _, child in ipairs(parent:GetDescendants()) do
					if child:IsA("RemoteEvent") and child.Name == name then
						return child
					end
				end
			end
			return nil
		end

		--Sounds--
		local remote = findRemoteEvent("AC6_FE_Sounds")
		if not remote then return end
		remote:FireServer("newSound", "Slash", chara.Torso, "rbxassetid://28144425", 0.7, 5, false)
		remote:FireServer("newSound", "Hit", chara.Torso, "rbxassetid://429400881", 0.7, 5, false)
		remote:FireServer("newSound", "Tele", chara.Torso, "rbxassetid://2767090", 0.7, 5, false)
		remote:FireServer("newSound", "Burn", chara.Torso, "rbxassetid://32791565", 0.7, 5, false)
		remote:FireServer("newSound", "Music2", chara.Torso, "rbxassetid://11984351", 0.2, 5, true)
		remote:FireServer("newSound", "DeathMus", workspace, "rbxassetid://19094700", 0.5, 5, true)
		remote:FireServer("newSound", "DeathEx", chara.Torso, "rbxassetid://11984351", 1, 5, false)
		remote:FireServer("playSound", "Music2")

		--Animations--
		swinganim = chara.Humanoid:LoadAnimation(New("Animation",chara,"Swing",{AnimationId = "rbxassetid://186934658"}))

		--Name Tag--

		--Skybox--

		--Soul Steal--
		function SoulSteal(pos)
			local soulst = coroutine.wrap(function()
				local soul = Instance.new("Part",chara)
				soul.Size = Vector3.new(0,0,0)
				soul.CanCollide = false
				soul.Anchored = false
				soul.Position = pos
				soul.CFrame = CFrame.new(pos.X,pos.Y,pos.Z)
				soul.Transparency = 1
				local ptc = Instance.new("ParticleEmitter",soul)
				ptc.Texture = "http://www.roblox.com/asset/?id=413366101"
				ptc.Size = NumberSequence.new(.5)
				ptc.LockedToPart = true
				ptc.Speed = NumberRange.new(0)
				ptc.Lifetime = NumberRange.new(9999)
				local bodpos = Instance.new("BodyPosition",soul)
				bodpos.Position = pos
				wait(2)
				soul.Touched:connect(function(hit)
					if hit.Parent == chara then
						delete(soul)
					end
				end)
				while soul do
					wait(.1)
					bodpos.Position = chara.Torso.Position
				end
			end)
			soulst()
		end

		--Death of a Mortal--
		function KillMortal(hitdude)
			local torsy = nil
			if hitdude:FindFirstChild("Torso")~=nil then
				torsy = hitdude.Torso	
			elseif hitdude:FindFirstChild("UpperTorso")~=nil then
				torsy = hitdude.UpperTorso
			end
			local val = Instance.new("ObjectValue",hitdude)
			val.Name = "HasBeenHit"
			breakJoints(hitdude)
			delete(hitdude.Humanoid)
			SoulSteal(torsy.Position)
			local chi = hitdude:GetChildren()
			for i = 1, #chi do
				if chi[i].ClassName == "Part" or chi[i].ClassName == "MeshPart" then
					local bodpos = Instance.new("BodyPosition",chi[i])
					bodpos.Position = chi[i].Position + Vector3.new(math.random(-5,5),math.random(-5,5),math.random(-5,5))
					ScatterEff(chi[i])
					chi[i].BrickColor = BrickColor.new("Really black")
				end
			end
			for i = 1, 4 do
				for i = 1, #chi do
					if chi[i].ClassName == "Part" or chi[i].ClassName == "MeshPart" then
						chi[i].Transparency = chi[i].Transparency + .25
						wait(.01)
					end
				end
			end
			for i = 1, #chi do
				if chi[i].ClassName == "Part" or chi[i].ClassName == "MeshPart" then
					delete(chi[i])
				end
			end
		end

		--Arm Touch--
		bladeactive = false
		Hitbox.Touched:connect(function(hit)
			if bladeactive == true then
				if hit.Parent:FindFirstChild("Humanoid")~= nil and hit.Parent:FindFirstChild("HasBeenHit")== nil and hit.Parent ~= chara then
					remote:FireServer("playSound", "Hit")
					KillMortal(hit.Parent)
				end
			end
		end)

		--Teleport--
		function Teleport(pos)
			remote:FireServer("playSound", "Tele")
			local ch = chara:GetChildren()
			for i = 1, #ch do
				if ch[i].ClassName == "Part" and ch[i].Name ~= "HumanoidRootPart" then
					local trace = Instance.new("Part",game.Workspace)
					trace.Size = ch[i].Size
					trace.Material = "Neon"
					trace.BrickColor = BrickColor.new("Really black")
					trace.Transparency = .3
					trace.CanCollide = false
					trace.Anchored = true
					trace.CFrame = ch[i].CFrame
					if ch[i].Name == "Head" then
						mehs = Instance.new("CylinderMesh",trace)
						mehs.Scale = Vector3.new(1.25,1.25,1.25)
					end
					tracedisappear = coroutine.wrap(function()
						wait(1)
						for i = 1, 7 do
							wait(.1)
							trace.Transparency = trace.Transparency + .1
						end
						trace:Destroy()
					end)
					tracedisappear()
				end
			end
			chara.Torso.CFrame = CFrame.new(pos.X,pos.Y,pos.Z)
		end

		--Grab--
		function Grab(mouse)
			local hit = mouse.Target
			if hit ~= nil then
				if hit.Parent:FindFirstChild("Humanoid")~=nil then
					local torsy = nil
					if hit.Parent:FindFirstChild("Torso")~=nil then
						torsy = hit.Parent.Torso
					elseif hit.Parent:FindFirstChild("UpperTorso")~=nil then
						torsy = hit.Parent.UpperTorso
					end
					local bodpos = Instance.new("BodyPosition",torsy)
					bodpos.Position = torsy.Position
					wait(1)
					remote:FireServer("playSound", "Burn")
					hit.Parent.Humanoid.MaxHealth = 100
					bodpos.Position = bodpos.Position + Vector3.new(0,4,0)
					for i = 1, 10 do
						wait(.1)
						BurningEff(torsy)
						hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - 10
					end
					KillMortal(hit.Parent)
				end
			else end
		end

		--Button1Down--
		dell = false
		function onButton1Down()
			if dell == false then
				dell = true
				swinganim:Play()
				bladeactive = true
				remote:FireServer("playSound", "Slash")
				wait(.7)
				bladeactive = false
				dell = false
				swinganim:Stop()
			end
		end

		--KeyDowns--
		function onKeyDown(key)
			if key == "z" then
				Teleport(Mouse.Hit.p + Vector3.new(0,2,0))
			elseif key == "x" then
				Grab(Mouse)
			end
		end

		--Mouse Functions--
		Mouse = player:GetMouse()
		if Mouse then
			Mouse.Button1Down:connect(onButton1Down)
			Mouse.KeyDown:connect(onKeyDown)
		end

		--Death--
		chara.Humanoid.Died:connect(function()
			local pat = Instance.new("Part",game.Workspace)
			pat.Transparency = 1
			pat.Anchored = true
			pat.CFrame = chara.Torso.CFrame
			remote:FireServer("playSound", "DeathMus")
			remote:FireServer("playSound", "DeathEx")
		end)

		--Loop Function--
		while true do
			wait(.01)
			if chara.Humanoid.Health > 0 then
				chara.Humanoid.MaxHealth = math.huge
				chara.Humanoid.Health = math.huge
				chara["Left Arm"].Anchored = false
				chara["Right Arm"].Anchored = false
				chara["Left Leg"].Anchored = false
				chara["Right Leg"].Anchored = false
				chara.Torso.Anchored = false
				ch = chara:GetChildren()
				for i = 1, #ch do
					if ch[i].ClassName == "Accessory" or ch[i].ClassName == "Hat" then
						delete(ch[i])
					end
				end
				tools = player.Backpack:GetChildren()
				for i = 1, #tools do
					if tools[i].ClassName == "HopperBin" then
						delete(tools[i])
					end
				end
				BurningEff(jtrace)
				game.Debris:AddItem(jtrace,1)
			end
		end
	elseif isCmd(cmd, {"panel"}) then
		--sound thingy

--[[
Made By Scripty#2063
If You Gonna showcase this , make sure to Credit me , do not take that you are owner of the script
This Gui is Undetectable
RespectFilteringEnabled must be false to use it
--]]

		local ScreenGui = Instance.new("ScreenGui")
		local Draggable = Instance.new("Frame")
		local Frame = Instance.new("Frame")
		local Frame_2 = Instance.new("Frame")
		local Time = Instance.new("TextLabel")
		local _1E = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local _3E = Instance.new("TextButton")
		local UICorner_2 = Instance.new("UICorner")
		local SE = Instance.new("TextButton")
		local UICorner_3 = Instance.new("UICorner")
		local Path = Instance.new("TextLabel")
		local Top = Instance.new("Frame")
		local Top_2 = Instance.new("Frame")
		local ImageLabel = Instance.new("ImageLabel")
		local TextLabel = Instance.new("TextLabel")
		local Exit = Instance.new("TextButton")
		local Minizum = Instance.new("TextButton")
		local Stop = Instance.new("TextButton")
		local UICorner_4 = Instance.new("UICorner")
		local IY = Instance.new("TextButton")
		local UICorner_5 = Instance.new("UICorner")
		local TextLabel_2 = Instance.new("TextLabel")
		local Wait = Instance.new("TextBox")

		--Properties:

		ScreenGui.Name = ". Ǥ҉̷҉̵҉̸҉̷҉̵҉̸҉̡҉̡҉̼҉̱҉͎҉͎҉̞҉̼҉̱҉͎҉͎҉̞҉ͤ҉ͬ҉̅҉ͤ҉ͬ"
		ScreenGui.Parent = game:GetService("CoreGui")
		ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		ScreenGui.ResetOnSpawn = false

		Draggable.Name = "Ǥ҉̷҉̵҉̸҉̷҉̵҉̸҉̡҉̡҉̼҉̱҉͎҉͎҉̞҉̼҉̱҉͎҉͎҉̞҉ͤ҉ͬ҉̅҉ͤ҉ͬ."
		Draggable.Parent = ScreenGui
		Draggable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Draggable.BackgroundTransparency = 1.000
		Draggable.BorderSizePixel = 0
		Draggable.Position = UDim2.new(0.35026139, 0, 0.296158612, 0)
		Draggable.Size = UDim2.new(0, 438, 0, 277)

		Frame.Name = ". . Ǥ҉̷҉̵҉̸҉̷҉̵҉̸҉̡҉̡҉̼҉̱҉͎҉͎҉̞҉̼҉̱҉͎҉͎҉̞҉ͤ҉ͬ҉̅҉ͤ҉ͬ. "
		Frame.Parent = Draggable
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BackgroundTransparency = 1.000
		Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(-0.00133678317, 0, -0.00348037481, 0)
		Frame.Size = UDim2.new(0, 438, 0, 277)

		Frame_2.Name = " . Ǥ҉̷҉̵҉̸҉̷҉̵҉̸҉̡҉̡҉̼҉̱҉͎҉͎҉̞҉̼҉̱҉͎҉͎҉̞҉ͤ҉ͬ҉̅҉ͤ҉ͬ. "
		Frame_2.Parent = Frame
		Frame_2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		Frame_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Frame_2.BorderSizePixel = 0
		Frame_2.Position = UDim2.new(-0.00133678142, 0, -0.0179207586, 0)
		Frame_2.Size = UDim2.new(0, 438, 0, 238)
		Frame_2.Active = true
		Frame_2.Draggable = true

		Time.Name = "Time"
		Time.Parent = Frame_2
		Time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Time.BackgroundTransparency = 1.000
		Time.Position = UDim2.new(0, 0, 0.0126050422, 0)
		Time.Size = UDim2.new(0, 437, 0, 31)
		Time.Font = Enum.Font.GothamSemibold
		Time.Text = "RespectFilteringEnabled(RFE) : nil"
		Time.TextColor3 = Color3.fromRGB(255, 255, 255)
		Time.TextScaled = true
		Time.TextSize = 14.000
		Time.TextWrapped = true

		_1E.Name = "1E"
		_1E.Parent = Frame_2
		_1E.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		_1E.BorderSizePixel = 0
		_1E.Position = UDim2.new(0.0182648394, 0, 0.676470578, 0)
		_1E.Size = UDim2.new(0, 208, 0, 33)
		_1E.Font = Enum.Font.SourceSans
		_1E.Text = "Mute Game"
		_1E.TextColor3 = Color3.fromRGB(255, 255, 255)
		_1E.TextScaled = true
		_1E.TextSize = 30.000
		_1E.TextWrapped = true

		UICorner.Parent = _1E

		_3E.Name = "3E"
		_3E.Parent = Frame_2
		_3E.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		_3E.BorderSizePixel = 0
		_3E.Position = UDim2.new(0.0159817357, 0, 0.142857149, 0)
		_3E.Size = UDim2.new(0, 209, 0, 33)
		_3E.Font = Enum.Font.SourceSans
		_3E.Text = "Annoying  Sound"
		_3E.TextColor3 = Color3.fromRGB(255, 255, 255)
		_3E.TextSize = 30.000
		_3E.TextWrapped = true

		UICorner_2.Parent = _3E

		SE.Name = "SE"
		SE.Parent = Frame_2
		SE.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		SE.BorderSizePixel = 0
		SE.Position = UDim2.new(0.509132445, 0, 0.142857149, 0)
		SE.Size = UDim2.new(0, 209, 0, 33)
		SE.Font = Enum.Font.SourceSans
		SE.Text = "Kill Sound Service"
		SE.TextColor3 = Color3.fromRGB(255, 255, 255)
		SE.TextSize = 30.000
		SE.TextWrapped = true

		UICorner_3.Parent = SE

		Path.Name = "Path"
		Path.Parent = Frame_2
		Path.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		Path.BackgroundTransparency = 1.000
		Path.Position = UDim2.new(0.00684931502, 0, 0.815126061, 0)
		Path.Size = UDim2.new(0, 435, 0, 44)
		Path.Font = Enum.Font.GothamSemibold
		Path.Text = "Dev Note : This Script is FE and it only FE when RespectFilteringEnabled(RFE) is disabled , elseif RespectFilteringEnabled(RFE) is true then it only be client , mostly RespectFilteringEnabled(RFE) disabled game are classic game"
		Path.TextColor3 = Color3.fromRGB(255, 0, 0)
		Path.TextScaled = true
		Path.TextSize = 14.000
		Path.TextWrapped = true

		Top.Name = "Top"
		Top.Parent = Frame_2
		Top.BackgroundColor3 = Color3.fromRGB(41, 60, 157)
		Top.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Top.BorderSizePixel = 0
		Top.Position = UDim2.new(-0.00133678142, 0, -0.128059402, 0)
		Top.Size = UDim2.new(0, 438, 0, 30)
		Top_2.Name = "Top"
		Top_2.Parent = Top
		Top_2.BackgroundColor3 = Color3.fromRGB(30, 45, 118)
		Top_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Top_2.BorderSizePixel = 0
		Top_2.Position = UDim2.new(0, 0, 0.967638671, 0)
		Top_2.Size = UDim2.new(0, 438, 0, 5)

		ImageLabel.Parent = Top
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.Position = UDim2.new(0, 0, 0.0666666701, 0)
		ImageLabel.Size = UDim2.new(0, 29, 0, 27)
		ImageLabel.Image = "http://www.roblox.com/asset/?id=8798286232"

		TextLabel.Parent = ImageLabel
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0.997245014, 0, 0, 0)
		TextLabel.Size = UDim2.new(0, 397, 0, 30)
		TextLabel.Font = Enum.Font.GothamSemibold
		TextLabel.Text = "FEAG"
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextScaled = true
		TextLabel.TextSize = 14.000
		TextLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextWrapped = true

		Exit.Name = "Exit"
		Exit.Parent = Top
		Exit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Exit.BackgroundTransparency = 1.000
		Exit.Position = UDim2.new(0.924657524, 0, 0, 0)
		Exit.Size = UDim2.new(0, 32, 0, 25)
		Exit.Font = Enum.Font.GothamSemibold
		Exit.Text = "x"
		Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
		Exit.TextScaled = true
		Exit.TextSize = 14.000
		Exit.TextWrapped = true

		Minizum.Name = "Minizum"
		Minizum.Parent = Top
		Minizum.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Minizum.BackgroundTransparency = 1.000
		Minizum.Position = UDim2.new(0.851598203, 0, 0, 0)
		Minizum.Size = UDim2.new(0, 32, 0, 23)
		Minizum.Font = Enum.Font.GothamSemibold
		Minizum.Text = "_"
		Minizum.TextColor3 = Color3.fromRGB(255, 255, 255)
		Minizum.TextScaled = true
		Minizum.TextSize = 14.000
		Minizum.TextWrapped = true

		Stop.Name = "Stop"
		Stop.Parent = Frame_2
		Stop.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Stop.BorderSizePixel = 0
		Stop.Position = UDim2.new(0.0182648394, 0, 0.310924381, 0)
		Stop.Size = UDim2.new(0, 424, 0, 33)
		Stop.Font = Enum.Font.SourceSans
		Stop.Text = "Stop"
		Stop.TextColor3 = Color3.fromRGB(255, 255, 255)
		Stop.TextSize = 30.000
		Stop.TextWrapped = true

		UICorner_4.Parent = Stop

		IY.Name = "IY"
		IY.Parent = Frame_2
		IY.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		IY.BorderSizePixel = 0
		IY.Position = UDim2.new(0.509132445, 0, 0.676470578, 0)
		IY.Size = UDim2.new(0, 209, 0, 33)
		IY.Font = Enum.Font.SourceSans
		IY.Text = "Unmute Game"
		IY.TextColor3 = Color3.fromRGB(255, 255, 255)
		IY.TextScaled = true
		IY.TextSize = 30.000
		IY.TextWrapped = true

		UICorner_5.Parent = IY

		TextLabel_2.Parent = Frame_2
		TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel_2.BackgroundTransparency = 1.000
		TextLabel_2.Position = UDim2.new(0.0182648394, 0, 0.466386557, 0)
		TextLabel_2.Size = UDim2.new(0, 426, 0, 50)
		TextLabel_2.Font = Enum.Font.GothamSemibold
		TextLabel_2.Text = "Wait Speed       :"
		TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel_2.TextSize = 30.000
		TextLabel_2.TextWrapped = true
		TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

		Wait.Name = "Wait()"
		Wait.Parent = Frame_2
		Wait.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Wait.BackgroundTransparency = 1.000
		Wait.Position = UDim2.new(0.531963468, 0, 0.466386557, 0)
		Wait.Size = UDim2.new(0, 199, 0, 50)
		Wait.ZIndex = 99999
		Wait.ClearTextOnFocus = false
		Wait.Font = Enum.Font.GothamSemibold
		Wait.Text = "0.5"
		Wait.TextColor3 = Color3.fromRGB(255, 255, 255)
		Wait.TextSize = 30.000
		Wait.TextWrapped = true

		--Sound Service:
		local notification = Instance.new("Sound")
		notification.Parent = game:GetService("SoundService")
		notification.SoundId = "rbxassetid://9086208751"
		notification.Volume = 5
		notification.Name = ". Ǥ҉̷҉̵҉̸҉̷҉̵҉̸҉̡҉̡҉̼҉̱҉͎҉͎҉̞҉̼҉̱҉͎҉͎҉̞҉ͤ҉ͬ҉̅҉ͤ҉ͬ"

		--funuction:
		Exit.MouseButton1Click:Connect(function()
			ScreenGui:Destroy()
		end)
		local Mute = false
		IY.MouseButton1Click:Connect(function()
			Mute = false
		end)

		_1E.MouseButton1Click:Connect(function()
			Mute = true
			while Mute == true do 
				wait()
				for _, sound in next, workspace:GetDescendants() do
					if sound:IsA("Sound") then
						sound:Stop()
					end
				end
			end
		end)

		_3E.MouseButton1Click:Connect(function()
			for _, sound in next, workspace:GetDescendants() do
				if sound:IsA("Sound") then
					sound:Play()
				end
			end
		end)

		local Active = true
		SE.MouseButton1Click:Connect(function()
			Active = true
			while Active == true do
				local StringValue = Wait.Text
				wait(StringValue)
				for _, sound in next, workspace:GetDescendants() do
					if sound:IsA("Sound") then
						sound:Play()
					end
				end
			end
		end)

		Stop.MouseButton1Click:Connect(function()
			Active = false
		end)
		--Credit:
		notification:Play()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "FEAG";
			Text = "FEAG Has Been Loaded , Made By Scripty#2063 (gamer14_123)";
			Icon = "";
			Duration = 10; 
			Button1 = "Yes Sir";
		})
		--Check:
		while true do
			wait(0.5)
			local setting = game:GetService("SoundService").RespectFilteringEnabled
			if setting == true then
				Time.TextColor = BrickColor.new(255,0,0)
				Time.Text ="RespectFilteringEnabled(RFE) : true"
			elseif setting == false then
				Time.Text ="RespectFilteringEnabled(RFE) : false"
				Time.TextColor = BrickColor.new(0,255,0)
			end
		end
	elseif isCmd(cmd, {"thomas"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		local function breakJoints(instance)
			for _, v in pairs(instance:GetDescendants()) do
				if v:IsA("Weld") or v:IsA("WeldConstraint") or v:IsA("JointInstance") then
					delete(v)
				end
			end
		end
		local function findRemoteEvent(name)
			local replicatedStorage = game:GetService("ReplicatedStorage")
			local workspace = game:GetService("Workspace")
			for _, parent in ipairs({replicatedStorage, workspace}) do
				for _, child in ipairs(parent:GetDescendants()) do
					if child:IsA("RemoteEvent") and child.Name == name then
						return child
					end
				end
			end
			return nil
		end

		local function generateRandomName()
			local chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ"
			local name = ""
			for i = 1, math.random(5, 10) do
				name = name .. chars:sub(math.random(1, #chars), math.random(1, #chars))
			end
			return name
		end

		local p = Player.Character
		local weld = Instance.new("Weld", p.Torso)
		weld.Part0 = p.Torso

		local train = Instance.new("Part", p.Torso)
		train.Anchored = true
		train.CanCollide = false
		train.Size = Vector3.new(3, 2, 6)
		train.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		weld.Part1 = train
		weld.C1 = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(180), 0)
		train.Anchored = false
		local TrainMesh = Instance.new("SpecialMesh", train)
		TrainMesh.MeshType = Enum.MeshType.FileMesh
		TrainMesh.Scale = Vector3.new(0.020, 0.020, 0.015)
		TrainMesh.MeshId = "rbxassetid://431017802"
		TrainMesh.TextureId = "rbxassetid://431017809"

		local weld2 = Instance.new("Weld", p.Torso)
		weld2.Part0 = p.Torso
		local Smoke = Instance.new("Part", p.Torso)
		Smoke.Anchored = true
		Smoke.CanCollide = false
		Smoke.Size = Vector3.new(1, 1, 1)
		Smoke.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		weld2.Part1 = Smoke
		weld2.C1 = CFrame.new(0, -4, 3.5) -- * CFrame.Angles(0,math.rad(180),0)
		Smoke.Anchored = false
		Smoke.Transparency = 1;

		local Particle = Instance.new("ParticleEmitter", Smoke)
		Particle.Rate = 50
		Particle.Speed = NumberRange.new(30, 60)
		Particle.VelocitySpread = 4
		Particle.Texture = "rbxassetid://133619974"

		local Light = Instance.new("SpotLight", train)
		Light.Angle = 45
		Light.Brightness = 100
		Light.Face = Enum.NormalId.Back
		Light.Range = 30

		p.Humanoid.WalkSpeed = 60

		for i, v in pairs(p:GetChildren()) do
			if v:IsA("Part") then
				v.Transparency = 1
			elseif v:IsA("Hat") then
				v:Destroy()
			elseif v:IsA("Model") then
				v:Destroy()
			end
		end

		local function SFX(id, pitch, volume, loop)
			local remote = findRemoteEvent("AC6_FE_Sounds")
			if remote then
				local randomName = generateRandomName()
				remote:FireServer("newSound", randomName, p.Torso, "rbxassetid://".. id, pitch, volume, loop)
				remote:FireServer("playSound", randomName)
			end
		end

		train.Touched:Connect(function(hit)
			if hit.Parent then
				if hit.Parent:IsA("Model") then
					if Players:FindFirstChild(hit.Parent.Name) then
						if hit.Parent.Name ~= Player.Name then
							breakJoints(Players:FindFirstChild(hit.Parent.Name).Character)
							SFX(475073913, 1, 2, false)
						end
					end
				end
			end
		end)

		local Music = SFX(106265211160625, 0.1, 10, true)
	elseif isCmd(cmd, {"kd"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		function notify(title,text,duration)
			game.StarterGui:SetCore("SendNotification", {
				Title = title or "", 
				Text = text or "",
				Duration = duration or 5
			})
		end
		local genv = (getgenv and (getgenv() ~= getfenv()) and getgenv()) or _G
		local char = Player.Character or Player.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
		local simRadius = gethiddenproperty and gethiddenproperty(Player,"SimulationRadius")
		local requiredRadius = 20
		local isR15 = hum.RigType == Enum.HumanoidRigType.R15
		local forcefield = char:FindFirstChildOfClass("ForceField")
		local fakeHum = hum:Clone()
		local hrp = char:WaitForChild("HumanoidRootPart")
		local hrpCF = hrp.CFrame
		local stopAlign = false
		local stopAntiVoid = false
		local limbs = {}
		local hatHandles = {}
		local reanimConnections = {}

		runCommand("clip")

		if simRadius and simRadius < requiredRadius then
			repeat
				notify("Please wait",`Waiting for bigger SimulationRadius ({tostring(math.floor(simRadius))}/{tostring(requiredRadius)})`, 2)
				task.wait(2)
			until gethiddenproperty(Player,"SimulationRadius") >= requiredRadius
			if Player.Character == nil or Player.Character ~= char or hum.Parent == nil or hum.Health <= 0 then return end
		end

		if forcefield then forcefield:Destroy() end
		char.Archivable = true

		local rig = (not isR15) and char:Clone()

		if isR15 then
			local canGetObjects, loadedRig = pcall(function() return game:GetObjects("rbxassetid://18418211383")[1] end)
			local r6Rig = isTesting and rStorage:WaitForChild("R6Rig") or canGetObjects and loadedRig or loadstring(httpget("https://gist.githubusercontent.com/someunknowndude/ad264038a91f7fa11bec2f67dad3feaf/raw"))()
			local humDesc = players:GetCharacterAppearanceAsync(Player.UserId)
			local r6Head = r6Rig.Head
			local r15Head = char.Head
			local surfaceAppearance = r15Head:FindFirstChildOfClass("SurfaceAppearance")
			local face = r15Head:FindFirstChild("face")

			if surfaceAppearance then 
				surfaceAppearance:Clone().Parent = r6Head
			else
				--if face then r6Head.face.Texture = face.Texture end
				--r6Head.face.Transparency = 0
			end

			for i,v in pairs(r15Head:GetChildren()) do
				if not v:IsA("Attachment") then continue end
				v:Clone().Parent = r6Head
			end

			for i,v in pairs(humDesc:GetDescendants()) do
				if v:IsA("BodyColors") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic") then
					v.Parent = r6Rig
					continue
				end
				if v:IsA("Accessory") or v:IsA("Hat") then
					r6Rig:WaitForChild("Humanoid"):AddAccessory(v)
				end
			end


			rig = r6Rig
		else
			local mesh = char.Head:FindFirstChildOfClass("SpecialMesh")
			local face = char.Head:FindFirstChild("face")
			if mesh and face then
				delete(face)
			end
		end	

		local rigHRP = rig:WaitForChild("HumanoidRootPart")
		local rigHum = rig:FindFirstChild("Humanoid")

		rig.Name = "wacky reanim rig"


		for i,v in pairs(char:GetChildren()) do
			if not v:IsA("BasePart") then continue end
			table.insert(limbs, {v,rig[v.Name]})
		end


		local accessories = hum:GetAccessories()
		local rigAccessories = rigHum:GetAccessories()

		for i,v in pairs(accessories) do
			if not isR15 then
				table.insert(hatHandles,{v.Handle,rigAccessories[i].Handle})
				continue
			end
			for _,rigAcc in pairs(rigAccessories) do
				local handle = rigAcc.Handle
				local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle
				local texture = handle == mesh and mesh.TextureID or mesh.TextureId
				if not (rigAcc.Name == v.Name and mesh.MeshId == v.Handle.MeshId and texture == v.Handle.TextureID) then continue end
				table.insert(hatHandles,{v.Handle,rigAcc.Handle})
				continue 
			end
		end

		local clock = os and os.clock or tick
		local cos = math.cos
		local sin = math.sin
		local cfNew = CFrame.new
		local cfZero = CFrame.identity
		local v3New = Vector3.new
		local v3Zero = Vector3.zero

		local changedMaxSimRad = pcall(sethiddenproperty, Player, "MaximumSimulationRadius", 1000)
		local changedSimRad = pcall(sethiddenproperty, Player, "SimulationRadius", 1000)
		local netlessCF = cfZero
		local sineValue = 0


		local function align(part0, part1, offset)
			if stopAlign then return end
			if part0 and part0.Parent and part1 and part1.Parent then
				local part0_mass = part1.Mass * 5
				part0.AssemblyLinearVelocity = v3New(part1.AssemblyLinearVelocity.X * part0_mass, sineValue, part1.AssemblyLinearVelocity.Z * part0_mass)
				part0.AssemblyAngularVelocity = part1.AssemblyAngularVelocity

				if isnetworkowner(part0) then
					part0.CFrame = part1.CFrame * offset
				end
			end
		end

		local function setCamera(model)
			local oldCamCF = workspace.CurrentCamera.CFrame
			workspace.CurrentCamera.CameraSubject = model.Humanoid
			workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Once(function()
				workspace.CurrentCamera.CFrame = oldCamCF
			end)
		end

		local function disableCollisions(model,canTouchAndCast)
			for _, part in next, model:GetDescendants() do
				if part and part:IsA("BasePart") then
					part.CanCollide = false
					part.CanQuery = canTouchAndCast
					part.CanTouch = canTouchAndCast
				end
			end
		end

		local function makeTransparent(model)
			for i,v in pairs(model:GetDescendants()) do
				if not (v:IsA("BasePart") or v:IsA("Decal")) then continue end
				v.Transparency = 1
			end
		end

		local function breakJoints(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("JointInstance") then continue end
				delete(v)
			end
		end

		local function removeScripts(model)
			for i,v in pairs(model:GetChildren()) do
				if not (v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") or v.Name == "Animate") then continue end
				delete(v)
			end
		end

		local function removeTouchTriggers(model)
			for i,v in pairs(model:GetDescendants()) do
				if not v:IsA("TouchTransmitter") then continue end
				delete(v)
			end
		end

		local function onPostSim()
			for _, data in next, limbs do
				align(data[1], data[2],netlessCF)
			end

			for _, data in next, hatHandles do
				align(data[1], data[2], netlessCF)
			end
		end

		local function onPreSim()
			netlessCF = cfNew(0.01 * sin(clock()*16), 0, 0.01 * math.cos(clock()*16))
			sineValue = 40 - 3 * sin(clock()*10)

			if stopAntiVoid or rigHRP.Position.Y > (workspace.FallenPartsDestroyHeight + 50) then return end
			rigHRP.CFrame = hrpCF
			rigHRP.AssemblyLinearVelocity = v3Zero
			rigHRP.AssemblyAngularVelocity = v3Zero
		end


		rigHRP.CFrame = hrpCF
		rig.Parent = workspace
		Player.Character = rig
		setCamera(rig)
		rig.Animate.Enabled = false
		rig.Animate.Enabled = true
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		repeat task.wait() until limbs[3][1].CanCollide
		task.wait(0.05)
		delete(hum)
		repeat task.wait() until hum.Parent == nil
		task.wait()
		fakeHum.Parent = char
		task.wait()
		table.insert(reanimConnections, game:GetService("RunService").PreSimulation:Connect(onPreSim))
		table.insert(reanimConnections, game:GetService("RunService").PostSimulation:Connect(onPostSim))
		table.insert(reanimConnections, game:GetService("RunService").Stepped:Connect(function()
			disableCollisions(char,false)
			disableCollisions(rig,true)
		end))

		breakJoints(char)
		makeTransparent(char)
		removeScripts(char)
		removeTouchTriggers(char)

		genv.LoadLibrary = function(lib) return loadstring(httpget("https://raw.githubusercontent.com/Roblox/Core-Scripts/master/CoreScriptsRoot/Libraries/" .. lib .. ".lua"))() end

		local reset = Instance.new("BindableEvent")
		reset.Event:Connect(function()
			if stopAlign then
				local hum = character:FindFirstChildOfClass("Humanoid")
				if not hum then return character:BreakJoints() end
				hum.Health = 0
				return
			end
			notify("Resetting", "Please wait ~6 seconds", 6)
			stopAntiVoid = true
			rigHRP.Anchored = true
			rigHRP.CFrame = CFrame.new(0,workspace.FallenPartsDestroyHeight + 5,0)
			task.wait(0.5)
			stopAlign = true
			rigHum:ChangeState(Enum.HumanoidStateType.Dead)
			Player.CharacterAdded:Wait()
			rig:Destroy()
			for i,v in pairs(reanimConnections) do
				v:Disconnect()
			end
		end)

		game.StarterGui:SetCore("ResetButtonCallback", reset)

		notify("Success!", "reanim loaded!")
		wait(0)
		Player = Player

		local count = 0
		local countspeed = 1
		local sine = 0
		local sinespeed = 1
		local angle = nil
		local global_wait = 0
		local showtag = false


		--dance booleans--
		local jerk = false
		local party = false
		local canttouch = false
		local happy = false
		local spin = false
		local thriller = false
		local barrel = false
		local sax = false
		local spooky = false
		local stride = false
		local shuffle = false
		local rock = false
		local gagnam = false
		local snoop = false
		local darude = false
		local taco = false
		------------------
		--dance accessory--
		local barrelbrick = nil
		local saxtool = nil
		-------------------
		--custom animate--
		local walk = false
		local jump = false
		local sit = false
		local run = false
		------------------
		--walk keys--
		local W = false
		local A = false
		local S = false
		local D = false
		-------------
		local m = Instance.new("Model",Player.Character) m.Name = "ModelParts"
		local miniweld = nil
		local rootpart = nil

		local Mouse = nil
		local Animate = nil
		local Music = nil
		local Asset = "http://www.roblox.com/asset/?id="
		local Animating = nil
		local humanoid = nil
		local face = nil 

		local head = nil
		local torso = nil
		local ra = nil
		local la = nil
		local rl = nil
		local ll = nil
		local rs = nil
		local ls = nil
		local rh = nil
		local lh = nil
		local neck = nil
		local rj = nil

		local char = nil
		local Hat1 = nil
		local Hat2 = nil
		local a,b = nil

		----------musics-----------------
		local M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,M13,M14,M15,M16 = nil
		---------------------------------

		local mesh,meshids,textureids,w

		function fm(parent,meshid,x,y,z,meshtexture)
			if meshid == "cylinder" then
				mesh = Instance.new("CylinderMesh",parent)
				mesh.Scale = Vector3.new(x,y,z)
				return mesh
			else
				mesh = Instance.new("SpecialMesh",parent)
				if meshid ~= "sphere" then
					if type(meshid) == "number" then mesh.MeshId = "rbxassetid://"..meshid else
						mesh.MeshId = "rbxassetid://"..meshids[meshid]
					end
				else mesh.MeshType = 3 end
				mesh.Scale = Vector3.new(x,y,z)
				if meshtexture ~= nil then
					if type(meshtexture) == "number" then 
						mesh.TextureId = "rbxassetid://"..meshtexture 
					else
						mesh.TextureId = "rbxassetid://"..textureids[meshtexture] end
				end
				return mesh
			end
		end

		function P(x,y,z,color,transparency,cancollide,anchored,parent,typee)
			if typee ~= nil then
				c = Instance.new("WedgePart",m)
			else
				c = Instance.new("Part",m)
			end
			c.TopSurface,c.BottomSurface = 0,0
			c.Locked = true
			c.formFactor = "Custom"
			c.Size = Vector3.new(x,y,z)
			if color ~= "random" then
				c.BrickColor = BrickColor.new(color)
			else 
				c.BrickColor = BrickColor:random() 
			end
			c.Transparency = transparency
			c.CanCollide = cancollide
			if anchored ~= nil then 
				c.Anchored = anchored 
			end
			if parent ~= nil then 
				c.Parent = parent 
			end
			return c
		end

		function We(part0,part1,x,y,z,rx,ry,rz,parent)
			w = Instance.new("Motor",m)
			if parent ~= nil then w.Parent = parent end
			w.Part0,w.Part1 = part0,part1
			w.C1 = CFrame.new(x,y,z) * CFrame.Angles(rx,ry,rz)
			return w
		end

		function SetAnimation(id,humanoid)
			if Animating ~= nil then
				Animating:Stop()
			end
			Animate.AnimationId = Asset .. id
			Animating = humanoid:LoadAnimation(Animate)
			Animating:Play()
		end

		function AnimationStop()
			jerk = false
			party = false
			canttouch = false
			happy = false
			spin = false
			thriller = false
			barrel = false
			sax = false
			spooky = false
			stride = false
			shuffle = false
			rock = false
			gagnam = false
			snoop = false
			darude = false
			taco = false
			if barrelbrick ~= nil then
				barrelbrick:Remove()
				barrelbrick = nil
			end
			if saxtool ~= nil then
				saxtool:Remove()
				saxtool = nil
			end
			if sandstorm ~= nil then
				sandstorm:Remove()
				sandstorm = nil
			end
		end

		local Musical
		function SetMusic(id,volume)
			Musical = Instance.new("Sound",char.Head)
			if volume == nil then
				Musical.Volume = 1
			else
				Musical.Volume = volume
			end
			Musical.Looped = true
			Musical.SoundId = Asset .. id
			return Musical
		end

		function GenerateGui()
			a=Instance.new("ScreenGui")
			a.Name = "KrystalDance By KrystalTeam"
			b=Instance.new("ImageLabel",a)
			b.BackgroundTransparency = 1
			b.Size = UDim2.new(0,250,0,100)
			b.Position = UDim2.new(0,0,1,0)
			b.Image = Asset .. "269467798"
			b.Name = "Logo"
			c=Instance.new("Sound",a)
			c.Name = "Intro"
			c.Volume = 1
			c.SoundId = Asset .. "236146895"
			c.Looped = false
			return a
		end

		function Generate(player)
			char = player.Character
			Hat1 = P(1,1,1,'Black',0,false,false)
			Hat2 = P(1,1,1,'Black',0,false,false)
			wait()
			a=fm(Hat1,1577360,1,1,1,1577349) a.VertexColor = Vector3.new(1,1,1)
			b=fm(Hat2,13640868,1,1,1,18987684) b.VertexColor = Vector3.new(1,1,1)
			wait()
			if char:FindFirstChild("Head") then
				We(Hat1,char.Head,0,0.25,-0.135,0,0,0)
				We(Hat2,char.Head,0,0.8,0,0,0,0)
				if char.Head:FindFirstChild("face") ~= nil then
					face = char.Head:FindFirstChild("face")
					face.Texture = "rbxasset://textures/face.png"
				end
				c=char.Head:clone()
				c.Name = "FalseHead"
				c.CanCollide = false
				c.Parent = char
				We(c,char.Head,0,0,0,0,0,0)
				char.Head.Transparency = 1
				for i,v in pairs(char:GetChildren()) do
					if v.ClassName == "Shirt" or v.ClassName == "Pants" or v.ClassName == "Hat" or v.ClassName == "CharacterMesh" or v.ClassName == "Shirt Graphic" then
						v:Remove()
					end
					if v.ClassName == "BodyColors" then
						v.HeadColor = BrickColor.new("White")
						v.LeftArmColor = BrickColor.new("Really black")
						v.LeftLegColor = BrickColor.new("Really black")
						v.RightArmColor = BrickColor.new("Really black")
						v.RightLegColor = BrickColor.new("Really black")
						v.TorsoColor = BrickColor.new("Really black")
					end
					if v.ClassName == "Part" then
						if v.Name == "Head" or v.Name == "FalseHead" then
							v.BrickColor = BrickColor.new("White")
						else
							v.BrickColor = BrickColor.new("Really black")
						end
					end
				end
				----------musics---------------
				M1=SetMusic(168007346)
				M2=SetMusic(144901116)
				M3=SetMusic(168570436)
				M4=SetMusic(142435409)
				M5=SetMusic(131525189)
				M6=SetMusic(133196268)
				M7=SetMusic(130791919)
				M8=SetMusic(130794684)
				M9=SetMusic(155313239)
				M10=SetMusic(158036870)
				M11=SetMusic(145262991)
				M12=SetMusic(151430448)
				M13=SetMusic(130844430)
				M14=SetMusic(172388329)
				M15=SetMusic(179534184)
				M16=SetMusic(142295308)
				-------------------------------

				if char:FindFirstChild("HumanoidRootPart") ~= nil then
					rootpart = char:FindFirstChild("HumanoidRootPart")
				end
				if showtag == true then
					local bbg = Instance.new("BillboardGui",c)
					bbg.Adornee = c
					bbg.Name = "satuttava"
					bbg.Size = UDim2.new(6,0,2,0)
					bbg.StudsOffset = Vector3.new(0,2,0)
					local box = Instance.new("TextLabel",bbg)
					box.Size = UDim2.new(1,0,1,0)
					box.BackgroundColor = BrickColor.new("White")
					box.TextColor3 = Color3.new(255,0,0)
					box.TextStrokeTransparency = 0.5
					box.Font = 3
					box.Text = Player.Name
					box.BackgroundTransparency = 1
					box.Position = UDim2.new(0,0,0,0)
					box.TextScaled = true
				end
				if char:FindFirstChild("Humanoid") ~= nil then
					char:FindFirstChild("Humanoid").MaxHealth = (100*100*100*100)*100
					wait()
					char:FindFirstChild("Humanoid").Health = char:FindFirstChild("Humanoid").MaxHealth
					--char:FindFirstChild("Humanoid").Name = Player.Name
					humanoid = char:FindFirstChild("Humanoid")
					if humanoid:FindFirstChild("Animator") ~= nil then
						humanoid:FindFirstChild("Animator"):Remove()
						--Instance.new("Animator",humanoid)
					end
					if char:FindFirstChild("Animate") ~= nil then
						char:FindFirstChild("Animate"):Remove()
					end
				end
				Mouse = player:GetMouse()
				Music = Instance.new("Sound",char.Head)
				Music.Volume = 1
				Music.Looped = true
				Music.SoundId = Asset
				Animate = Instance.new("Animation",char.Head)
				Animate.AnimationId = Asset



				head = char:FindFirstChild("Head")
				torso = char:FindFirstChild("Torso")
				ra = char:findFirstChild("Right Arm")
				la = char:findFirstChild("Left Arm")
				rl = char:findFirstChild("Right Leg")
				ll = char:findFirstChild("Left Leg")
				rs = torso:findFirstChild("Right Shoulder")
				ls = torso:findFirstChild("Left Shoulder")
				rh = torso:findFirstChild("Right Hip")
				lh = torso:findFirstChild("Left Hip")
				neck = torso:findFirstChild("Neck")
				rj = char:findFirstChild("HumanoidRootPart"):findFirstChild("RootJoint")

				state = humanoid:GetState()
				local ca = nil
				ca=GenerateGui()
				ca.Parent = player.PlayerGui
				if ca:FindFirstChild("Logo") ~= nil then
					ca:FindFirstChild("Logo"):TweenPosition(UDim2.new(0, 0, 1, -100), "Out", "Quad", 3, true)
					if ca:FindFirstChild("Intro") ~= nil then
						ca:FindFirstChild("Intro"):Play()
						coroutine.resume(coroutine.create(function() 
							for i=0,30 do
								ca:FindFirstChild("Intro").Volume = 1/(i/2)
								wait(0.5)
								if i >= 30 then
									break
								end
							end
						end))
					end
				end

				if humanoid ~= nil then
					humanoid.Changed:connect(function(pro)
						if pro == "MoveDirection" or pro == "Jump" then
							if Music.IsPlaying == true then
								AnimationStop()
							end
						end
					end)
					humanoid.Died:connect(function()
						AnimationStop()
					end)

					Mouse.KeyUp:connect(function(key) 
						if key == "w" then
							W = false
						end
						if key == "a" then
							A = false
						end
						if key == "s" then
							S = false
						end
						if key == "d" then
							D = false
						end
						if string.byte(key) == 48 then
							run = false
						end
					end)

					Mouse.KeyDown:connect(function(key) 
						if key == "w" then
							W = true
							AnimationStop()
						end
						if key == "a" then
							A = true
							AnimationStop()
						end
						if key == "s" then
							S = true
							AnimationStop()
						end
						if key == "d" then
							D = true
							AnimationStop()
						end
					end)



					Mouse.KeyDown:connect(function(key) 
						KeyUsed(key)
					end)
				end
			end
			print'KrystalDance By: KrystalTeam as fully Loaded!'
		end

		function KeyUsed(key)
			if humanoid ~= nil then
				if humanoid.Health > 0 then
					if string.byte(key) == 32 then
						jump = true
						AnimationStop()
						--sit = false
					end
					if string.byte(key) == 50 then
						AnimationStop()
						if sit == true then
							sit = false
						else
							sit = true
						end
					end
					if string.byte(key) == 48 then
						run = true
					end
					if W == false and A == false and S == false and D == false and jump == false and sit == false then
						if key == "Q" or key == "q" then
							AnimationStop()
							canttouch = true
							M1:Play()
						end
						if key == "E" or key == "e" then
							AnimationStop()
							party = true
							M2:Play()
						end
						if key == "R" or key == "r" then
							AnimationStop()
							jerk = true
							M3:Play()
						end
						if key == "T" or key == "t" then
							AnimationStop()
							happy = true
							M4:Play()
						end
						if key == "Y" or key == "y" then
							AnimationStop()
							spin = true
							M5:Play()
						end
						if key == "U" or key == "u" then
							AnimationStop()
							thriller = true
							M6:Play()
						end
						if key == "F" or key == "f" then
							AnimationStop()
							barrel = true
							M7:Play()
							if barrelbrick == nil and barrel == true then
								barrelbrick = P(2,2,1,'Black',0,false,false)
								a=fm(barrelbrick,29873142,1.1,0.8,1.1,31082268) a.VertexColor = Vector3.new(1,1,1)
								We(barrelbrick,char.Torso,0,-0.2,0,0,0,0)
							end
						end
						if key == "P" or key == "p" then
							AnimationStop()
							sax = true
							M8:Play()
							if saxtool == nil and sax == true then
								saxtool = P(1,2,2,'Black',0,false,false)
								a=fm(saxtool,44410178,1.5,1.5,1.5,44410320) a.VertexColor = Vector3.new(1,1,1)
								b=We(saxtool,char:FindFirstChild("Left Arm"),0,-1,0,0,0,0)
								b.C1 = CFrame.new(0.5, -0.9, -0.3) * CFrame.Angles(math.pi/1.5, -math.pi/2, -math.pi/8)
							end
						end
						if key == "G" or key == "g" then
							AnimationStop()
							spooky = true
							M9:Play()
						end
						if key == "H" or key == "h" then
							AnimationStop()
							stride = true
							M10:Play()
						end
						if key == "J" or key == "j" then
							AnimationStop()
							shuffle = true
							M11:Play()
						end
						if key == "K" or key == "k" then
							AnimationStop()
							rock = true
							M12:Play()
						end
						if key == "L" or key == "l" then
							AnimationStop()
							gagnam = true
							M13:Play()
						end
						if key == "Z" or key == "z" then
							AnimationStop()
							snoop = true
							M14:Play()
						end
						if key == "X" or key == "x" then
							AnimationStop()
							darude = true
							M15:Play()
							if sandstorm == nil and darude == true then
								sandstorm = P(1,1,1,'Black',0,false,false)
								sandstorm.Transparency = 1
								a=Instance.new("Smoke",sandstorm)
								a.Color = Color3.new(255/255,255/255,175/255)
								a.Size = 0.4
								a.RiseVelocity = 3
								a.Opacity = 0.75
								b=We(sandstorm,char:FindFirstChild("Torso"),0,0,0,0,0,0)
								b.C1 = CFrame.new(0, -2, 0)
							end
						end
						if key == "C" or key == "c" then
							AnimationStop()
							taco = true
							M16:Play()
						end
					end
				end
			end
		end

		Generate(Player)

		game:service'RunService'.Stepped:connect(function()
			count = (count % 100) + countspeed
			angle = math.pi * math.sin(math.pi*2/100*count)
			countspeed = 1

			state = humanoid:GetState()
			if state ~= Enum.HumanoidStateType.Freefall then
				jump = false
			else
				jump = true
				sit = false
				AnimationStop()
			end

			local mesh1anan = Instance.new("SpecialMesh")
			mesh1anan.MeshType = Enum.MeshType.FileMesh
			mesh1anan.Scale = Vector3.new(3,3,3)
			mesh1anan.MeshId = "http://www.roblox.com/asset/?id=14846869"
			mesh1anan.TextureId = "http://www.roblox.com/asset/?id=14846834"
			if taco == true then
				if char ~= nil then
					local locationanan = char:GetModelCFrame()
					local tacoa = Instance.new("Part")
					tacoa.CanCollide = false
					tacoa.RotVelocity = Vector3.new(math.random()*math.pi,math.random()*math.pi,math.random()*math.pi)
					local meshanananan = mesh1anan:clone()
					meshanananan.Parent = tacoa
					meshanananan.Scale = Vector3.new(math.random()*20,math.random()*20,math.random()*20)
					tacoa.CFrame = locationanan * CFrame.new(math.random()*500 - 250,math.random(100,200),math.random()*500 - 250)
					tacoa.Parent = workspace
					game:GetService("Debris"):AddItem(tacoa,4)
				end
			end




			if canttouch == false then	
				M1:Stop()
			end
			if party == false then	
				M2:Stop()
			end
			if jerk == false then	
				M3:Stop()
			end
			if happy == false then	
				M4:Stop()
			end
			if spin == false then	
				M5:Stop()
			end
			if thriller == false then	
				M6:Stop()
			end
			if barrel == false then	
				M7:Stop()
			end
			if sax == false then	
				M8:Stop()
			end
			if spooky == false then	
				M9:Stop()
			end
			if stride == false then	
				M10:Stop()
			end
			if shuffle == false then	
				M11:Stop()
			end
			if rock == false then
				M12:Stop()
			end
			if gagnam == false then
				M13:Stop()
			end
			if snoop == false then
				M14:Stop()	
			end
			if darude == false then
				M15:Stop()
			end
			if taco == false then
				M16:Stop()
			end

			if run == true and sit == false then
				humanoid.WalkSpeed = 25
			elseif sit == true then
				humanoid.WalkSpeed = 0
			else
				humanoid.WalkSpeed = 16
			end

			if global_wait == 380 then global_wait = 0 end

			if (W == false or A == false or S == false or D == false) and jump == false and sit == false then
				ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, 0 - angle/75)
				rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, 0 - angle/75)
				lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 + angle/75)
				rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 + angle/75)
				neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/75, math.pi, 0)
				rj.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.pi/2, math.pi, 0)
			end


			if (W == false or A == false or S == false or D == false) and jump == false and sit == true then
				local ray = Ray.new(torso.Position, Vector3.new(0, -3, 0))
				local hitz,enz = workspace:FindPartOnRay(ray, char)
				if hitz then
					if rootpart:FindFirstChild("Weld") == nil then
						miniweld = Instance.new("Weld", rootpart)
						miniweld.C0 = hitz.CFrame:toObjectSpace(rootpart.CFrame)
						miniweld.Part0 = hitz
						miniweld.Part1 = rootpart
						humanoid.PlatformStand = true
					end
				end
			else
				if rootpart:FindFirstChild("Weld") ~= nil then
					rootpart:FindFirstChild("Weld"):Destroy()
					humanoid.PlatformStand = false
				end
			end

			if (W == false or A == false or S == false or D == false) and jump == false and sit == true then
				ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, 0 - math.pi/15)
				rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, 0 + math.pi/15)
				lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0 + math.pi/8, 0, math.pi/2 - math.pi/15)
				rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0 + math.pi/8, 0, -math.pi/2 + math.pi/15)
				neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + math.pi/15, math.pi, 0)
				rj.C0 = CFrame.new(0, -2, 0) * CFrame.Angles(math.pi/2 + math.pi/15, math.pi, 0)
			end

			if jump == true and sit == false then
				countspeed = 2
				ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, math.pi + angle/12)
				rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, math.pi + angle/12)
				lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 + angle/12)
				rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 + angle/12)
				neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/25, math.pi, 0)
				rj.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.pi/2+ angle/50, math.pi, 0)
			end

			if (W == true or A == true or S == true or D == true) and jump == false and sit == false then
				if run == true then
					countspeed = 4
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, 0 - angle/3)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, 0 - angle/3)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 + angle/5)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 + angle/5)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/20, math.pi, 0)
					rj.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.pi/2 + angle/40, math.pi, 0)
				else
					countspeed = 2
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, 0 - angle/4)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, 0 - angle/4)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 + angle/6)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 + angle/6)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/25, math.pi, 0)
					rj.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.pi/2+ angle/50, math.pi, 0)
				end
			end

			if W == false and A == false and S == false and D == false and jump == false and sit == false then
				if jerk == true and jump == false and sit == false then
					countspeed = 2
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(angle/5, 0, angle/4)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(angle/5, 0, -angle/4)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(angle/10, 0, angle/5)-- * CFrame.Angles(angle*0.5, 0, -math.abs(angle*0.15))
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(angle/10, 0, angle/5)-- * CFrame.Angles(-angle*0.5, 0, math.abs(angle*0.15))
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/5, math.pi, 0)
					rj.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.pi/2 + angle/5, math.pi, 0)
				elseif party == true and jump == false and sit == false then
					countspeed = 4
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(angle/15, 0, angle/15)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(angle/15, 0, angle/15)
					ls.C1 = CFrame.new(0.25,0.5 + 1 * angle/10,0.5) * CFrame.Angles(math.pi  + angle/10, 0, 0 + angle/10)
					rs.C1 = CFrame.new(-0.25,0.5 + 1 * angle/10,0.5) * CFrame.Angles(math.pi  + angle/10, 0, 0  + angle/10)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/10, math.pi, 0)
					rj.C0 = CFrame.new(0, 0.5 + angle/5, 0) * CFrame.Angles(math.pi/2, math.pi, 0)
				elseif canttouch == true and jump == false and sit == false then
					countspeed = 2
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0 + angle/8, 0, math.pi/12 + angle/12)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0 + angle/8, 0, -math.pi/12 - angle/12)
					lh.C1 = CFrame.new(0.35,0.7,0.5) * CFrame.Angles(0 + angle/10, 0, -math.pi/8)
					rh.C1 = CFrame.new(-0.35,0.7,0.5) * CFrame.Angles(0 + angle/10, 0, math.pi/8)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/15, math.pi, 0)
					rj.C0 = CFrame.new(angle/4, -0.3 + angle/20, 0) * CFrame.Angles(math.pi/2, math.pi, 0)
				elseif happy == true and jump == false and sit == false then
					countspeed = 4
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(math.pi/4, math.pi/8 + angle/8, math.pi/4 + angle/8)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(math.pi/4, -math.pi/8 + angle/8, -math.pi/4 + angle/8)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0 + angle/10, 0, 0  + angle/10)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0 + angle/10, 0, 0  + angle/10)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/15, math.pi + angle/15, 0 + angle/15)
					rj.C0 = CFrame.new(0, 0 + angle/20, 0) * CFrame.Angles(math.pi/2, math.pi, 0)
				elseif spin == true and jump == false and sit == false then
					global_wait = (global_wait % 360) + 4
					countspeed = 4
					ls.C1 = CFrame.new(0,1,0) * CFrame.Angles(math.pi/2, 0 + angle/10, 0 + angle/10)
					rs.C1 = CFrame.new(0,1,0) * CFrame.Angles(math.pi/2, 0 - angle/10, 0 + angle/10)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0 + angle/10, 0 + angle/10, 0  + angle/10)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0 + angle/10, 0 + angle/10, 0  + angle/10)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2, math.pi, 0)
					rj.C0 = CFrame.new(0 + angle/25, 0, 0 - angle/25) * CFrame.Angles(math.pi/2, math.pi, math.rad(global_wait*4))
				elseif thriller == true and jump == false and sit == false then
					countspeed = 2
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, math.pi/2 + angle/15)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, -math.pi/2 + angle/15)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(math.pi/60 - angle/45, 0, 0 + angle/15)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(math.pi/60 + angle/45, 0, 0 + angle/15)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/15, math.pi + angle/10, 0)
					rj.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.pi/2 + angle/50 , math.pi + angle/50, 0 + angle/50)
				elseif barrel == true and jump == false and sit == false then
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, math.pi)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, math.pi)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2, math.pi, 0)
					rj.C0 = CFrame.new(0 + angle, -1.8, 0) * CFrame.Angles(0, math.pi, 0 + angle)
				elseif sax == true and jump == false and sit == false then
					countspeed = 2
					ls.C1 = CFrame.new(0,0.75,-0.25) * CFrame.Angles(-math.pi/5, 0, math.pi/2 - math.abs(angle/30))
					rs.C1 = CFrame.new(0,0.75,-0.25) * CFrame.Angles(-math.pi/5, 0, -math.pi/2 + math.abs(angle/30))
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 - math.abs(angle/30))
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 + math.abs(angle/30))
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2, math.pi, 0)
					rj.C0 = CFrame.new(0, -math.abs(angle*0.05), math.abs(angle*0.025)) * CFrame.Angles(math.pi/2 + math.abs(angle/20), math.pi, 0)
				elseif spooky == true and jump == false and sit == false then
					countspeed = 3
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, math.pi/2 - angle/1.5)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, -math.pi/2 + angle/1.5)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 - angle/16)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 + angle/16)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2  + angle/12, math.pi, 0)
					rj.C0 = CFrame.new(0, 0 + angle / 35, 0) * CFrame.Angles(math.pi/2 + angle/25, math.pi, 0)
				elseif stride == true and jump == false and sit == false then
					countspeed = 2.5
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(angle/16, angle/16,math.pi/3.5 + angle/8)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(angle/16, -angle/16,-math.pi/1.5 + -angle/8)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, angle/16, angle/16)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, angle/16, angle/16)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2, math.pi, 0)
					rj.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.pi/2-angle/16, math.pi, 0)
				elseif shuffle == true and jump == false and sit == false then
					countspeed = 2
					ls.C1 = CFrame.new(0,0.75,-0.35) * CFrame.Angles(math.pi/8, 0, math.pi/2 + angle/3.5)
					rs.C1 = CFrame.new(0,0.75,-0.35) * CFrame.Angles(math.pi/8, 0, -math.pi/2 + angle/3.5)
					lh.C1 = CFrame.new(0 + angle/50,1,0.5) * CFrame.Angles(0, 0 + angle/35, 0 + angle/15)
					rh.C1 = CFrame.new(0 + angle/50,1,0.5) * CFrame.Angles(0, 0 + angle/35, 0 + angle/15)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/15, math.pi, 0)
					rj.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.pi/2 - angle/35, math.pi - angle/35, 0)
				elseif rock == true and jump == false and sit == false then
					countspeed = 4
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, math.pi/2+angle/2)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, -math.pi/2+angle/2)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0+angle/32, 0, 0+angle/32)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0+angle/32, 0, 0-angle/32)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2, math.pi, 0)
					rj.C0 = CFrame.new(0, 0 - angle/50, 0) * CFrame.Angles(math.pi/2, math.pi, 0)
				elseif gagnam == true and jump == false and sit == false then
					countspeed = 4
					ls.C1 = CFrame.new(0,0.75,-0.15) * CFrame.Angles(-math.pi/4, 0, (math.pi/2 + angle/14) - math.pi/20)
					rs.C1 = CFrame.new(0,0.75,-0.15) * CFrame.Angles(-math.pi/4, 0, (-math.pi/2 - angle/14) + math.pi/20)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0 + angle/16, 0, 0)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0 + angle/16, 0, 0)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 + angle/20, math.pi, 0)
					rj.C0 = CFrame.new(0, 0 + angle/40, 0) * CFrame.Angles(math.pi/2, math.pi, 0)
				elseif snoop == true and jump == false and sit == false then
					countspeed = 2
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(math.pi/12, 0, math.pi/4 + angle/4)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(math.pi/12, 0, -math.pi/4 + angle/4)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(math.pi/24, 0, 0 + angle/4)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(math.pi/24, 0, 0 + angle/4)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 - angle/8, math.pi, 0)
					rj.C0 = CFrame.new(0, 0 + angle/48, 0) * CFrame.Angles(math.pi/2 + angle/24, math.pi, 0)
				elseif darude == true and jump == false and sit == false then
					countspeed = 3
					ls.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, 0 + angle/1.5)
					rs.C1 = CFrame.new(0,0.5,-0.5) * CFrame.Angles(0, 0, 0 + angle/3)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 - angle/3)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, 0 - angle/1.5)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2, math.pi, 0)
					rj.C0 = CFrame.new(0, 0+ angle/45, 0) * CFrame.Angles(math.pi/2 - angle/6, math.pi, 0)
				elseif taco == true and jump == false and sit == false then
					countspeed = 4
					global_wait = (global_wait % 360) + 4
					ls.C1 = CFrame.new(0,1,-0.25) * CFrame.Angles(math.pi/6 + angle/12, 0, math.pi)
					rs.C1 = CFrame.new(0,1,-0.25) * CFrame.Angles(math.pi/6 + angle/12, 0, math.pi)
					lh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, math.pi/8 + angle/16)
					rh.C1 = CFrame.new(0,1,0.5) * CFrame.Angles(0, 0, math.pi/8 + angle/16)
					neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(math.pi/2 - math.pi/8 + angle/16, math.pi, 0)
					rj.C0 = CFrame.new(0, 0.25 + angle/12, 0) * CFrame.Angles(math.pi/2, math.pi, math.rad(global_wait*4))
				end
			end
		end)
	elseif isCmd(cmd, {"toadroast"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		wait(1)
		local function findRemoteEvent(name)
			local replicatedStorage = game:GetService("ReplicatedStorage")
			local workspace = game:GetService("Workspace")
			for _, parent in ipairs({replicatedStorage, workspace}) do
				for _, child in ipairs(parent:GetDescendants()) do
					if child:IsA("RemoteEvent") and child.Name == name then
						return child
					end
				end
			end
			return nil
		end
		math.randomseed(tick() % 1 * 1e6)
		del = coroutine.create(function()
			while wait(0.3) do
				for i,v in pairs(workspace:GetChildren()) do
					if v:IsA("Model") then
						delete(v)
					end
				end
			end
		end)



		for i,v in pairs(Players:GetChildren()) do
		end

		sound = coroutine.create(function()
			local remote = findRemoteEvent("AC6_FE_Sounds")
			remote:FireServer("newSound", "rainin", workspace, "rbxassetid://127260964285894", 0.25, 10, true)
			remote:FireServer("playSound", "rainin")
			while wait(0.2) do
				rainin = workspace:FindFirstChild("RAINING MEN")
				if not rainin then
					a = Instance.new("Sound",workspace)
					a.SoundId = "rbxassetid://141509625"
					a.Name = "RAINING MEN"
					a.Volume = 58359
					a.Looped = true
					a:Play()
				end
			end
		end)
		coroutine.resume(del)
		coroutine.resume(sound)
	elseif isCmd(cmd, {"cmds"}) then
		if ScreenGui:FindFirstChild("cmds") then
			ScreenGui.cmds:Destroy()
		end
		local frame = Instance.new("Frame", ScreenGui)
		frame.Name = "cmds"
		frame.Size = UDim2.new(0.4, 0, 0.4, 0)
		frame.Position = UDim2.new(0.3, 0, 0.3, 0)
		frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		frame.BorderSizePixel = 0
		frame.ClipsDescendants = true
		local uicorner = Instance.new("UICorner", frame)
		uicorner.CornerRadius = UDim.new(0, 8)
		local title = Instance.new("TextLabel", frame)
		title.Size = UDim2.new(1, 0, 0, 30)
		title.BackgroundTransparency = 1
		title.Text = "Eazy Admin Commands"
		title.TextColor3 = Color3.new(1, 1, 1)
		title.Font = Enum.Font.GothamBold
		title.TextSize = 18
		local searchBox = Instance.new("TextBox", frame)
		searchBox.Text = ""
		searchBox.Size = UDim2.new(1, -10, 0, 24)
		searchBox.Position = UDim2.new(0, 5, 0, 30)
		searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		searchBox.TextColor3 = Color3.new(1, 1, 1)
		searchBox.PlaceholderText = "Search commands..."
		searchBox.Font = Enum.Font.Code
		searchBox.TextSize = 16
		searchBox.BorderSizePixel = 0
		searchBox.ClearTextOnFocus = false
		local scroll = Instance.new("ScrollingFrame")
		scroll.Position = UDim2.new(0, 0, 0, 60)
		scroll.Size = UDim2.new(1, 0, 1, -60)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 4
		scroll.ScrollingDirection = Enum.ScrollingDirection.Y
		scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		scroll.ClipsDescendants = true
		scroll.Parent = frame
		local layout = Instance.new("UIListLayout", scroll)
		layout.SortOrder = Enum.SortOrder.Name
		layout.Padding = UDim.new(0, 4)
		local allCommandLabels = {}
		local function addCommandLine(text)
			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -10, 0, 24)
			label.BackgroundTransparency = 1
			label.TextColor3 = Color3.new(1, 1, 1)
			label.Font = Enum.Font.Code
			label.TextSize = 16
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextWrapped = true
			label.Text = text
			label.Name = text
			label.Parent = scroll
			table.insert(allCommandLabels, label)
		end
		for alias, _ in pairs(knownCmds) do
			addCommandLine(";" .. alias)
		end
		searchBox:GetPropertyChangedSignal("Text"):Connect(function()
			local keyword = searchBox.Text:lower()
			for _, label in ipairs(allCommandLabels) do
				label.Visible = keyword == "" or label.Text:lower():find(keyword, 1, true)
			end
		end)
		local close = Instance.new("TextButton", frame)
		close.Size = UDim2.new(0, 24, 0, 24)
		close.Position = UDim2.new(1, -28, 0, 4)
		close.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
		close.Text = "X"
		close.TextColor3 = Color3.new(1, 1, 1)
		close.Font = Enum.Font.GothamBold
		close.TextSize = 14
		local corner = Instance.new("UICorner", close)
		corner.CornerRadius = UDim.new(1, 0)
		close.MouseButton1Click:Connect(function()
			frame:Destroy()
		end)
	end
end)
