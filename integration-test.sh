#!/bin/sh -ex

test() {
	echo 'Delay to start integration test...'
	sleep 15

	local url="$1"
	echo "Running Integration Test for ${url}"

	pong=$(wget -q -O - "\"${url}/ping\"")

	if [ "$?" != "0" ]; then 
		echo "Error connecting to pingpong server."
		return 1
	fi

	if [ "${pong}" != "pong" ]; then
		echo "didn't receive the correct response."
		return 1
	fi

	echo "Test successful."
	return 0		
}

test $@