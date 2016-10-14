sed -i “” '/^[localhost]:10022/d' /Users/ming/.ssh/known_hosts
docker rm master -f
docker network create --driver=bridge hadoop
#docker run -it -h hadoop --name master -p 10022:22  mshengs/hadoop:base  
N=${1:-3}
docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 10022:22 \
                --name hadoop-master \
                --hostname hadoop-master \
                mshengs/hadoop:base 
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
                    -p 10022:22\
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                mshengs/hadoop:base /bin/bash
	i=$(( $i + 1 ))
done 