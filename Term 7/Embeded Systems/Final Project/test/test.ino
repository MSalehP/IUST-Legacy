void setup() {
  // Initialize GPIO 2 (onboard LED) as an output
  pinMode(2, OUTPUT);
}

void loop() {
  // Turn the onboard LED on
  digitalWrite(2, HIGH);
  delay(1000); // Wait for 1 second

  // Turn the onboard LED off
  digitalWrite(2, LOW);
  delay(1000); // Wait for 1 second
}
