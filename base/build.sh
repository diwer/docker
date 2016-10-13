
echo "centos/ssh build start"
docker rmi mshengs/centos:ssh -f
docker build -t mshengs/centos:ssh .
docker login --username=mshengs --password=diwers@163
docker push mshengs/centos:ssh
echo "centos/ssh build stop "