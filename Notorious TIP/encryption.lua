test = crypto.decrypt("AES-ECB", key, encoder.fromHex("43c1e2a4474f56acc0541d84e4a3058d8e13319cb87aa36bb0510384876adf82ab577668ca0ddccede14d60f2eb3c33bf7a1dc2d4aa936df0907379bc6f782c8"))
print(string.len(test))
if string.len(test) == 64 then
    print(string.sub(test, 0, 49))
elseif string.len(test) == 49 then
    print(string.sub(test, 0, 49))
end