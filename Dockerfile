FROM debian:sid

ENV BW_CLI_VERSION=2023.9.0

RUN apt update && \
    apt install -y wget unzip && \
    wget https://github.com/bitwarden/clients/releases/download/cli-v${BW_CLI_VERSION}/bw-linux-${BW_CLI_VERSION}.zip && \
    unzip bw-linux-${BW_CLI_VERSION}.zip && \
    chmod +x bw && \
    mv bw /usr/local/bin/bw && \
    rm -rfv *.zip

RUN groupadd -g 3001 bw && useradd -m -u 3000 -g bw bw
COPY entrypoint.sh /app/
RUN chown -R bw:bw /app
RUN chmod u+x /app/entrypoint.sh

USER bw
CMD ["/app/entrypoint.sh"]
