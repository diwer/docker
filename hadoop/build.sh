source ../clear.sh
docker rmi mshengs/hadoop:base -f
docker build -t mshengs/hadoop:base .