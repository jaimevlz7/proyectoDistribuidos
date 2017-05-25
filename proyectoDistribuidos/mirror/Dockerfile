FROM ubuntu:16.04

#Agregamos la llave privada 
ADD /keys/private.asc /keys/private.asc
#Agregamos el archivo de configuracion de Aptly		
ADD /conf/aptly.conf /etc/aptly.conf

#Importamos la llave con gpp 
RUN gpg --import /keys/private.asc
#Eliminamos la llave por seguridad
RUN rm -f /keys/private.asc

#Agregamos la llave
RUN gpg --no-default-keyring --keyring /usr/share/keyrings/ubuntu-archive-keyring.gpg --export | gpg --no-default-keyring --keyring trustedkeys.gpg --import

#Instalamos aptly
RUN echo deb http://repo.aptly.info/ squeeze main > /etc/apt/sources.list
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 9E3E53F19C7DE460
RUN apt-get update
RUN apt-get install aptly -y

#Instalamos las dependencias que requiere Aptly			
RUN echo deb http://co.archive.ubuntu.com/ubuntu/ xenial main restricted >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install xz-utils -y
RUN apt-get install bzip2 -y

#Agregamos el mirror a la lista del sistema
RUN echo deb http://co.archive.ubuntu.com/ubuntu/ xenial universe >> /etc/apt/sources.list
#Ejecutamos una actualizacion de librerias
RUN apt-get update
RUN apt-get install expect -y

#Configuramos el mirror			
RUN aptly mirror create -architectures=amd64 -filter='Priority (required) | Priority (important) | Priority (standard) | postgresql' -filter-with-deps mirror-xenial http://mirror.upb.edu.co/ubuntu/ xenial main
RUN aptly mirror update mirror-xenial

#Agregamos y ejecutamos la configuracion para la publicacion
ADD /conf/publish_snapshot.sh /scripts/publish_snapshot.sh
RUN chmod +x /scripts/publish_snapshot.sh

#Agregamos y ejecutamos el entrypoint
ADD /conf/Entrypoint.sh /scripts/Entrypoint.sh
RUN chmod +x /scripts/Entrypoint.sh

CMD ["./scripts/Entrypoint.sh"]
