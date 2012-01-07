#include <RGBLEDHelper.h>
#include <Streaming.h>

RgbLed led1 = RgbLed(11,10,9);
RgbLed led2 = RgbLed(6,5,3);

byte battery_probe = A0;

int RGB_status[] = {0,0,0};
int RGB_target[3];
int minDistance=150;

long distSq;

// bool rxComplete = false;
// byte rx[] = {0,0,0};

void setup()	{
	Serial.begin(115200);
	randomSeed(analogRead(battery_probe));
	
	delay(100);
	
	Serial << "Battery voltage: " << (float)analogRead(battery_probe)/1024*5 << endl;

	//led1.setMaxLum(200,200,200);
}

void loop() 	{
	
	do {
		for (int i=0; i<3; i++)	{
			RGB_target[i] = random(0,255); // TODO!
		}
		Serial << "try: " << RGB_target[0] << "-" << RGB_target[1] << "-" << RGB_target[2] << endl;
		distSq = pow((RGB_target[0] - led1.getStatus()[0]),2) + pow((RGB_target[1]-led1.getStatus()[1]),2) + pow((RGB_target[2]-led1.getStatus()[2]),2);
		Serial << "try - distance: " << sqrt(distSq) << endl;
	} 
	while (distSq < pow(minDistance,2));
	
	Serial << "Found!" << endl;
	Serial << "RGB status: " << led1.getStatus()[0] << "-" << led1.getStatus()[1] << "-" << led1.getStatus()[2] << endl;	
	Serial << "RGB target: " << RGB_target[0] << "-" << RGB_target[1] << "-" << RGB_target[2] << endl;
	Serial << "Distance: " << sqrt(distSq) << endl;
	
	led1.fadeRGB(RGB_target[0],RGB_target[1],RGB_target[2],50);
	
	Serial << "Done!" << endl;
	// meetAndroid.send("Done");
	distSq = 0;
	
	delay(5000);
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