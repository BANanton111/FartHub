local player = game.Players.LocalPlayer
local charecter = player.Character

local function Sound()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://6445594239" -- замени на настоящий SoundId
	sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	sound.Looped = true
	sound.Volume = 2
	sound:Play()
	
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://9081625499" -- замени на настоящий SoundId
	sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	sound.Looped = true
	sound.Volume = 5
	sound:Play()
	task.wait(3)
	
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://118941947094338" -- замени на настоящий SoundId
	sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	sound.Looped = false
	sound.Volume = 10
	sound:Play()
end

task.spawn(Sound)

charecter.Humanoid.Died:Connect(function()
	task.spawn(Sound)
end)


local Gui = Instance.new("ScreenGui")
Gui.Parent = player:WaitForChild("PlayerGui") -- Убедимся, что PlayerGui загружен

local frame = Instance.new("Frame")
frame.BackgroundTransparency = 0.5
frame.Parent = Gui
frame.Position = UDim2.new(0.36, 0,0.255, 0) -- без скобок и без {}
frame.Size = UDim2.new(0, 535, 0, 309)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

local text = Instance.new("TextLabel")
text.Position = UDim2.new(0.447, 0, 0.298, 0)
text.Size = UDim2.new(0, 200, 0, 50)
text.ZIndex = 2
text.Parent = Gui
text.Text = "Взлом Жопы Пасмотри на верх"
text.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.BackgroundTransparency = 0.5
text.TextScaled = true

local parcent = Instance.new("TextLabel")
parcent.Position = UDim2.new(0.396, 0,0.512, 0)
parcent.Size = UDim2.new(0, 400, 0, 100)
parcent.ZIndex = 2
parcent.Parent = Gui
parcent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
parcent.TextColor3 = Color3.fromRGB(255, 255, 255)
parcent.BackgroundTransparency = 0.5
parcent.TextScaled = true

local function x()
	for i = 0, 100, 1 do
		task.wait(0.1)
		parcent.Text = (i.."%")
		if i % 13 == 0 then
			task.wait(0.2)
		end
	end
end
task.spawn(x)



-- Создаём модель
local nukeModel = Instance.new("Model")
nukeModel.Name = "NuclearBomb_BIG"

-- Основной корпус
local body = Instance.new("Part")
body.Name = "Body"
body.Size = Vector3.new(20, 60, 20)
body.Anchored = false
body.Position = Vector3.new(0, 50, 0)
body.BrickColor = BrickColor.new("Dark stone grey")
body.Material = Enum.Material.Metal
body.TopSurface = Enum.SurfaceType.Smooth
body.BottomSurface = Enum.SurfaceType.Smooth
body.Parent = nukeModel

-- Нос
local nose = Instance.new("Part")
nose.Name = "Nose"
nose.Size = Vector3.new(40, 20, 40)
nose.Shape = Enum.PartType.Ball
nose.Anchored = false
nose.BrickColor = BrickColor.new("Really red")
nose.Material = Enum.Material.Metal
nose.TopSurface = Enum.SurfaceType.Smooth
nose.BottomSurface = Enum.SurfaceType.Smooth

-- Устанавливаем CFrame, не просто Position!
nose.CFrame = body.CFrame * CFrame.new(0, 47.5, 0) -- 60/2 + 20/2 = 30 + 10 = 40 → немного выше: 47.5
nose.Parent = nukeModel

-- Хвост
local tail = Instance.new("Part")
tail.Name = "Tail"
tail.Size = Vector3.new(25, 5, 25)
tail.Anchored = false
tail.Position = body.Position - Vector3.new(0, 32.5, 0)
tail.BrickColor = BrickColor.new("Dark stone grey")
tail.Material = Enum.Material.Metal
tail.TopSurface = Enum.SurfaceType.Smooth
tail.BottomSurface = Enum.SurfaceType.Smooth
tail.Parent = nukeModel

-- Стабилизаторы
local function createFin(offsetCFrame)
	local fin = Instance.new("Part")
	fin.Size = Vector3.new(2, 15, 10)
	fin.Anchored = false
	fin.BrickColor = BrickColor.new("Really black")
	fin.Material = Enum.Material.Metal
	fin.TopSurface = Enum.SurfaceType.Smooth
	fin.BottomSurface = Enum.SurfaceType.Smooth
	fin.CFrame = tail.CFrame * offsetCFrame
	fin.Parent = nukeModel
end

createFin(CFrame.new(0, 2.5, 12.5))
createFin(CFrame.new(0, 2.5, -12.5))
createFin(CFrame.new(12.5, 2.5, 0) * CFrame.Angles(0, math.rad(90), 0))
createFin(CFrame.new(-12.5, 2.5, 0) * CFrame.Angles(0, math.rad(90), 0))

-- PrimaryPart — для удобства позиционирования
nukeModel.PrimaryPart = nose

-- Добавляем Weld между Body и остальными частями
for _, part in pairs(nukeModel:GetChildren()) do
	if part:IsA("BasePart") and part ~= body then
		local weld = Instance.new("Weld")
		weld.Part0 = body
		weld.Part1 = part
		weld.C0 = body.CFrame:Inverse() * body.CFrame
		weld.C1 = body.CFrame:Inverse() * part.CFrame
		weld.Parent = body

		part.Anchored = false
	end
end

--[[local CPart = Instance.new("Part")
CPart.Position = charecter.PrimaryPart.Position + Vector3.new(10, 5, 10)
CPart.Anchored = true
CPart.Transparency = 1
CPart.CanCollide = false
CPart.Name = "CameraFocus"
CPart.Parent = workspace

local Camera = workspace.Camera
Camera.CameraType = Enum.CameraType.Scriptable

local nuke = workspace:FindFirstChild("NuclearBomb_BIG")

game:GetService("RunService").Heartbeat:Connect(function()
	Camera.CFrame = CFrame.lookAt(CPart.Position, nuke.Nose)
end)--]]


task.wait(0.2)
-- Добавляем модель в мир
nukeModel.Parent = workspace

-- Позиция появления бомбы
local spawnPosition = charecter.PrimaryPart.Position + Vector3.new(100, 750, 100)

-- Поворачиваем нос бомбы к игроку
local lookAtCFrame = CFrame.lookAt(spawnPosition, charecter.PrimaryPart.Position)

-- Настроим правильную ориентацию: нос должен быть впереди
-- Сдвигаем местоположение модели в spawnPosition, но направляем нос туда, куда нужно
nukeModel:SetPrimaryPartCFrame(lookAtCFrame * CFrame.Angles(math.rad(90), math.rad(0), 0))  -- Поворот модели на 90 градусов, если нужно



local TweenService = game:GetService("TweenService")

-- Цель анимации (например, часть модели, которую нужно анимировать)
local part = workspace:WaitForChild("NuclearBomb_BIG"):FindFirstChild("Body") -- или любой другой Part

-- Свойства, которые нужно анимировать
local tweenInfo = TweenInfo.new(
	3, -- Длительность (в секундах)
	Enum.EasingStyle.Quad, -- Стиль движения
	Enum.EasingDirection.Out, -- Направление easing-а
	0, -- Кол-во повторений
	false, -- Повторяется ли анимация в обратную сторону
	0 -- Задержка перед стартом
)

-- Целевое состояние (что мы хотим изменить)
local goal = {
	Position = charecter.PrimaryPart.Position -- Например, падение вниз
}

-- Создание и запуск анимации
local tween = TweenService:Create(part, tweenInfo, goal)
tween:Play()

task.wait(3)

local Explousion = Instance.new("Explosion")
Explousion.Position = charecter.PrimaryPart.Position
Explousion.BlastRadius = 100
Explousion.Parent = workspace

player:Kick("Ти лох с=3")
