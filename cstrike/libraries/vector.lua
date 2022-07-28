function vector:dist_to(dst)
    local dx = self.x - dst.x
    local dy = self.y - dst.y
    local dz = self.z - dst.z

    return math.round(math.sqrt(dx * dx + dy * dy + dz * dz))
end

function vector:length_sqr()
    return (self.x * self.x) + (self.y * self.y) + (self.z * self.z)
end

function vector:length(a)
    return math.sqrt(self:length_sqr())
end