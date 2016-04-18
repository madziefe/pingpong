package main

import (
	"errors"
	"net/http"
	"testing"
)

type MockResponseWriter struct {
	data []byte
}

func (m *MockResponseWriter) WriteHeader(header int) {}

func (m *MockResponseWriter) Header() http.Header {
	return nil
}

func (m *MockResponseWriter) Write(bytes []byte) (int, error) {
	if len(bytes) == 0 {
		return 0, errors.New("nothing written")
	}
	m.data = bytes
	return len(bytes), nil
}

func TestPingHandler(t *testing.T) {

	res := &MockResponseWriter{}

	PingHandler(res, nil)

	pong := string(res.data)
	if pong != "pong" {
		t.Errorf("expected pong, got %s", pong)
	}
}
