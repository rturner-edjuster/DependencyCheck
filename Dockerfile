FROM java:8

MAINTAINER Timo Pagel <dependencycheckmaintainer@timo-pagel.de>

ENV user=dockeruser

RUN wget -O /tmp/current.txt http://jeremylong.github.io/DependencyCheck/current.txt && \
 current=$(cat /tmp/current.txt) && \
 wget https://dl.bintray.com/jeremy-long/owasp/dependency-check-$current-release.zip && \
 unzip dependency-check-$current-release.zip && \
 rm dependency-check-$current-release.zip && \
 mv dependency-check /usr/share/

RUN useradd -ms /bin/bash ${user} && \
 chown -R ${user}:${user} /usr/share/dependency-check && \
 mkdir /report && \
 chown -R ${user}:${user} /report

USER ${user}

VOLUME ["/src" "/usr/share/dependency-check/data" "/report"]

WORKDIR /report

CMD ["--help"]
ENTRYPOINT ["/usr/share/dependency-check/bin/dependency-check.sh"]
