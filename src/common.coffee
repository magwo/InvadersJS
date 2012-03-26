

exports.asPositionable = (obj, pos) ->
  console.log "Pos is #{pos}"
  obj.pos = pos || [0, 0]
  
  obj.x = (optionalNewX) ->
    if optionalNewX?
      return (@pos[0] = optionalNewX)
    else
      return @pos[0]
  
  obj.y = (optionalNewY) ->
    if optionalNewY?
      return (@pos[1] = optionalNewY)
    else
      return @pos[1]
      
  obj.move = (dx, dy) ->
    @pos[0] += dx
    @pos[1] += dy
    return @pos

  return obj