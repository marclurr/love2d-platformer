return function(x, y, w, h, predicate) 
    local killZone = {}
    killZone.name = "KillZone"
    Components.position(killZone, x, y)
    Components.hitbox(killZone, w, h)
    Components.causesDamage(killZone, Damage.kill, predicate or Predicates.any)
    return killZone
end