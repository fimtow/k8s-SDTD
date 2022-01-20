FROM gettyimages/spark
COPY ./conf /usr/spark-2.4.1/conf
COPY ./conf /conf
ADD entrypoint.sh /entrypoint.sh
EXPOSE 7001 7002 7003 7004 7005 7077 6066 8080
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
