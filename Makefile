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

package: 
	@echo "--> Packaging..."
	@mkdir -p build/artifact
	@cp ${BIN_PATH} build/artifact/${APP_NAME}
	@docker build --build-arg APP_SRC=build/artifact/${APP_NAME} -t quay.io/acaleph/pingpong:latest .
	@docker tag -f quay.io/acaleph/pingpong:latest quay.io/acaleph/pingpong:${DOCKER_TAG}

publish: 
	@echo "--> Publishing..."
	@docker login -u "${dockeruser}" -p "${dockerpassword}" -e "${dockeremail}" quay.io
	@docker push quay.io/acaleph/pingpong:latest
	@docker push quay.io/acaleph/pingpong:${DOCKER_TAG}
