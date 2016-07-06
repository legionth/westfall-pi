# westfall-pi


docker run --device /dev/ttyAMA0:/dev/ttyAMA0 --device /dev/mem:/dev/mem -v `pwd`:/var/www --privileged -p 80:80 -it westfall-pi