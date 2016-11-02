http.request("https://145.24.222.226/api/data", "POST", "Authorization: Basic dXNlcm5hbWU6UGFzc3dvcmQxMjM=\r\nproductid: "..productid.."\r\n", "", 
        function(code, data)
            if (code < 0) then
                print("HTTP request failed")
            else
                file.open("aupdate.lua", "w+")
                file.write(data)
                file.close()
            end
        end)


http.request("https://145.24.222.226/api/update", "POST", "Authorization: Basic dXNlcm5hbWU6UGFzc3dvcmQxMjM=\r\nproductid: "..productid.."\r\n", "", 
        function(code, data)
            if (code < 0) then
                print("HTTP request failed")
            else
                t = cjson.decode(data)
                if versionNumber<t["versionNumber"] then
                        file.remove(t["fileName"])
                        file.rename('aupdate.lua', t["fileName"])
                        file.remove("aupdate.lua")
                        --node.restart()
                end
            end
        end) 


