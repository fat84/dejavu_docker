MYSQL_ROOT_PASSWORD=dejavu
MYSQL_USER=dejavu
MYSQL_PASSWORD=dejavu
MYSQL_DATABASE=dejavu
MYSQL_CONTAINER_NAME=dejavu_mysql

cd
cd dejavu_docker
git pull
sudo docker build -t dejavu/server .

name=$MYSQL_CONTAINER_NAME
[[ $(sudo docker ps -f "name=$name" --format '{{.Names}}') == $name ]] ||
sudo docker start $name

name=myadmin
[[ $(sudo docker ps -f "name=$name" --format '{{.Names}}') == $name ]] ||
sudo docker start $name

sudo docker stop dejavu_server
sudo docker rm dejavu_server

sudo docker run --name dejavu_server -v /data/library:/data/library --detach --link $MYSQL_CONTAINER_NAME:mysql --publish 8080:8080 dejavu/server
