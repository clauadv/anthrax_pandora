function vector:dist_to(dst)
    local dx = self.x - dst.x
    local dy = self.y - dst.y
    local dz = self.z - dst.z

    return math.round(math.sqrt(dx * dx + dy * dy + dz * dz))
end