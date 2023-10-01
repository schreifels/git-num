.PHONY: clean
clean:
	rm -rf build
	go clean

.PHONY: build
build: clean
	mkdir -p build
	go build -o build/git-num

.PHONY: test
test:
	go mod tidy
	go test ./...

.PHONY: all
all: test build

.PHONY: dist
dist: test clean
	GOARCH=amd64 GOOS=darwin go build -o build/git-num
	tar -zcvf build/git-num-macos-amd64.tar.gz -C build git-num
	rm build/git-num
	GOARCH=arm64 GOOS=darwin go build -o build/git-num
	tar -zcvf build/git-num-macos-arm64.tar.gz -C build git-num
	rm build/git-num
