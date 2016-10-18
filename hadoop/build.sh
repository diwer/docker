source ../clear.sh
docker stop hadoop-master
docker stop hadoop-slave2
docker stop hadoop-slave3
docker stop hadoop-slave4
docker stop hadoop-slave1
docker rmi mshengs/hadoop:base -f

docker build -t mshengs/hadoop:base .
docker login --username=mshengs --password=diwers@163
#docker push mshengs/hadoop:base