run: main.jar
	java -jar $^

main.jar: *.kt
	kotlinc -include-runtime -d $@ $^

clean:
	rm *.jar

.PHONY: run clean


