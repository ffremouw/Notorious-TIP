http.request("https://145.24.222.226/api/update", "POST", "Authorization: Basic dXNlcm5hbWU6UGFzc3dvcmQxMjM=\r\nproductid: "..productid.."\r\n", "", 
        function(code, data)
            if (code < 0) then
                print("HTTP request failed")
            else
                print(data)
                t = cjson.decode(data)

                if versionNumber < t["versionNumber"] do
                    
                    if crypto.hmac("sha1", content, key) == t["hmac"] do
                        content = encoder.fromHex(t["data"])
                        
                        file.open("update.lua", "w+")
                        file.write(content)
                        file.close()
                        file.remove(t["fileName"])
                        file.rename('update.lua', t["fileName"])
                        file.remove("update.lua")
                        node.restart()
                    end
                end
            end
        end)