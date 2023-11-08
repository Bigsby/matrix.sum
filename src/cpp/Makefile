SRC_FILES=$(wildcard *.cpp)
OBJ_FILES=$(patsubst %.cpp,%.o,$(SRC_FILES))
OUTPUT=matrix

$(OUTPUT): $(OBJ_FILES)
	g++ -o $@ $?

$(OBJ_FILES): $(SRC_FILES)
	g++ -c $? -std=c++17

run: $(OUTPUT)
	./$(OUTPUT)

clean:
	[ -e $(OUTPUT) ] && rm $(OUTPUT)
	rm *.o

.PHONY: run clean
