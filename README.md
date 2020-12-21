# Steem-in-a-box by @someguy123

**Steem-in-a-box** is a toolkit for using the Steem [docker images](https://hub.docker.com/r/someguy123/steem/tags/) published by @someguy123.

1.安装必要的依赖

sudo apt install libffi-dev libssl-dev python3 python3-dev python3-pip

2.安装 steem-python

pip3 install -U git+git://github.com/Netherdrake/steem-python

3.安装 conductor

pip3 install -U git+https://github.com/Netherdrake/conductor

4.更新系统，安装依赖，获取 steem-docker 的安装脚本

sudo apt update

sudo apt install git curl wget

git clone https://github.com/maiyude2018/steem-docker.git

cd steem-docker

5.安装 Docker，如果你的系统目前已经安装，则跳过该步

./run.sh install_docker

6.下载区块数据

docker run -v $(pwd)/:/download --rm leopere/axel-docker -n 5 https://files.steem.fans/data/steem_witness-20201218.tar.lz4

7.解压数据

tar xf steem_witness-20201218.tar.lz4 -I lz4 -C /root/steem-docker/data/witness_node_data_dir/

8.

启动

./run.sh start

重启

./run.sh restart

停止

./run.sh stop

重新replay

./run.sh replay
