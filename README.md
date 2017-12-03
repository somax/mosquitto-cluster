# mosquitto ha

mosquitto 容器集群化部署，基于官方镜像 `eclipse-mosquitto` 

> 参考了 https://github.com/roobytwo/mosquitto-HA.git

## 环境变量

如果配置了 `MOSQUITTO_BRIDGE_NODES`, 会自动向 `mosquitoo.conf` 添加 bridge 相关配置

```
MOSQUITTO_BRIDGE_NODES="bridge-master:1883 bridge-slave:1883" # bridge 节点，可配置多个
MOSQUITTO_OTHER_BROKERS=mosquitto1,mosquitto3 # 集群中其他节点
MOSQUITTO_LOG_DEST=syslog,topic
MOSQUITTO_LOG_TYPE=error,debug

```