run: compile
	node main.js

compile: *.ts
	npm install
	npx tsc main.ts

clean:
	rm *.js

.PHONY: run compile clean
