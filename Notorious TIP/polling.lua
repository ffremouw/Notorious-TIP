timerId = 0
timerDelay = 5000 -- 5sec
tmr.alarm(timerId, timerDelay, 1, function()
if wifi.sta.status()  == 5 then
    http.request("https://145.24.222.226/api/poll", "POST", "Authorization: \r\nproductid: "..productid.."\r\n", "", 
        function(code, data)
            if (code < 0) then
            print("HTTP request failed")
            else
            print(data)
            command = crypto.decrypt("AES-ECB", key, encoder.fromHex(data))
            if string.find(command, "false") == nil then
             --must be true
            t = cjson.decode(string.sub(command, 0, 49))
            else 
            --if not true then it must be false
            t = cjson.decode(string.sub(command, 0, 50))
            end
            if t["vibrate"] == true then
                print("true")
                gpio.mode(2, gpio.OUTPUT)
                gpio.write(2, gpio.HIGH)
            end
            if t["vibrate"] == false then
                print("false")
                gpio.write(2, gpio.LOW)
            end
            end
        end)
end
end)




--poll()
