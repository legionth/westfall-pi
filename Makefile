RASPBERRY_USERNAME = root
RASPBERRY_ADDRESS = legionth-raspberry
RASPBERRY_SOURCE_DIRECTORY = /home/pi/

install:
	scp -r ../westfall-pi $(RASPBERRY_USERNAME)@$(RASPBERRY_ADDRESS):$(RASPBERRY_SOURCE_DIRECTORY)
