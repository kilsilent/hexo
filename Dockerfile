FROM node:8-alpine
MAINTAINER nieshkc@yonyou.com
ENV LANG C.UTF-8
ENV PACKAGE "vim git bash curl wget bash bash-completion tzdata bind-tools"

COPY init.sh /
VOLUME ["/data/hexo"]

WORKDIR /data/hexo

RUN set -x \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
    && echo 'http://mirrors.aliyun.com/alpine/edge/testing' >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache $PACKAGE \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && echo 'PS1="\[\e[01;36m\][\h \u:\[\e[01;34m\]\w\[\e[01;36m\]]\[\e[00m\]\$"; \
            alias ls="ls --color=auto" ; \
            alias l="ls -lah" ; \
            alias ll="ls -lh" ; \
            alias l.="ls -d .* --color=auto" ; \
            alias mv="mv -i" ; \
            alias rm="rm -i" ;' \
            >> /etc/profile.d/env.sh\
    && echo '. ~/.bashrc' > /root/.bash_profile \
    && echo '. /etc/profile' > /root/.bashrc \
    && yarn global add hexo-cli  \
    && /bin/rm -rf /tmp/* /var/cache/apk/*

EXPOSE 4000
CMD ["bash","/init.sh"]
