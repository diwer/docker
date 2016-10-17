source ../clear.sh
docker rmi mshengs/hadoop:base -f

docker build -t mshengs/hadoop:base .
docker login --username=mshengs --password=diwers@163
docker push mshengs/hadoop:base