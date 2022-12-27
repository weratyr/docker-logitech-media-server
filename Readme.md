


# build 
 docker build -t weratyr/lms . 


# run 
docker run -p 9000:9000 -p 9090:9090 -p 3483:3483 -p 3483:3483/udp -v /etc/localtime:/etc/localtime:ro -v lms:/srv/squeezebox  -v /mnt/450gb/mp3/:/srv/music -v /mnt/450gb/mp3/lmc:/srv/playlist --name lms --restart always weratyr/lms:latest
