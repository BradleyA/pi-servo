
# 	servo-test-01.py	0.2.10	2018-02-24_10:24:07_CST uadmin six-rpi3b.cptx86.com v0.1-8-g3a3cdf5 
# 	   added a picture of test 
import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)

GPIO.setup(7,GPIO.OUT)

try:
        while True:
                GPIO.output(7,1)
                time.sleep(0.0015)
                GPIO.output(7,0)

                time.sleep(2)

except KeyboardInterrupt:
        GPIO.cleanup()
