# YHDevLog
一款iOS可视化Log集成工具，调试代码，查看Log神器。

##如何开始
使用pod进行YHDevLog的安装。

```
pod "YHDevLog"
```
##快速导入
* 首先在Appdelegate中导入框架

```
#import <YHDevLogManager.h>
```
* 在需要的地方开启Debug模式

```
- (void)applicationDidBecomeActive:(UIApplication *)application {
    START_DEBUG_MODE()
}
```
* 之后在任何需要打印Log的地方引入YHDevLogManager，使用如下3个宏来打印Log

`LOG(msg,...)`

`ERROR_LOG(msg,...)`

`WARN_LOG(msg,...)`

* 在log信息上长按可以自动进行复制操作

## 无需处理
Log模块默认只在Debug模式下开启，因此不用担心上线时做修改。
## 预览
![效果图1](https://github.com/ZYHshao/YHDevLog/raw/master/1.png=100x400)

***

![效果图2](https://github.com/ZYHshao/YHDevLog/raw/master/2.png=100x400)

