#!/bin/sh -e

export APP_NAME=pingpong
export BIN_PATH=build/bin
export ARTIFACT_PATH=

if [[ "$1" != "" ]]; then
	ARTIFACT_PATH="$1"
fi

echo "--> Packaging..."
mkdir -p build/bin
if [[ "$ARTIFACT_PATH" != "" ]]; then
	echo "copy ${ARTIFACT_PATH} to ${BIN_PATH}"
	cp ${ARTIFACT_PATH} ${BIN_PATH}
fi
docker build -t quay.io/acaleph/pingpong:latest  -f Dockerfile .
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
