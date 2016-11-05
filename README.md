# Notorious-TIP

Source code for the ESP capabilities.

Heavily based on https://github.com/devyte/nodemcu-platform and https://github.com/marcoschwartz/aREST-ESP8266

With added AES ECB 128 bit encrytion and TLS 1.1. This code polls our backend every 5 second when it's connected to WIFI only. With every request it check if the certificate is the same as the one saved in the ESP.

The ESP is the NodeMCU v2 with custom firmware (added encryption, ssl support and encoder). You can build your own custom firmware using this link: https://nodemcu-build.com/


