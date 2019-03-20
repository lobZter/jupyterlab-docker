SHELL:=bash

build: 
	docker build --rm --force-rm -t lobzter/jupyterlab-docker:latest .
push:
	docker push lobzter/jupyterlab-docker:latest
pull:
	docker pull lobzter/jupyterlab-docker:latest
rmi:
	docker rmi lobzter/jupyterlab-docker:latest
run: 
	docker run --runtime=nvidia -it --rm -p 8888:8888 -v ~/workspace:/workspace -w /workspace lobzter/jupyterlab-docker:latest
