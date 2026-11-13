DoorA = script.Parent.Parent.DoorA
DoorB = script.Parent.Parent.DoorB
function onClick()
DoorA.Visible.Value = true
DoorB.Visible.Value = false
end
script.Parent.ClickDetector.MouseClick:connect(onClick)