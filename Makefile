.PHONY:


run: goyacc
	go run main.go parser.go lexer.go

goyacc:
	./bin/goyacc -o parser.go parser.y

gen-goyacc:
	GO111MODULE=on go build -o bin/goyacc yacc/main.go yacc/format_yacc.go


