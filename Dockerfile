# cat Dockerfile

FROM centos

MAINTAINER dbyin

RUN yum install -y openssh-server

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