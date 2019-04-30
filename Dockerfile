FROM linuxserver/qbittorrent

RUN apt update && apt install -y python3
RUN curl https://rclone.org/install.sh | sed 's/^    mandb/# /'  | bash
RUN curl https://raw.githubusercontent.com/victor141516/transmission-rclone-docker/master/on_download_finish.sh > /on_download_finish.sh
RUN curl https://raw.githubusercontent.com/victor141516/transmission-rclone-docker/master/remove_until_size.py > /remove_until_size.py
RUN chmod +x on_download_finish.sh
RUN sed -i 's/^enabled=false/enabled=true/' /defaults/qBittorrent.conf
RUN sed -i 's/^program=/program=\/on_download_finish.sh/' /defaults/qBittorrent.conf
RUN sed -i 's/^Downloads\\TempPath/Downloads\\TempPathEnabled=true\nDownloads\\TempPath/' /defaults/qBittorrent.conf
RUN sed -i 's/^Downloads\\SavePath=\/downloads\//Downloads\\SavePath=\/downloads\/complete\//' /defaults/qBittorrent.conf
RUN mkdir -p /logs

