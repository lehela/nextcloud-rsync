FROM debian:latest

ARG user
ARG password

RUN apt update &&\
    DEBIAN_FRONTEND=noninteractive \
    apt install -y rsyslog rsync davfs2 

RUN mkdir /mnt/webdav  &&\
    # echo "https://goocloud.lehela.com/remote.php/dav/files/${user}/        /mnt/webdav/  davfs   rw,auto,_netdev 0 0" >> /etc/fstab &&\
    echo "http://192.168.2.120:8089/remote.php/dav/files/${user}/        /mnt/webdav/  davfs   rw,auto,_netdev 0 0" >> /etc/fstab &&\
    echo "/mnt/webdav/ ${user} ${password}" >> /etc/davfs2/secrets 

CMD ["sleep", "infinity"]
