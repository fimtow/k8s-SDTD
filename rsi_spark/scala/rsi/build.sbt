name := "RSI"

version := "1.0"

scalaVersion := "2.11.12"

libraryDependencies += "org.apache.spark" %% "spark-streaming" % "2.4.1" % "provided"

libraryDependencies += "org.apache.spark" %% "spark-streaming-kafka-0-8" % "2.4.1"

libraryDependencies += "org.apache.kafka" %% "kafka" % "2.4.1"

libraryDependencies += "org.apache.spark" %% "spark-sql" % "2.4.1" % "provided"

libraryDependencies += "com.datastax.spark" % "spark-cassandra-connector_2.11" % "2.4.1"

