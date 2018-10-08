REPO=wisecloud/wise2c-store
VERSION=latest
DEV_VERSION=cmft-dns

path=./store

.PHONY:download build push test test_shell
download:
	mkdir -p ${path}
	echo "=== download k8s.tar.bz2 ==="
	curl -# -S https://kubernetes-1254077886.cos.ap-chengdu.myqcloud.com/k8s.tar.bz2 \
    -o ${path}/k8s.tar.bz2
	echo "=== download mysql-5.7.tar.bz2 ==="
	curl -# -S https://kubernetes-1254077886.cos.ap-chengdu.myqcloud.com/mysql-5.7.tar.bz2 \
    -o ${path}/mysql-5.7.tar.bz2
	echo "=== download alanpeng-keepalived-2.0.tar ==="
	curl -# -S https://kubernetes-1254077886.cos.ap-chengdu.myqcloud.com/alanpeng-keepalived-2.0.tar \
    -o ${path}/alanpeng-keepalived-2.0.tar
	echo "=== download haproxy-1.7.tar.bz2 ==="
	curl -# -S https://kubernetes-1254077886.cos.ap-chengdu.myqcloud.com/haproxy-1.7.tar.bz2 \
    -o ${path}/haproxy-1.7.tar.bz2
	echo "=== download harbor-offline-installer-v1.5.1.tgz ==="
	curl -# -S https://kubernetes-1254077886.cos.ap-chengdu.myqcloud.com/harbor-offline-installer-v1.5.1.tgz \
    -o ${path}/harbor-offline-installer-v1.5.1.tgz

build:
	docker build -t $(REPO):$(VERSION) .

push:
	#docker login -uwisecloud -p<<password>> 
	docker tag $(REPO):$(VERSION) $(REPO):$(DEV_VERSION)
	docker push $(REPO):$(VERSION)
	docker push $(REPO):$(DEV_VERSION)

test:
	-docker-compose down
	docker-compose up -d

test_shell:
	docker run -d --name wise2c-store $(REPO):$(VERSION)
	rm -rf ${PWD}/tmp
	mkdir -p ${PWD}/tmp
	docker cp wise2c-store:/store/k8s.tar.bz2  ${PWD}/tmp
	docker rm -f wise2c-store
