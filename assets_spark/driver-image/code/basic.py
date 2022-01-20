from pyspark import SparkContext
 
if __name__ == "__main__":

	sc = SparkContext()
	lines = sc.parallelize(["Sur", "mes", "cahiers", "Sur", "mon", "pupitre"])
	#"Sur mes cahiers Sur mon pupitre"
	words = lines.flatMap(lambda line: line.split(' '))
	words_with_1 = words.map(lambda word: (word, 1))
	word_counts = words_with_1.reduceByKey(lambda count1, count2: count1 + count2)
	result = word_counts.collect()

	for (word, count) in result:
	    print(word, count)
