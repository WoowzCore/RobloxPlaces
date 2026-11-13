list = {}
length = 0

function Weld(bool)
  if bool then
    for i = 1,length do 
	  print(list[i])
     w = Instance.new("Weld")
     w.Part0 = list[i][1]
     w.Part0.Anchored = false
     w.Part1 = list[i][2]
     w.Part1.Anchored = false
     w.C1 = list[i][3]
     weld = w.Part1:FindFirstChild("Weld") if weld ~= nil then weld:Destroy() end
     if w.Parent ~= w.Part1 then w.Parent = w.Part1 end--keeps from adding too many of the same welds.
    end
  elseif not bool then
    short_list = {}
    temp_num = 0
    for i,part in pairs(script.Parent:GetChildren()) do
	   length = (#short_list)
      if part:IsA("BasePart") and short_list[length] == nil then--if the object in question is a part and the short_list is empty 
        table.insert(short_list,part)
      elseif part:IsA("BasePart") and short_list[length] ~= nil then--if the short_list has anything before the current number
        part2 = short_list[length]
        table.insert(list,{part2,part,part.CFrame:inverse()*part2.CFrame})
        table.insert(short_list,part)
      end
    end
  wait()
  length = (#short_list-1)
  end
end
Weld(false)--get the parts the first and ONLY time.
Weld(true)
script.Parent.Equipped:connect(function(mouse) Weld(true) end)
script.Parent.Unequipped:connect(function(mouse) Weld(true) end)
