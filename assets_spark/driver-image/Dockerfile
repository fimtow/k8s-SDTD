FROM gettyimages/spark
COPY ./conf /usr/spark-2.4.1/conf
COPY ./conf /conf
COPY ./code /usr/spark-2.4.1/code
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 7001 4040 5003
ENTRYPOINT [ "/entrypoint.sh" ]
