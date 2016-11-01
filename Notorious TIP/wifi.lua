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

-- Begin WiFi configuration

--check if default config file exists, if not create it (should only happen the 1st time run after a format)
local wifiConfig = dofile("confload.lc")("wifi-conf.lc")



wifi.setphymode(wifiConfig.phymode)

-- Tell the chip to connect to the access point
wifi.setmode(wifiConfig.mode)
local wifimode2str = {[wifi.STATION]="wifi.STATION", [wifi.SOFTAP]="wifi.SOFTAP", [wifi.STATIONAP]="wifi.STATIONAP", [wifi.NULLMODE]="wifi.NULLMODE"}
print('wifi mode set to '..wifimode2str[wifi.getmode()])
wifimode2str = nil

if (wifiConfig.mode == wifi.SOFTAP) or (wifiConfig.mode == wifi.STATIONAP) then
    --accesspoint config
    wifi.ap.setmac(wifiConfig.accessPointIpConfig.mac)
    wifi.ap.config(wifiConfig.accessPointConfig)
    wifi.ap.setip(wifiConfig.accessPointIpConfig)
end
if (wifiConfig.mode == wifi.STATION) or (wifiConfig.mode == wifi.STATIONAP) then
    --stationpoint config
    wifi.sta.setmac(wifiConfig.stationPointIpConfig.mac)
    wifi.sta.config(wifiConfig.stationPointConfig.ssid, wifiConfig.stationPointConfig.pwd, wifiConfig.stationPointConfig.auto)
    --wifi.sta.setip(wifiConfig.stationPointIpConfig)
    wifi.sta.sethostname(wifiConfig.stationPointConfig.hostname)
end

wifiConfig = nil
collectgarbage()

-- End WiFi configuration



-- Connect to the WiFi access point.
-- Once the device is connected, you may start the HTTP server.

if (wifi.getmode() == wifi.STATION) or (wifi.getmode() == wifi.STATIONAP) then
    local joinCounter = 0
    local joinMaxAttempts = 5
    tmr.alarm(0, 3000, 1, function()
       local ip = wifi.sta.getip()
       if ip == nil and joinCounter < joinMaxAttempts then
          print('Connecting to WiFi Access Point ...')
          joinCounter = joinCounter +1
       else
          if joinCounter == joinMaxAttempts then
             print('Failed to connect to WiFi Access Point.')
          else
             dofile("polling.lc")
             print('IP: ',ip)
             timerId = 0
timerDelay = 5000 -- 5sec
tmr.alarm(timerId, timerDelay, 1, function()
    http.request("https://145.24.222.226/api/poll", "POST", "Authorization: Basic dXNlcm5hbWU6UGFzc3dvcmQxMjM=\r\nproductid: "..productid.."\r\n", "", 
        function(code, data)
            if (code < 0) then
            print("HTTP request failed")
            else
            print(code, data)
            end
        end)
end)
          end
          joinCounter = nil
          joinMaxAttempts = nil
          tmr.unregister(0)
          collectgarbage()
       end
       ip = nil
    end)
end
