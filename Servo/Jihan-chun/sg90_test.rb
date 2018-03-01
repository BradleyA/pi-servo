require 'io/console'
require 'rpi_gpio'
  
# Initialize GPIO numbering at rpi_gpio
RPi::GPIO.set_numbering :bcm
 
# Set output servo at GPIO pin 18
servo_out = 18
RPi::GPIO.setup servo_out, :as => :output
$pwm = RPi::GPIO::PWM.new(servo_out, 50) # 50Hz = 20ms per pulse
 
# Define servo move function
def servo_move(degree)
  duty_cycle = 7.5 # Duty cycle is 7.5% (1.5ms), which means position 90 (middle)
  case degree
  when 0
    duty_cycle = 5.0 # Duty cycle 5% (1ms), position 0 (left)
  when 90
    duty_cycle = 7.5 # Duty cycle 7.5% (1.5ms), position 90 (middle)
  when 180
    duty_cycle = 10.0 # Duty cycle 10% (2ms), position 180 (right)
  end
  
  # Set PWM signal to given pulse to go to specific degree.
  $pwm.duty_cycle = duty_cycle
  sleep(1)
end
 
# Define getchar (for test)
def getchar
  state = `stty -g`
  `stty raw -echo -icanon isig`
  STDIN.getc.chr
ensure
  `stty #{state}`
end
  
# Main
$pwm.start 7.5
 
begin
  while true do
    input = getchar
    case input
    when 'q'
      servo_move(0)
    when 'w'
      servo_move(90)
    when 'e'
      servo_move(180)
    end
    print "cycle end\n"
  end
rescue SystemExit, Interrupt
  $pwm.stop
  RPi::GPIO.clean_up
end
