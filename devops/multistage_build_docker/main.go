package main

import (
    "fmt"
    "log"
    "net/http"
    "os"
    "time"
)

func rootHandler(w http.ResponseWriter, r *http.Request) {
    host, _ := os.Hostname()

    fmt.Fprintf(w, "Hello from Docker multistage build!\n")
    fmt.Fprintf(w, "Time: %s\n", time.Now().Format(time.RFC3339))
    fmt.Fprintf(w, "Hostname: %s\n", host)
    fmt.Fprintf(w, "Path: %s\n", r.URL.Path)
}

func main() {
    mux := http.NewServeMux()
    mux.HandleFunc("/", rootHandler)

    addr := ":8080"
    log.Printf("listening on %s", addr)
    log.Fatal(http.ListenAndServe(addr, mux))
}
