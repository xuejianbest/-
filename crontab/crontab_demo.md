#  demo

### 查看/编辑当前用户定时任务
```shell
crontab -l # 查看
crontab -e # 编辑
```

### 例子

#### 每隔30分钟执行一次
0,30 * * * * ~/crontab/cur.sh ~/crontab/test/demo1.sh >> ~/crontab/log/demo1.log 2>&1

#### 每天01:00执行
0 1 * * * ~/crontab/cur.sh ~/crontab/test/demo2.sh >> ~/crontab/log/demo2.log 2>&1
