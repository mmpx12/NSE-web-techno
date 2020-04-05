author = "Dr Claw"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"
categories = {"discovery"}

-- @output
-- 80/tcp   open  http
-- | web_techno:
-- |_Redirection to: https://github.com
-- 443/tcp  open  https
-- | web_techno:
-- | "[UI frameworks] Bootstrap:46"
-- | "[PaaS] GitHub Pages:null"
-- | "[Web frameworks] Ruby on Rails:null"
-- |_"[Programming languages] Ruby:null"

description = [[
  Find web technology base on wappalyzer.
]]

local nmap = require "nmap"
local stdnse = require "stdnse"
local http = require("http")

portrule = function(host, port)
  if port.service == "https" or port.service == "http" then
    return port.protocol == "tcp"
      and port.state == "open"
  end
end

action = function(host, port)
  if port.service == "http" then 
    url = "http://" .. host.targetname .. ":" .. port.number .. "/"
    resp = http.get(host.targetname,port.number, "/")
  else 
    url = "https://" .. host.targetname .. ":" .. port.number .. "/"
    resp = http.get(host.targetname,port.number, "/")
  end
  if tonumber(resp.status) > 400 then
    err_output = resp.content
    for key, value in pairs(resp.rawheader) do
      err_output = err_output .. key .. value .."\n"
    end
    output = "Error:\n" .. code .. "\n" .. err_output
    return output
  elseif tonumber(resp.status) == 301 then
    url = resp.header['location']
  end
  if resp.header['location'] ~= nil then
    output = "\n  Redirection to: " .. resp.header['location']
  else
    cmd = "wappalyzer " .. url .. " 2> /dev/null | jq -r '.technologies[] | [ \"  [\"+.categories[].name +\"] \"+.name+\":\"+ if .version then .version else \"unknow\" end] |.[]'"
    output = "\n" .. io.popen(cmd, "r"):read("*a"):sub(1, -2) 
    if output == '\n' then
      output = "No data"
    end
  end 
  return output
end
