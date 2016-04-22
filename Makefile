APP_NAME = pingpong
BIN_PATH = build/bin/${APP_NAME}

all: clean deps build

clean:
	@echo "--> Cleaning..."
	@rm -rfv ./build

format:
	@echo "--> Formatting..."
	@go fmt ./...

deps:
	@echo "--> Getting dependencies..."
	@go get -v -d ./...
	@go get -v github.com/golang/lint/golint

test: format
	@echo "--> Testing..."
	@go test -v ./...

lint:
	@echo "--> Running go lint..."
	golint ./...


build: format
	@echo "--> Building..."
	@mkdir -p build/bin
	@CGO_ENABLED=0 go build -a -installsuffix cgo -o ${BIN_PATH} .
