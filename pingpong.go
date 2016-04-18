package main

import (
	"fmt"
	"net/http"
)

func main() {
	addr := ":8080"
	http.HandleFunc("/ping", PingHandler)
	fmt.Println("Starting PingPong Server...")
	http.ListenAndServe(addr, nil)
}

func PingHandler(res http.ResponseWriter, req *http.Request) {
	fmt.Println("ping received.")
	fmt.Fprint(res, "pong")
	fmt.Println("pong sent.")
}
