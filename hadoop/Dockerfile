# cat Dockerfile

FROM mshengs/centos:ssh

MAINTAINER ming (ms.diwers@gmail.com)

# 安装 hadoop 
ADD hadoop-2.7.3.tar.gz /usr/local
RUN mv /usr/local/hadoop-2.7.3 /usr/local/hadoop

#配置操作用户 和无密码操作权限
RUN adduser hdoper
RUN chmod u+w /etc/sudoers
RUN sed -i ‘’ '/root	ALL=(ALL) 	ALL/a\hdoper ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
RUN chmod u-w /etc/sudoers

# 配置无密码登陆到本机，首相生成公私钥对，然后建立authorized_keys文件
RUN ssh-keygen -f /root/.ssh/id_rsa -N '' &&  cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

RUN echo "HADOOP_HOME=/usr/local/hadoop">>/etc/profile
RUN echo 'PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin'>>/etc/profile
RUN source /etc/profile


#CMD ["/usr/sbin/sshd", "-D"]