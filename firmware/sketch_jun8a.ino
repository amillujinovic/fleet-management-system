#include<WiFi.h>
#include<HTTPClient.h>
#include<TinyGPSPlus.h>
//my wifi settings
const char* WIFI_SSID="Galaxy A56 5G 0075";
const char* WIFI_PASS="11111111";
//backend
const char* SERVER_URL = "http://10.68.174.115:5283/api/Gps/Track";//esp32 cannot comunicate through localhost so i have to use my pc ip address(ipconfig in cmd)
const int VEHICLE_ID=1;
//GPS
TinyGPSPlus gps;
HardwareSerial GPSSerial(2);
//esp32 has 3 serial ports HardwareSerial enables me to control them
unsigned long lastSend = 0;
const unsigned long SEND_INTERVAL = 5000;
void setup()
{
  Serial.begin(115200) ;//communication canal with esp32 with speed 115200 bit
  GPSSerial.begin(9600, SERIAL_8N1, 16, 17);
  Serial.print("Connecting WiFi!");
  WiFi.begin(WIFI_SSID,WIFI_PASS);
  while(WiFi.status()!=WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  } 
  Serial.print("\nWiFi OK. ESP IP: ");
  Serial.println(WiFi.localIP());
  Serial.print("Saljem na: ");
  Serial.println(SERVER_URL);
}
void loop()
{
  while (GPSSerial.available() > 0) {
    gps.encode(GPSSerial.read());
  }
  if(millis()-lastSend>SEND_INTERVAL) //milis() returns number of seconds from when esp is turned on
  {
    lastSend=millis();
    if (gps.location.isValid()) {
      sendLocation(gps.location.lat(),
                   gps.location.lng(),
                   gps.speed.kmph());
    } else {
      Serial.print("Waiting GPS fix...satelites ");
      Serial.println(gps.satellites.value());
      Serial.print("  chars: ");
      Serial.println(gps.charsProcessed());
    }
  }
}
void sendLocation(double lat,double lng,double speed)
{
  if(WiFi.status()!=WL_CONNECTED)
  {
    Serial.println("WiFi fail");
    return;
  }
  HTTPClient http;
  http.begin(SERVER_URL);
  http.addHeader("Content-Type", "application/json");
  String body = "{\"vehicleId\":" + String(VEHICLE_ID) +
                ",\"latitude\":"  + String(lat, 6) +
                ",\"longitude\":" + String(lng, 6) +
                ",\"speed\":"     + String(speed, 1) + "}";

  int code = http.POST(body);   
  Serial.print("POST -> ");
  Serial.print(code);            
  Serial.print("  ");
  Serial.println(body);

  http.end();
}