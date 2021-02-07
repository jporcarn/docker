docker image build --tag aspnetvb6:v2 .
docker container run --detach --publish 80 aspnetvb6:v2
docker ps
docker inspect 966b4454d3b1
