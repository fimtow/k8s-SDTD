#!/bin/bash

case "$1" in
    master)
        "bin/spark-class" org.apache.spark.deploy.master.Master \
            -h $SPARK_MASTER_HOST
        ;;
        *)
    	/bin/bash
    	tail -f /dev/null
        ;;
esac
