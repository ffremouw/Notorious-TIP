tmr.alarm(0, 5000, 1, function ()
     net.cert.verify([[
    -----BEGIN CERTIFICATE-----
    MIIDjzCCAnegAwIBAgIJANDqjQohQMiwMA0GCSqGSIb3DQEBCwUAMF4xCzAJBgNV
    BAYTAk5MMRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVQQKDBhJbnRlcm5ldCBX
    aWRnaXRzIFB0eSBMdGQxFzAVBgNVBAMMDjE0NS4yNC4yMjIuMjI2MB4XDTE2MDMy
    NDE0NTgxMVoXDTE3MDMyNDE0NTgxMVowXjELMAkGA1UEBhMCTkwxEzARBgNVBAgM
    ClNvbWUtU3RhdGUxITAfBgNVBAoMGEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDEX
    MBUGA1UEAwwOMTQ1LjI0LjIyMi4yMjYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
    ggEKAoIBAQCzId0L1kloahojW5ioUqibCRf5J7T0mMAeel302nPCHSJgvauqSlEC
    1jkgA5eS9h8Lq+v1UpTSiYheK7xIorGxgM4jKE2qEyTGg2cY1V95Qi/Xe4SZ/dv1
    iR/h3inV3G+hDhR7eMZ1gqOKJcIPHv4Jz24lSQCnhG4l2pKKFLKnjl/lPW3Is9B2
    Awr5ZfPqphMM5qXXRpBDaGyDkJy75CRJD6Vua3AkgGlL/UkjXLSa/36/8ntxriDw
    HfAdQhS8jYUOKoFksG++oBWXONj4Dr3U6lbmvsfeAxEzt2RWwdDS/nSquhftc/9M
    Fkmbe/oWMVgbfgOCy1GZECzHbRekUJuLAgMBAAGjUDBOMB0GA1UdDgQWBBRk6e4u
    3rGswGbjKDSRtKaNnLJz9DAfBgNVHSMEGDAWgBRk6e4u3rGswGbjKDSRtKaNnLJz
    9DAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQBvaysSiIOdt3myeVHg
    dXqcT5a0HL5WhL7tG28U10ecR8ZfY0VqMmt6jfHIAtAPnAONUmlqxm/Z4mkqfdyb
    Jvk8j9IXP7TbUrWEPVR5+2gCv3Q/0j+iIHtDMzIxCLEN1cqIHpSQVXEUyejGXs1r
    od2zGIFJIjfT5K7s8EEMpXyqgA+JQ92rKl2y7CSTTx72sGREr3G1xCG1k3+7nbQK
    V3SuOi/tVw4uZ2JBC+ePBz9u+TfW/YEbAekG0hEjq2ADK2i06w0LfCkIqDA+Eign
    oNjIpr3pZRE/w5eYAJ044mQg8VI5S7R1dHMjaUXHqQ9LZ0MvtEZeFAgydK2E6kyh
    LfsC
    -----END CERTIFICATE-----
    ]])

    http.request("https://145.24.222.226/api/poll", "POST", "Authorization: Basic dXNlcm5hbWU6UGFzc3dvcmQxMjM=\r\nproductid: "..productid.."\r\n", "", 
    function(code, data)
        if (code < 0) then
        print("HTTP request failed")
        else
        t = cjson.decode(data)
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

end)



--poll()