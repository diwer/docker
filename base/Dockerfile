# cat Dockerfile

FROM centos

MAINTAINER ming (ms.diwers@gmail.com)

RUN yum install -y openssh-server openssh-clients vim wget  java-1.8.0-openjdk
#创建下载目录 
RUN mkdir /home/download 
#获取 maven 验证java_home 用 无意义 start
# RUN wget http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
# RUN tar -zxvf /home/download/apache-maven-3.3.9-bin.tar.gz /usr/local
# RUN mv /usr/local/apache-maven-3.3.9-bin /usr/local/maven
#end 

RUN echo "JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.102-1.b14.el7_2.x86_64/jre">>/etc/profile

RUN source /etc/profile

RUN echo "root:root" | chpasswd

EXPOSE 22
# 生成必要的host key文件，否则，/usr/sbin/sshd将无法启动
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' &&\
    ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' &&  \
    ssh-keygen -q -t dsa -f /etc/ssh/ssh_host_ed25519_key  -N '' 

# 配置无密码登陆到本机，首相生成公私钥对，然后建立authorized_keys文件
RUN ssh-keygen -f /root/.ssh/id_rsa -N '' &&  cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

RUN sed -i \
    -e "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" \
	-e 's/PasswordAuthentication no/PasswordAuthentication yes/g' \
	-e 's/PermitRootLogin no/PermitRootLogin yes/g' \
	-e 's/#UseDNS yes/UseDNS no/g' \
    /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-D"]