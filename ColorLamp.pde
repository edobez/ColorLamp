#include <RGBLEDHelper.h>
#include <Streaming.h>

RgbLed led1 = RgbLed(11,10,9);
RgbLed led2 = RgbLed(6,5,3);
byte battery_probe = A0;
bool rxComplete = false;
byte rx[] = {0,0,0};

void setup()	{
	Serial.begin(115200);
	randomSeed(analogRead(battery_probe));
	
	delay(100);
	
	Serial << "Battery voltage: " << (float)analogRead(battery_probe)/1024*5 << endl;

	//led1.setMaxLum(200,200,200);
}

void loop() 	{
	
	// led1.on();
	// led2.on();
	// Serial << "Led ON" << endl;
	// delay(2000);	
	// 
	// led1.set(1,0,0);
	// led2.set(1,0,0);
	// Serial << "Led R ON" << endl;
	// delay(2000);
	// 
	// led1.set(0,1,0);
	// led2.set(0,1,0);
	// Serial << "Led G ON" << endl;
	// delay(2000);
	// 
	// led1.set(0,0,1);
	// led2.set(0,0,1);
	// Serial << "Led B ON" << endl;
	// delay(2000);
	
	if(rxComplete)	{
		Serial << rx[0] << "," << rx[1] << "," << rx[2] << endl;
		
		byte rx[] = {0,0,0};
		rxComplete = false;
	}	
	
	if(led1.setRGB(255,255,255))	{
		int * a = led1.getStatus();
		Serial << "Led set: " << a[0] << "-" << a[1] << "-" << a[2] << endl;
	}
	delay(2000);
	
	// if(led1.fadeRGB(20,100,100,50))	{
	// 	int * b = led1.getTarget();
	// 	Serial << "Led fade to: " << b[0] << "-" << b[1] << "-" << b[2] << endl;
	// }
	// delay(2000);
	
	// led1.off();
	// led2.off();
	// Serial << "Led OFF" << endl;
	// delay(2000);
	
}

void serialEvent() {
	byte i = 0;
	byte temp = 0;
  while (Serial.available()) {
    // get the new byte:
    	char inChar = (char)Serial.read();
		if (inChar == ',') {
			i++;
			continue;
		}
		rx[i] += ins\
    // add it to the inputString:
    // inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n') {
    	rxComplete = true;
     } 
  }
}