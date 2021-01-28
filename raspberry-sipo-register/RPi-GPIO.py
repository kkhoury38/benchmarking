import RPi.GPIO as GPIO
import time

def onRising(gpio):
   global DATA_LEVEL, phrase, count, correct_count, init

   if gpio == CLK_pin:
      phrase += str(DATA_LEVEL)
   elif gpio == LOAD_pin:
      if not init:
         init = True
      else:
         count += 1
         if phrase == '01010011':
            correct_count += 1

      phrase=''

def onBoth(gpio):
   global DATA_LEVEL
   DATA_LEVEL=GPIO.input(gpio)


if __name__ == '__main__':
   CLK_pin=17
   LOAD_pin=27
   DATA_pin=22

   DATA_LEVEL=1
   phrase=''
   init = False

   count = 0
   correct_count = 0

   GPIO.setmode(GPIO.BCM)
   GPIO.setup(CLK_pin, GPIO.IN)
   GPIO.setup(LOAD_pin, GPIO.IN)
   GPIO.setup(DATA_pin, GPIO.IN)

   GPIO.add_event_detect(LOAD_pin, GPIO.RISING, callback=onRising)
   GPIO.add_event_detect(CLK_pin, GPIO.RISING, callback=onRising)
   GPIO.add_event_detect(DATA_pin, GPIO.BOTH, callback=onBoth)

   print("Starting benchmark")
   time.sleep(60)

   print('Frequency XX:',count,'-',correct_count)
