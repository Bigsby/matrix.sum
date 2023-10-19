SRC_FILES=$(wildcard *.c)
OBJ_FILES=$(patsubst %.c,%.o,$(SRC_FILES))
OUTPUT=matrix

$(OUTPUT): $(OBJ_FILES)
	gcc -o $@ $?

$(OBJ_FILES): $(SRC_FILES)
	gcc -c $?

run: $(OUTPUT)
	./$(OUTPUT)

clean:
	[ -e $(OUTPUT) ] && rm $(OUTPUT)
	rm *.o

.PHONY: run clean
