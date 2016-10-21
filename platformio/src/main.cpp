#include "ESP8266httpUpdate.h"
#include "ESP8266HTTPClient.h"

void setup()
{
delay(100);
}

void loop()
{
delay(10);
Serial.println("GO!");
ESPhttpUpdate.update("37.128.187.9", 80 , "/downloads/AirWare.ino.bin" );
Serial.println("llmao");
}
