#include <RGBLEDHelper.h>
#include <Streaming.h>
#include <Bounce.h>

RgbLed led1 = RgbLed(11,10,9);
RgbLed led2 = RgbLed(6,5,3);

Bounce but = Bounce(2,5);

byte battery_probe = A0;

int minDistance = 150;
int diagDistance = 5;
int fadeSpeed = 50;

// byte colCount[256][3] = {0};

void setup()	{
	Serial.begin(115200);
	randomSeed(analogRead(battery_probe));
	
	led1.setMinLum(15,15,15);
	led2.setMinLum(15,15,15);
	
	led1.setMaxLum(255,255,255);		//optional
	led2.setMaxLum(255,240,240);		//optional
	
	delay(100);
	
	Serial << "Battery voltage: " << (float)analogRead(battery_probe)/1024*5 << endl;
}

void loop() 	{
	int * color;
	int color1[3],color2[3];
	
	but.update();
	if(but.read() == LOW)	printFrequency(colCount);
	
	color = genColor(led1,minDistance, diagDistance);
	for(int i=0;i<3;i++)	{
			color1[i] = color[i];
	}
	
	// color = genColor(led2,minDistance);
	// for(int i=0;i<3;i++)	{
	// 		color2[i] = color[i];
	// }		
	
	led1.fadeRGB(color1[0],color1[1],color1[2],fadeSpeed);
	//led2.fadeRGB(color1[0],color1[1],color1[2],fadeSpeed);
	
	Serial << "Done!" << endl << endl;
	
	// for (int i = 0; i < 3 ; i++)	{
	// 	colCount[ color1[i] ][i]++;
	// }
	
	delay(500);
}

int * genColor(RgbLed led, int minDistance, int diagDistance){
	int color[3];
	long distSq,distSqDiag;
	int counter = 0;
	
	do {
		for (int i=0; i<3; i++)	{
			color[i] = random(led.getMinLum()[i],led.getMaxLum()[i]);
		}
		
		distSq = pow((color[0] - led.getStatus()[0]),2);
		distSq += pow((color[1]-led.getStatus()[1]),2);
		distSq += pow((color[2]-led.getStatus()[2]),2);
		
		distSqDiag = distSqFromDiag(color);
		
		counter++;
	} 
	while (distSq < pow(minDistance,2) || distSqDiag < pow(diagDistance,2));
	
	Serial << "RGB status: " << led.getStatus()[0] << "-" << led.getStatus()[1] << "-" << led.getStatus()[2] << endl;	
	Serial << "RGB target: " << color[0] << "-" << color[1] << "-" << color[2] << endl;
	Serial << "Distance: " << sqrt(distSq) << " - from diag: " << sqrt(distSqDiag) << endl;
	Serial << "Iterations: " << counter << endl;
	
	return color;
	
}

long distSqFromDiag(int color[])	{
	long distSq = 2147483646;
	long temp;
	
	for (int i = 0; i<256; i++) {
		temp = pow(color[0] - i,2);
		temp += pow(color[1] - i,2);
		temp += pow(color[2] - i,2);
		
		if (temp < distSq) distSq = temp;
	}
	
	return distSq;
}

void printFrequency(byte c[][3])	{
	Serial << "\tR\tG\tB" << endl;
	
	for (int i = 0; i < 256; i++)	{
		Serial << i;
		for (int j = 0; j < 3; j++)	{
			Serial << "\t" << c[i][j]; 
		}
		Serial << endl;
	}
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