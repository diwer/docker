# cat Dockerfile

FROM centos

MAINTAINER dbyin

RUN yum install -y openssh-server

RUN echo "root:root" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]