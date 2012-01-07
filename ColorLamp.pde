#include <RGBLEDHelper.h>
#include <Streaming.h>

RgbLed led1 = RgbLed(11,10,9);
RgbLed led2 = RgbLed(6,5,3);

byte battery_probe = A0;

int minDistance = 150;
int fadeSpeed = 30;

void setup()	{
	Serial.begin(115200);
	randomSeed(analogRead(battery_probe));
	delay(100);
	
	Serial << "Battery voltage: " << (float)analogRead(battery_probe)/1024*5 << endl;
}

void loop() 	{
	int * color1;
	int * color2;
	color1 = genColor(led1,minDistance);
	color2 = genColor(led2,minDistance);
	
	Serial << "target 1: " << color1[0] << "-" << color1[1] << "-" << color1[2] << endl;
	Serial << "target 2: " << color2[0] << "-" << color2[1] << "-" << color2[2] << endl;
	
	led1.fadeRGB(color1[0],color1[1],color1[2],fadeSpeed);
	led2.fadeRGB(color2[0],color2[1],color2[2],fadeSpeed);
	
	Serial << "Done!" << endl << endl;
	
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
	Serial << "Distance: " << sqrt(distSq) << endl;
	
	return color;
	
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