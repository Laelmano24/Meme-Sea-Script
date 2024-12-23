_G.MonitorarTiro = nil
_G.IdDotiro = 1848354536

_G.MonitorarTiro = hookmetamethod(game, "__namecall", function(self, ...)
  local method = getnamecallmethod()
  local args = {...}
    
  if method == "FireServer" and tostring(self) == "1Gu1n" then
    if args[7] and type(args[7]) == "number" then
      args[7] = _G.IdDotiro
    end
 end

  return _G.MonitorarTiro(self, unpack(args))
end)