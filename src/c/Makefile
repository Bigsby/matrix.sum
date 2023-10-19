SRC_FILES=*.c
OUTPUT=matrix

$(OUTPUT): $(SRC_FILES)
	gcc $? -o $@

run: $(OUTPUT)
	./$(OUTPUT)


clean:
	[ -e $(OUTPUT) ] && rm $(OUTPUT)

.PHONY: run clean
