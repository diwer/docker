sed -i “” '/[localhost]:10022/d' /Users/ming/.ssh/known_hosts
docker rm master -f
docker run -it -h hadoop --name master -p 10022:22  mshengs/hadoop:base