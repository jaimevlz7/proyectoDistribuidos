FROM httpd:2.2

#Agregamos la llave publica a la carpeta tmp
ADD keys/public.asc /tmp
#Agregamos la llave al llavero del sistema
RUN apt-key add /tmp/public.asc
#Eliminanos la llave de la carpeta por motivos de seguridad
RUN rm -f /tmp/public.asc

#Agregamos el entrypoint 
ADD /conf/Entrypoint.sh /scripts/Entrypoint.sh
#Ejecutamos el entrypoint					
RUN chmod +x /scripts/Entrypoint.sh

#Ejecutamos la actualización
RUN apt-get update
#Instalamos Curl
RUN apt-get install curl -y

WORKDIR /scripts
CMD ["./Entrypoint.sh"]
