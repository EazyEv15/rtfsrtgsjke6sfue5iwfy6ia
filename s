game.StarterGui:SetCore("SendNotification", {
	Title = "eazy admin", 
	Text = "loaded",
	Duration = 5
})
local Players = game:GetService("Players")
local Player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
Player:WaitForChild("PlayerGui")
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
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "eazy-admin"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.5, 0, 0, 36)
TextBox.Position = UDim2.new(0.25, 0, 0.95, -50)
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.BackgroundTransparency = 0.1
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.PlaceholderText = ";command"
TextBox.ClearTextOnFocus = false
TextBox.Text = ""
TextBox.Font = Enum.Font.GothamSemibold
TextBox.TextSize = 18
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Center
TextBox.BorderSizePixel = 0
TextBox.ZIndex = 1
TextBox.Parent = ScreenGui
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = TextBox
local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.Parent = TextBox
local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 8)
ShadowCorner.Parent = Shadow

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Semicolon then
		TextBox:CaptureFocus()
	end
end)
local touchflingEnabled = false
local touchflingThread

local function processCommand(msg)
	if string.sub(msg, 1, 1) ~= ";" then return end

	local args = msg:sub(2):lower():split(" ")
	local cmd = args[1]
	if isCmd(cmd, {"save"}) then
		saveinstance()
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
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EazyEv15/rtfsrtgsjke6sfue5iwfy6ia/refs/heads/main/alogger"))()
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
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EazyEv15/rtfsrtgsjke6sfue5iwfy6ia/refs/heads/main/kartic"))()
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
	elseif isCmd(cmd, {"serverhop"}) then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Player)
	elseif isCmd(cmd, {"ac6"}) then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Roblox-HttpSpy/my-Garbage/refs/heads/main/FeMusicExploit.lua"))()
	elseif isCmd(cmd, {"quirkycmd"}) then
		loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
	elseif isCmd(cmd, {"fencingfucker"}) then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EazyEv15/rtfsrtgsjke6sfue5iwfy6ia/refs/heads/main/fencing"))()
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
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EazyEv15/rtfsrtgsjke6sfue5iwfy6ia/refs/heads/main/server"))()
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
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EazyEv15/rtfsrtgsjke6sfue5iwfy6ia/refs/heads/main/gonna"))()
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
			remote:FireServer("playSound", "Sound2")
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
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EazyEv15/rtfsrtgsjke6sfue5iwfy6ia/refs/heads/main/krystal"))()
	elseif isCmd(cmd, {"john"}) then
		if not _G.QuirkyCMDLoaded then
			_G.QuirkyCMDLoaded = true
			pcall(function()
				loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
			end)
		end
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EazyEv15/rtfsrtgsjke6sfue5iwfy6ia/refs/heads/main/johndoe"))()
	elseif isCmd(cmd, {"panel"}) then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EazyEv15/rtfsrtgsjke6sfue5iwfy6ia/refs/heads/main/panel"))()
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
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EazyEv15/rtfsrtgsjke6sfue5iwfy6ia/refs/heads/main/krystalv1"))()
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
		frame.Size = UDim2.new(0.45, 0, 0.5, 0)
		frame.Position = UDim2.new(0.275, 0, 0.25, 0)
		frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		frame.BorderSizePixel = 0
		frame.ClipsDescendants = true

		local uicorner = Instance.new("UICorner", frame)
		uicorner.CornerRadius = UDim.new(0, 12)
		local title = Instance.new("TextLabel", frame)
		title.Size = UDim2.new(1, -40, 0, 40)
		title.Position = UDim2.new(0, 16, 0, 0)
		title.BackgroundTransparency = 1
		title.Text = "Eazy Admin Commands"
		title.TextColor3 = Color3.new(1, 1, 1)
		title.Font = Enum.Font.GothamBold
		title.TextSize = 20
		title.TextXAlignment = Enum.TextXAlignment.Left
		local close = Instance.new("TextButton", frame)
		close.Size = UDim2.new(0, 28, 0, 28)
		close.Position = UDim2.new(1, -36, 0, 6)
		close.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
		close.Text = "X"
		close.TextColor3 = Color3.new(1, 1, 1)
		close.Font = Enum.Font.GothamBold
		close.TextSize = 16
		close.AutoButtonColor = true

		local closeCorner = Instance.new("UICorner", close)
		closeCorner.CornerRadius = UDim.new(1, 0)

		close.MouseButton1Click:Connect(function()
			frame:Destroy()
		end)
		local searchBox = Instance.new("TextBox", frame)
		searchBox.Text = ""
		searchBox.Size = UDim2.new(1, -32, 0, 28)
		searchBox.Position = UDim2.new(0, 16, 0, 48)
		searchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		searchBox.TextColor3 = Color3.new(1, 1, 1)
		searchBox.PlaceholderText = "Search commands..."
		searchBox.Font = Enum.Font.Code
		searchBox.TextSize = 16
		searchBox.BorderSizePixel = 0
		searchBox.ClearTextOnFocus = false
		local searchCorner = Instance.new("UICorner", searchBox)
		searchCorner.CornerRadius = UDim.new(0, 6)
		local scroll = Instance.new("ScrollingFrame")
		scroll.Position = UDim2.new(0, 12, 0, 88)
		scroll.Size = UDim2.new(1, -24, 1, -100)
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.ScrollBarThickness = 6
		scroll.ScrollingDirection = Enum.ScrollingDirection.Y
		scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		scroll.ClipsDescendants = true
		scroll.Parent = frame
		local layout = Instance.new("UIListLayout", scroll)
		layout.SortOrder = Enum.SortOrder.Name
		layout.Padding = UDim.new(0, 6)
		local allCommandLabels = {}
		local function addCommandLine(text)
			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -10, 0, 24)
			label.BackgroundTransparency = 1
			label.TextColor3 = Color3.fromRGB(220, 220, 220)
			label.Font = Enum.Font.Code
			label.TextSize = 16
			label.TextXAlignment = Enum.TextXAlignment.Left
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
	end
end
TextBox.FocusLost:Connect(function(enterPressed)
	if not enterPressed then return end
	local msg = TextBox.Text
	TextBox.Text = ""
	processCommand(msg)
end)

Player.Chatted:Connect(function(msg)
	processCommand(msg)
end)
