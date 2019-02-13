FROM mariadb:10.1
#FROM centos:7

#RUN yum install -y epel-release && \
#    yum update -y && \
#    yum install -y mariadb \
#                   && yum clean all

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod u+x wait-for-it.sh
COPY schema.sql /schema.sql
