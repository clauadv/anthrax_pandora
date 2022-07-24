local utils = {}

function utils:str_to_sub(input, sep)
	local t = {}

	for str in string.gmatch(input, "([^"..sep.."]+)") do
		t[#t + 1] = string.gsub(str, "\n", "")
	end

	return t
end

function utils:to_boolean(str)
	if str == "true" or str == "false" then
		return (str == "true")
	else
		return str
	end
end