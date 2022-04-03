package main

import (
	"fmt"
	"net/http"

	"goji.io"
	"goji.io/pat"
)

func setupRouter() *goji.Mux {
	mux := goji.NewMux()
	mux.HandleFunc(pat.Get("/ping"), func(rw http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(rw, "pong")
	})
	return mux
}

func main() {
	mux := setupRouter()
	http.ListenAndServe(":8080", mux)
}
