local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local speed = 60
local flying = false
local humanoid
local oldPlatformStand
local oldAutoRotate

local previous = getgenv().__simpleFly
if previous then
	previous()
end

local function stopFlying()
	flying = false
	if humanoid and humanoid.Parent then
		humanoid.PlatformStand = oldPlatformStand
		humanoid.AutoRotate = oldAutoRotate
		local root = humanoid.RootPart
		if root then
			root.AssemblyLinearVelocity = Vector3.zero
		end
	end
	humanoid = nil
end

local inputConnection = UserInputService.InputBegan:Connect(function(input, processed)
	if processed or input.KeyCode ~= Enum.KeyCode.F then
		return
	end
	if flying then
		stopFlying()
		return
	end
	local character = player.Character
	local currentHumanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not currentHumanoid or not currentHumanoid.RootPart then
		return
	end
	humanoid = currentHumanoid
	oldPlatformStand = humanoid.PlatformStand
	oldAutoRotate = humanoid.AutoRotate
	humanoid.PlatformStand = true
	humanoid.AutoRotate = false
	flying = true
end)

local frameConnection = RunService.RenderStepped:Connect(function()
	if not flying or not humanoid then
		return
	end
	local root = humanoid.RootPart
	local camera = workspace.CurrentCamera
	if not root or not camera then
		stopFlying()
		return
	end

	local forward = Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z)
	if forward.Magnitude < 0.01 then
		forward = Vector3.new(root.CFrame.LookVector.X, 0, root.CFrame.LookVector.Z)
	end
	forward = forward.Unit
	local right = Vector3.new(camera.CFrame.RightVector.X, 0, camera.CFrame.RightVector.Z).Unit
	local direction = Vector3.zero
	if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction += forward end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction -= forward end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction += right end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction -= right end
	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.yAxis end
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction -= Vector3.yAxis end

	root.AssemblyLinearVelocity = direction.Magnitude > 0 and direction.Unit * speed or Vector3.zero
end)

getgenv().__simpleFly = function()
	stopFlying()
	inputConnection:Disconnect()
	frameConnection:Disconnect()
	getgenv().__simpleFly = nil
end

print("Simple Fly ready: F toggles, WASD moves, Space rises, Left Ctrl descends")
