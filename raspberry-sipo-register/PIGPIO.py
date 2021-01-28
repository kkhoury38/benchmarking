import pigpio, time

def onChange(gpio,level,tick):
   global data_level
   global phrase, init
   global count, correct_count

   if gpio == DATA_pin:
      data_level = level
   elif gpio == LOAD_pin:
      if not init:
         init = True
      else:
         count += 1
         if phrase == "01010011":
            correct_count += 1
      phrase = ''
   else: # clock pin
       phrase = phrase + str(data_level)

if __name__ == '__main__':
   DATA_pin=22
   CLK_pin=17
   LOAD_pin=27
   phrase=""
   data_level = 0

   count = 0
   correct_count = 0
   init = False
   
   pi = pigpio.pi()
   pi.set_mode(CLK_pin, pigpio.INPUT)
   pi.set_mode(DATA_pin, pigpio.INPUT)
   pi.set_mode(LOAD_pin, pigpio.INPUT)

   cb1 = pi.callback(DATA_pin, pigpio.EITHER_EDGE, onChange)
   cb2 = pi.callback(CLK_pin, pigpio.RISING_EDGE, onChange)
   cb3 = pi.callback(LOAD_pin, pigpio.RISING_EDGE, onChange)

   print('Start Benchmark')
   time.sleep(60)

   print('Frequency XX:',count,'-',correct_count)
