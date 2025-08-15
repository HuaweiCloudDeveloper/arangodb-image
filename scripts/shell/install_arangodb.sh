#!/bin/bash

# ArangoDB Docker 安装脚本（智能镜像检查版）

# 安装Docker（如果尚未安装）
if ! command -v docker &> /dev/null; then
    echo "安装Docker..."
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker $USER
    newgrp docker
fi

# 检查是否已存在ArangoDB镜像
IMAGE_EXISTS=$(docker images -q arangodb)

if [ -z "$IMAGE_EXISTS" ]; then
    echo "拉取ArangoDB Docker镜像..."
    docker pull arangodb
else
    echo "检测到已存在ArangoDB镜像，跳过下载步骤。"
    docker images arangodb
fi

# 检查是否已存在同名容器
CONTAINER_EXISTS=$(docker ps -aq -f name=arangodb)

if [ -n "$CONTAINER_EXISTS" ]; then
    echo "检测到已存在ArangoDB容器，先停止并删除旧容器..."
    docker stop arangodb
    docker rm arangodb
fi

# 创建Docker容器
echo "创建ArangoDB容器..."
docker run -d \
    --name arangodb \
    -e ARANGO_ROOT_PASSWORD=test123 \
    -p 8529:8529 \
    -v arangodb_data:/var/lib/arangodb3 \
    --restart unless-stopped \
    arangodb

# 创建系统服务文件（Docker版本）
echo "创建系统服务..."
cat <<EOF | sudo tee /etc/systemd/system/arangodb-docker.service
[Unit]
Description=ArangoDB Docker Container
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a arangodb
ExecStop=/usr/bin/docker stop -t 2 arangodb

[Install]
WantedBy=default.target
EOF

# 启用并启动服务
echo "启用并启动ArangoDB Docker服务..."
sudo systemctl daemon-reload
sudo systemctl enable arangodb-docker
sudo systemctl start arangodb-docker

echo -e "\n安装完成！ArangoDB Docker容器已作为系统服务运行。"
echo -e "\n管理命令:"
echo "启动服务: sudo systemctl start arangodb-docker"
echo "停止服务: sudo systemctl stop arangodb-docker"
echo "查看状态: sudo systemctl status arangodb-docker"
echo -e "\nWeb界面访问: http://<服务器IP>:8529"
echo "用户名: root"
echo "密码: test123"
echo -e "\n数据卷位置: $(docker volume inspect arangodb_data --format '{{.Mountpoint}}')"