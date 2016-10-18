# cat Dockerfile

FROM mshengs/centos:ssh

MAINTAINER ming (ms.diwers@gmail.com)

# 安装 hadoop 
ADD hadoop-2.7.3.tar.gz /usr/local
RUN mv /usr/local/hadoop-2.7.3 /usr/local/hadoop

#配置操作用户 和无密码操作权限
RUN adduser hdoper
RUN chmod u+w /etc/sudoers
RUN sed -i '/root/a\hdoper ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
RUN chmod u-w /etc/sudoers

# 配置无密码登陆到本机，首相生成公私钥对，然后建立authorized_keys文件
RUN ssh-keygen -f /root/.ssh/id_rsa -N '' &&  cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

#配置 hadoop
ENV HADOOP_HOME=/usr/local/hadoop
RUN echo "HADOOP_HOME=/usr/local/hadoop">>/etc/profile
RUN echo 'PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin'>>/etc/profile
RUN source /etc/profile

#配置hadoop 配置文件
RUN mkdir -p /home/hdfs/namenode && \ 
    mkdir -p /home/hdfs/datanode && \
    mkdir -p /home/tmp && \
    mkdir $HADOOP_HOME/logs

COPY config/* /home/tmp/
#hadoop
RUN mv /home/tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \

    mv /home/tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
#hdfs
    mv /home/tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 

#mapreduce 配置
    mv /home/tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
#yarn 配置
    mv /home/tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
#datanode 配置
    mv /home/tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    
    mv /home/tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /home/tmp/ssh_config /root/.ssh/config 

RUN /usr/local/hadoop/bin/hdfs namenode -format

#CMD ["/usr/sbin/sshd", "-D"]