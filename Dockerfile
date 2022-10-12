FROM mono:slim

# Update and install needed utils
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl nano zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY 1_download.sh /terraria/run/
COPY 2_start.sh /terraria/run/
COPY run.sh /terraria/run/

# Used by scripts
ENV DOWNLOAD_VERSION=1445
ENV FILENAME_CONFIG=serverconfig.txt
ENV FILENAME_WORLD=world.wld
ENV FILENAME_BANLIST=banlist.txt

# Allow for external data
VOLUME ["/terraria/config"]

# Run the server
EXPOSE 7777
WORKDIR /terraria/run
RUN chmod +x 1_download.sh && \
    chmod +x 2_start.sh && \
    chmod +x run.sh
CMD ["./run.sh"]
