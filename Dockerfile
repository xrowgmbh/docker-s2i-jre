FROM centos:7

ENV STI_SCRIPTS_PATH=/usr/libexec/s2i \
    APP_ROOT=/opt/app-root \
    HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:$PATH

LABEL io.k8s.description="Java runtime (JRE) image" \
      io.k8s.display-name="s2i-jre" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.openshift.s2i.assemble-input-files="/opt/app-root/src/target" \
      io.openshift.tags="java,springboot"

WORKDIR ${HOME}

RUN useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin -c "Default Application User" default \
 && chown -R 1001:0 ${APP_ROOT}

ARG JAVA_VERSION="1.8.0"

RUN yum install -y java-$JAVA_VERSION-openjdk

COPY s2i/bin $STI_SCRIPTS_PATH

RUN chmod +x $STI_SCRIPTS_PATH/*

USER 1001
