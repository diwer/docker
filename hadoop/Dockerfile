# cat Dockerfile

FROM mshengs/centos:ssh

MAINTAINER ming (ms.diwers@gmail.com)

ADD hadoop-2.7.3.tar.gz /usr/local

RUN mv /usr/local/hadoop-2.7.3 /usr/local/hadoop

RUN echo "HADOOP_HOME=/usr/local/hadoop">>/etc/profile
RUN echo 'PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin'>>/etc/profile
RUN source /etc/profile


#CMD ["/usr/sbin/sshd", "-D"]