import kafka.serializer.StringDecoder
import org.apache.spark.{SparkConf, TaskContext}
import org.apache.spark.streaming.dstream.InputDStream
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.sql.SparkSession
import org.apache.spark.rdd._
import org.apache.spark.sql.functions._
import org.apache.spark.streaming.{Seconds, StreamingContext}
import com.datastax.spark.connector._ 

object Main {
    val list = List("1","2","3","4","5","6","7","8","9","10")
    val spark = SparkSession
		  .builder()
		  .appName("market dominance")
		  .getOrCreate()
    import spark.implicits._
    val sc = spark.sparkContext

    def read(rdd: RDD[String]): Unit = {
    
    	   val df = spark.read.option("multiline","true").json(rdd)
    	   //val df2 = df.select($"timestamp",explode($"data"))
    	   val df2 = df.withColumn("timestamp",current_timestamp().as("timestamp"))
    	   val sum_market = df.select(sum("marketCapUsd")).first.get(0)
    	   df2.persist()
    	   val df_filtered = df2.filter(($"rank".isin(list: _*))).select($"name",$"timestamp",$"rank", $"marketCapUsd" /sum_market)
    	   df_filtered.rdd.saveToCassandra("cryptocurrency", "coin_by_marketdominance", SomeColumns("name" as "_1", "datetime" as "_2","rank" as "_3","market_dominance" as "_4"))
    	   
    }
  
    def main(args: Array[String]) = {
    
    	    val ssc = new StreamingContext(sc, Seconds(1))
    	    val topics = Set[String]("assets")
	    val kafkaParams = Map[String, String](
	      "zookeeper.connect" -> "zookeeper-svc.default.svc.cluster.local:2181",
	      "group.id" -> "driver1",
	      "bootstrap.servers" -> "broker-svc.default.svc.cluster.local:29092,broker2-svc.default.svc.cluster.local:29093,broker3-svc.default.svc.cluster.local:29094"
	    )
	    val topic = topics.last
	    val kafkaStream = KafkaUtils.createDirectStream[String, String, StringDecoder, StringDecoder](ssc, kafkaParams, topics)
	    kafkaStream.foreachRDD{ rdd => 	    	
	    	val data = rdd.map(_._2)
	    	read(data)
     	 }
     	     
	    ssc.start()
	    ssc.awaitTermination()  
	    
    }
}
