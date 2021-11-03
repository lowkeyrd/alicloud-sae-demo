FROM centos:7
# MAINTAINER：SAE研发团队

#安装打包必备软件。
RUN yum -y install wget unzip telnet

#准备JDK以及Tomcat系统变量。
ENV JAVA_HOME /usr/java/latest
ENV PATH $PATH:$JAVA_HOME/bin
ENV ADMIN_HOME /home/admin

#下载安装OpenJDK。
RUN yum -y install java-1.8.0-openjdk-devel

#下载部署SAE演示JAR包。
RUN mkdir -p /home/admin/app/ && \
         wget http://edas-hz.oss-cn-hangzhou.aliyuncs.com/demo/1.0/hello-edas-0.0.1-SNAPSHOT.jar -O /home/admin/app/hello-edas-0.0.1-SNAPSHOT.jar

#增加容器内中⽂支持。
ENV LANG="en_US.UTF-8"

#增强Webshell使⽤体验。
ENV TERM=xterm

#将启动命令写入启动脚本start.sh。
RUN mkdir -p /home/admin
RUN echo 'eval exec java -jar $CATALINA_OPTS /home/admin/app/hello-edas-0.0.1-SNAPSHOT.jar'> /home/admin/start.sh && chmod +x /home/admin/start.sh
WORKDIR $ADMIN_HOME
CMD ["/bin/bash", "/home/admin/start.sh"]