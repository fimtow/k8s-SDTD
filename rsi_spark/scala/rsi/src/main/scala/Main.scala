import kafka.serializer.StringDecoder
import org.apache.spark.{SparkConf, TaskContext}
import org.apache.spark.streaming.dstream.InputDStream
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.sql.SparkSession
import org.apache.spark.rdd._
import org.apache.spark.sql.functions._
import org.apache.spark.streaming.{Seconds, StreamingContext}
import com.datastax.spark.connector._ 
import org.apache.spark.sql._
import java.util.Calendar;

object Main {

    val spark = SparkSession
		  .builder()
		  .appName("rsi")
		  .getOrCreate()
    import spark.implicits._
    val sc = spark.sparkContext
    
    def read(rdd: RDD[String]): Unit = {
    
    	   val df0 = spark.read.option("multiline","true").json(rdd)
    	   val df = df0.orderBy($"period".desc).limit(34)
    	   df.persist()
    	   val rddx = df.rdd.map(r => if (r.getString(3).toDouble > r.getString(0).toDouble) 1.0 else 0.0
    	   )
    	   val x = rddx.reduce(_ + _)
    	   val rddy = df.rdd.map(r => if (r.getString(3).toDouble <= r.getString(0).toDouble) 1.0 else 0.0
    	   )
    	   val y = rddy.reduce(_ + _)
    	   val rsi :Double = 100.0 - (100.0 / ( 1 + x / y ) )
    	   val data = List(Row(Calendar.getInstance(),rsi))
    	   sc.parallelize(data).saveToCassandra("cryptocurrency", "candles_rsi", SomeColumns("datetime" as "_1", "rsi" as "_2"))
    }
  
    def main(args: Array[String]) = {
    	    val ssc = new StreamingContext(sc, Seconds(70))
    	    val topics = Set[String]("candles")
	    val kafkaParams = Map[String, String](
	       "zookeeper.connect" -> "zookeeper-svc.default.svc.cluster.local:2181",
	      "group.id" -> "candlesDriver",
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
