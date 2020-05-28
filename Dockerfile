from alpine:3.11.6

arg TZ="Africa/Nairobi"

env GLIBC_VER=2.31-r0

run apk add --no-cache openssl openssh-client tzdata vim curl bash jq zip unzip git ca-certificates make docker docker-compose binutils && \
    curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub && \
    curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk && \
    curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk && \
    apk add --no-cache glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk && \
    curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && \
    unzip awscliv2.zip && \
    aws/install && \
    rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk upgrade --purge && \
    rm -rf /var/cache/apk/*

entrypoint ["/usr/local/bin/aws"]
