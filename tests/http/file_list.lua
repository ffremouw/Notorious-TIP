return function (connection, req, args)
   --connection:send("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nCache-Control: private, no-store\r\n\r\n")
   dofile("httpserver-header.lc")(connection, 200, "html")
   connection:send('<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><title>Server File Listing</title></head>')
   connection:send('<body>')
   connection:send('<h1>Server File Listing</h1>')

   local remaining, used, total=file.fsinfo()
   connection:send("<b>Total size: </b> " .. total .. " bytes<br/>\n")
   connection:send("<b>In Use: </b> " .. used .. " bytes<br/>\n")
   connection:send("<b>Free: </b> " .. remaining .. " bytes<br/>\n")

   connection:send("<p>\n")
   connection:send("<b>Files:</b><br/>\n")
   connection:send("<ul>\n")

   for name, size in pairs(file.list()) do

      local isHttpFile = string.match(name, "(http/)") ~= nil
      if isHttpFile then
         local url = string.match(name, ".*/(.*)")
         connection:send('   <li><a href="' .. url .. '">' .. url .. "</a> (" .. size .. " bytes)</li>\n")
      end
   end
   connection:send("</ul>\n")
   connection:send("</p>\n")
   connection:send('</body></html>')
end
