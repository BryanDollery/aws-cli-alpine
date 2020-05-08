build:
	docker build --tag bryandollery/aws-cli-alpine .

aws:
	docker run -it --rm -v $(pwd):/host -v /var/run/docker.sock:/var/run/docker.sock bryandollery/aws-cli-alpine

run:
	docker run -it --rm -v $(pwd):/host --name aws-cli -v aws:/root/.aws -v /var/run/docker.sock:/var/run/docker.sock --entrypoint bash bryandollery/aws-cli-alpine

