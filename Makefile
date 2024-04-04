APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=yburylo13
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux # linux darwin windows
TARGETARCH=amd64 # arm64

define code_builder
	CGO_ENABLED=0 GOOS=$1 GOARCH=$2 go build -v -o kbot -ldflags "-X="github.com/burylo/kbot/cmd.appVersion=${VERSION}
endef

define image_builder
	docker build . --target $1 -t ${REGISTRY}/${APP}:${VERSION}-$2 --build-arg os=$1 --build-arg arch=$2
endef

format:
	gofmt -s -w ./ 

lint:
	golint 

test:
	go test -v

get:
	go get


build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/burylo/kbot/cmd.appVersion=${VERSION}

linux: format get
	$(call code_builder,linux,amd64)

linux_arm: format get
	$(call code_builder,linux,arm64)

macos: format get
	$(call code_builder,darwin,arm64)

windows: format get
	$(call code_builder,windows,amd64)


image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

image_linux:
	$(call image_builder,linux,amd64)

image_linux_arm:
	$(call image_builder,linux_arm,arm64)

image_macos:
	@echo "Sorry, but there is no Docker image for MacOS :("

image_windows:
	$(call image_builder,windows,amd64)

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
