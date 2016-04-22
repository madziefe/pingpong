#!/bin/sh 

export APP_NAME=pingpong
export BIN_PATH=build/bin/${APP_NAME}

if [[ "$1" != "" ]]; then
	BIN_PATH="$1"
fi

echo "--> Packaging..."
mkdir -p build/artifact
cp ${BIN_PATH} build/artifact/${APP_NAME}
docker build --build-arg APP_SRC=build/artifact/${APP_NAME} -t quay.io/acaleph/pingpong:latest .
docker tag -f quay.io/acaleph/pingpong:latest quay.io/acaleph/pingpong:${COMMIT}
if [[ "$BRANCH" != "" ]]; then
	docker tag -f quay.io/acaleph/pingpong:latest quay.io/acaleph/pingpong:${BRANCH}
fi
 
echo "--> Publishing..."
docker login -u "${dockeruser}" -p "${dockerpassword}" -e "${dockeremail}" quay.io
docker push quay.io/acaleph/pingpong:latest
docker push quay.io/acaleph/pingpong:${COMMIT}
if [[ "$BRANCH" != "" ]]; then
	docker push quay.io/acaleph/pingpong:${BRANCH}
fi
