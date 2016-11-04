productid = "1"
key = "1234123412341234"
versionNumber = 1

 
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

--STEP0: print some info
print('chip: ',node.chipid())
print('heap: ',node.heap())

--STEP1: init hw settings
--gpio.mode(6, gpio.OUTPUT, gpio.PULLUP)
--gpio.mode(7, gpio.OUTPUT, gpio.PULLUP)
--gpio.mode(8, gpio.OUTPUT, gpio.PULLUP)
--gpio.write(6, 0)
--gpio.write(7, 0)
--gpio.write(8, 0)

--STEP2: compile all .lua files to .lc files
local compilelua = "compile.lua"
if file.exists(compilelua) then
    dofile(compilelua)(compilelua)
end
dofile("compile.lc")()

--STEP3: load tools
dofile("tools.lc")

--STEP4: move files to subdirs and unload tools
tools.mv2http()
tools = nil

--STEP5: handle wifi config
dofile("wifi.lc")



--STEP6: start the TCP server in port 80, if an ip is available
tcpsrv = dofile("tcpserver.lc")(8080, {httpserver = true, luaserver = true})
dofile("polling.lc")


--STEP7: start the tftp server for easy file upload
--tftpsrv = dofile("tftpd.lc")(69)

collectgarbage()
print('heap after init: ', node.heap())
