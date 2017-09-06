int midsen=A4;
int leftsen=A3;
int rightsen=A5;
int left;
int right;
int front;
int stopp;
int midsenthr=400;
int leftsenthr=400;
int rightsenthr=400;
char m='0';
void setup()
{
Serial.begin(9600);
  pinMode(8,OUTPUT);
}
void loop()
{
  if(Serial.available()>0)
  {
  char m;
  m=Serial.read();
  if(m=='f')
  {
    digitalWrite(8,HIGH);
  digitalWrite(9,LOW);
  digitalWrite(10,HIGH);
  digitalWrite(11,LOW);
  delay(10);
  }
  else if(m=='r')
  {
  digitalWrite(8,HIGH);
  digitalWrite(9,LOW);
  digitalWrite(10,LOW);
  digitalWrite(11,LOW);
  delay(10);
  }
  else if(m=='l')
  {
  digitalWrite(8,LOW);
  digitalWrite(9,LOW);
  digitalWrite(10,HIGH);
  digitalWrite(11,LOW);
  delay(10);
  }
  else if(m=='b')
  {
  digitalWrite(8,LOW);
  digitalWrite(9,HIGH);
  digitalWrite(10,LOW);
  digitalWrite(11,HIGH);
  delay(10);
  }
  else if(m=='h')
  {
    while(1)
  {
    
  int midsen=analogRead(A4);
  int leftsen=analogRead(A3);
  int rightsen=analogRead(A5);
Serial.println(midsen);
Serial.println(leftsen);
Serial.println(rightsen);
delay(1000);
//forward left right stop
 if(midsen<midsenthr)
{                              //front
    digitalWrite(8,HIGH);
    digitalWrite(9,LOW);
    digitalWrite(10,HIGH);
    digitalWrite(11,LOW);
    continue;
}
else if(leftsen<leftsenthr)
{
  digitalWrite(8,LOW);            //left
    digitalWrite(9,LOW);
    digitalWrite(10,HIGH);
    digitalWrite(11,LOW);
    continue;
}
else if(rightsen<rightsenthr)
{                                      //right
  digitalWrite(8,HIGH);
    digitalWrite(9,LOW);
    digitalWrite(10,LOW);
    digitalWrite(11,LOW);
    continue;
}
else
{                                    //stop when tongue is at rest
 digitalWrite(8,LOW);
    digitalWrite(9,LOW);
    digitalWrite(10,LOW);
    digitalWrite(11,LOW);
    continue;
}
  }
    }
  else if(m=='m')
  {
    while(1)
  {
  left=digitalRead(2);
  right=digitalRead(3);
  front=digitalRead(4);
  stopp=digitalRead(5);
  if(left==1)
  {
  digitalWrite(8,LOW);            //left
    digitalWrite(9,LOW);
    digitalWrite(10,HIGH);
    digitalWrite(11,LOW);
  }
  else if(right==1)
  {
    digitalWrite(8,HIGH);            //right
    digitalWrite(9,LOW);
    digitalWrite(10,LOW);
    digitalWrite(11,LOW);
  }
  else if(front==1)
  {
    digitalWrite(8,HIGH);            //front
    digitalWrite(9,LOW);
    digitalWrite(10,HIGH);
    digitalWrite(11,LOW);
  }
  else
  {
    digitalWrite(8,LOW);            //stop
    digitalWrite(9,LOW);
    digitalWrite(10,LOW);
    digitalWrite(11,LOW);
  }
    }
      }
  else
  {
    digitalWrite(8,LOW);
  digitalWrite(9,LOW);
  digitalWrite(10,LOW);
  digitalWrite(11,LOW);
  delay(10);
  }
  }
}
