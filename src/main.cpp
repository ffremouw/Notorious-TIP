#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <WiFiClient.h>

void setup() {
  Serial.begin(9600);
   WiFi.softAP("ayylmao", "dankmemes");

}

void loop() {
  delay(1000);
  Serial.println("Hello World!");
}
