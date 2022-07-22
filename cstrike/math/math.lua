math.radian_to_degree = function(radian)
    return radian * 180 / math.pi
end

math.degree_to_radian = function(degree)
    return degree * math.pi / 180
end

math.round = function(x)
    return x % 1 >= 0.5 and math.ceil(x) or math.floor(x)
end

math.angles = function(vec)
    return vector.new(-math.atan2(vec.z, math.length2d(vec)) * 180 / math.pi, math.atan2(vec.y, vec.x) * 180 / math.pi, 0)
end

math.length2d = function(vec)
    return math.sqrt(vec.x * vec.x + vec.y * vec.y)
end

math.normalize = function(angle)
    while angle < -180 do
        angle = angle + 360
    end

    while angle > 180 do
        angle = angle - 360
    end

    return angle
end

math.clamp = function(v, min, max)
    local num = v
    num = num < min and min or num
    num = num > max and max or num
    
    return num
end

math.angle_to_vector = function(angle)
    local pitch = angle.x
    local yaw = angle.y

    return vector.new(
        math.cos(math.pi / 180 * pitch) * math.cos(math.pi / 180 * yaw), 
        math.cos(math.pi / 180 * pitch) * math.sin(math.pi / 180 * yaw), 
        -math.sin(math.pi / 180 * pitch)
    )
end

math.calculate_angles = function(from, to)
    local sub = vector.new(to.x - from.x, to.y - from.y, to.z - from.z)
    local hyp = math.sqrt(sub.x * sub.x * 2 + sub.y * sub.y * 2)

    local yaw = math.radian_to_degree(math.atan2(sub.y, sub.x))
    local pitch = math.radian_to_degree(-math.atan2(sub.z, hyp))

    return vector.new(pitch, yaw, 0)
end

math.fov_to = function(origin, destination, view)
    local angles = math.angles(vector.new(destination.x - origin.x, destination.y - origin.y, destination.z - origin.z))
    local delta = vector.new(math.abs(view.x - angles.x), math.abs(view.y % 360 - angles.y % 360) % 360, 0)
    
    if delta.y > 180 then
        delta.y = 360 - delta.y
    end

    return math.length2d(delta)
end