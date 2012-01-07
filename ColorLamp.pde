#include <RGBLEDHelper.h>
#include <Streaming.h>

RgbLed led1 = RgbLed(11,10,9);
RgbLed led2 = RgbLed(6,5,3);

byte battery_probe = A0;

// bool rxComplete = false;
// byte rx[] = {0,0,0};

void setup()	{
	digitalWrite(13,HIGH);
	Serial.begin(115200);
	randomSeed(analogRead(battery_probe));
	delay(500);
	
	Serial << "Battery voltage: " << (float)analogRead(battery_probe)/1024*5 << endl;
	digitalWrite(13,LOW);
	//led1.setMaxLum(200,200,200);
}

void loop() 	{
	
	genColor(led1,150);
	
	// led1.fadeRGB(RGB_target[0],RGB_target[1],RGB_target[2],50);
	
	Serial << "Done!" << endl;
	// meetAndroid.send("Done");
	// distSq = 0;
	
	delay(5000);
}

int * genColor(RgbLed led, int minDistance){
	int color[3];
	long distSq;
	
	do {
		for (int i=0; i<3; i++)	{
			color[i] = random(led.getMinLum()[i],led.getMaxLum()[i]);
		}
		
		distSq = pow((color[0] - led.getStatus()[0]),2);
		distSq += pow((color[1]-led.getStatus()[1]),2);
		distSq += pow((color[2]-led.getStatus()[2]),2);
		
	} 
	while (distSq < pow(minDistance,2));
	
	Serial << "RGB status: " << led.getStatus()[0] << "-" << led.getStatus()[1] << "-" << led.getStatus()[2] << endl;	
	Serial << "RGB target: " << color[0] << "-" << color[1] << "-" << color[2] << endl;
	Serial << "Distance: " << sqrt(distSq) << endl << endl;
	
}

// void serialEvent() {
// 	byte i = 0;
// 	byte temp = 0;
//   while (Serial.available()) {
//     // get the new byte:
//     	char inChar = (char)Serial.read();
// 		if (inChar == ',') {
// 			i++;
// 			continue;
// 		}
// 		rx[i] += ins\
//     // add it to the inputString:
//     // inputString += inChar;
//     // if the incoming character is a newline, set a flag
//     // so the main loop can do something about it:
//     if (inChar == '\n') {
//     	rxComplete = true;
//      } 
//   }
// }