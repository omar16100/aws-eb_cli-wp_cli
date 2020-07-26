# Docker file to run AWS EB CLI tools.
FROM alpine

RUN apk --no-cache add \
        bash \
        less \
        groff \
        jq \
        git \
        curl \
        python3 \
        python3-pip \
        openssh-client

# Install awsebcli & awscli
RUN pip3 install --upgrade pip \
        awsebcli \
        awscli

# Route53
RUN curl -L https://github.com/barnybug/cli53/releases/download/0.8.7/cli53-linux-386 > /usr/bin/cli53 && \
    chmod +x /usr/bin/cli53

# Add WP-CLI 
RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
COPY wp-su.sh /bin/wp
RUN chmod +x /bin/wp-cli.phar /bin/wp

ENV PAGER="less"

# Expose credentials volume
RUN mkdir ~/.aws
