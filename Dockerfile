# FROM ubuntu:22.04
# RUN apt-get update && apt-get install -y python3 python3-pip
# RUN pip install flask==2.1.*
# COPY . /
# ENV FLASK_APP=app
# EXPOSE 9090
# CMD flask run --host 0.0.0.0 --port 9090

FROM  centos:latest
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install -y httpd \
zip \
unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80 22


# FROM  centos:latest
# RUN cd /etc/yum.repos.d/
# RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
# RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
# RUN yum install -y httpd \
# zip \
# unzip
# ADD https://www.free-css.com/assets/files/free-css-templates/download/page296/little-fashion.zip /var/www/html/
# WORKDIR /var/www/html/
# RUN unzip little-fashion.zip
# RUN cp -rvf 2127_little_fashion/* .
# RUN rm -rf little-fashion little-fashion.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 80 22
