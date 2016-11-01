timerId = 0
timerDelay = 5000 -- 5sec
tmr.alarm(timerId, timerDelay, 1, function()
if wifi.sta.status()  == 5 then
    http.request("https://145.24.222.226/api/update", "POST", "Authorization: Basic dXNlcm5hbWU6UGFzc3dvcmQxMjM=\r\nproductid: "..productid.."\r\n", "", 
        function(code, data)
            if (code < 0) then
            print("HTTP request failed")
            else
            t = cjson.decode(data)
            if t["update"] == true then
                print(t["data"])
                file.open("update.lua")
                for i=0 string.len(data), -1 do
                    file.write(string.sub(data, , )
                    file.close()
                end
            end
            if t["false"] == false then
                print("false")
            end
            end
        end)
end
end)
