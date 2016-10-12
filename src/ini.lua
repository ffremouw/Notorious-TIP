--init.lua
-- WiFi instellingen en connectie
print("Connectie maken via WiFi...")
wifi.sta.config("SSID","WACHTWOORD")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function()
 if wifi.sta.getip()== nil then
 print("Wachten op IP adres...")
else
 tmr.stop(1)
print("Module actief op IP: "..wifi.sta.getip())
-- kijk eerst of het bestand bestaat, anders crasht de ESP8266
if file.list()["server.lua"] then
 dofile ("server.lua")
else
 print("Bestand server.lua niet gevonden!")
end
end
end)
