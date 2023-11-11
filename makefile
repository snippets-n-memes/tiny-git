SHELL:=/bin/bash
.PHONY: docker-run

docker-run:
	docker run -d \
		-p 8080:22 \
		-v $$(pwd)/id_rsa.pub:/home/git/.ssh/authorized_keys \
		ghcr.io/snippets-n-memes/tiny-git:amd64-20231111.21

docker-kill:
	docker kill $$(docker ps | grep -Po "[a-z0-9]*\s*(?=ghcr.io/snippets-n-memes/tiny-git)") 2> /dev/null \
		|| echo -e "\nContainer not found...\nSkipping kill..."