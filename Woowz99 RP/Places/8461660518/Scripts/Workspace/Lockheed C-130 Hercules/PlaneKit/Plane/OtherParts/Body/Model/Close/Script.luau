DoorA = script.Parent.Parent.DoorA
DoorB = script.Parent.Parent.DoorB
function onClick()
DoorA.Visible.Value = false
DoorB.Visible.Value = true
end
script.Parent.ClickDetector.MouseClick:connect(onClick)