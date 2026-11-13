local m = {}

m.Lerp = function(n,n2,i)
	return n + (n2-n) * i
end

return m
