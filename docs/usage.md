# Arangodb 使用指南

# 商品链接

[Arangodb-多模型数据库](https://marketplace.huaweicloud.com/hidden/contents/7d872a9d-47fa-4b47-9509-440d7700f1f8#productid=OFFI1166672361089519616)

# 商品说明

‌ArangoDB 是一个原生多模型开源数据库，具有用于文档、图形和键值的灵活数据模型。

# 商品购买

您可以在云商店搜索 **Arangodb**。

其中，地域、规格、推荐配置使用默认，购买方式根据您的需求选择按需/按月/按年，短期使用推荐按需，长期使用推荐按月/按年，确认配置后点击“立即购买”。

# 商品资源配置

商品支持 **ECS 控制台配置**，下面对资源配置的方式进行介绍。

## <a id="ECS控制台配置"></a>ECS 控制台配置

### 准备工作

在使用ECS控制台配置前，需要您提前配置好 **安全组规则**。

> **安全组规则的配置如下：**
> - 入方向规则放通端口 `8529`，**源地址内必须包含您的客户端 ip**，否则无法访问
> - 入方向规则放通 CloudShell 连接实例使用的端口 `22`，以便在控制台登录调试
> - 出方向规则一键放通

### 创建ECS

前提工作准备好后，选择 ECS 控制台配置跳转到购买 ECS 页面，ECS 资源的配置如下图所示：

![](images/img1.png)

![](images/img2.png)

![](images/img3.png)

> **值得注意的是：**
> - VPC 您可以自行创建
> - 安全组选择 [**准备工作**](#准备工作) 中配置的安全组；
> - 弹性公网IP选择现在购买，推荐选择“按流量计费”，带宽大小可设置为5Mbit/s；
> - 高级配置需要在高级选项支持注入自定义数据，所以登录凭证不能选择“密码”，选择创建后设置；
> - 其余默认或按规则填写即可。

# 商品使用

## Arangodb 使用

### 查看Arangodb服务端状态

systemctl status harbor
![](images/img4.png)

### 查看Arangodb容器状态

docker ps -a
![](images/img5.png)

### 访问Arangodb Web界面

http://ip:8529
账号：root 密码：test123
![](images/img6.png)
![](images/img7.png)
![](images/img8.png)

### 参考文档

[Arangodb官网](https://arangodb.com/)