# mosquitto cluster

mosquitto 容器集群化部署，基于官方镜像 `eclipse-mosquitto` 

> 参考 https://github.com/roobytwo/mosquitto-HA.git

## 环境变量

    MOSQUITTO_AS: ha_broker # 指明容器作为高可用节点运行，config 会添加 bridge 相关配置
    MOSQUITTO_BRIDGE_NODES: bridge-master:1883 bridge-slave:1883 # bridge 节点，可配置多个
    MOSQUITTO_OTHER_BROKERS: mosquitto1,mosquitto3 # 集群中其他节点
