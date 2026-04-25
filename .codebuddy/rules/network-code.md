---
paths:
  - "src/networking/**"
---

# Network Code Rules / 网络代码规则

- Server is AUTHORITATIVE for all gameplay-critical state — never trust the client / 服务器对所有玩法关键状态具有权威性 — 永远不要信任客户端
- All network messages must be versioned for forward/backward compatibility / 所有网络消息必须进行版本控制以确保前向/后向兼容
- Client predicts locally, reconciles with server — implement rollback for mispredictions / 客户端本地预测，与服务器协调 — 为错误预测实现回滚
- Handle disconnection, reconnection, and host migration gracefully / 优雅处理断连、重连和主机迁移
- Rate-limit all network logging to prevent log flooding / 对所有网络日志进行速率限制以防止日志洪泛
- All networked values must specify replication strategy: reliable/unreliable, frequency, interpolation / 所有网络值必须指定复制策略：可靠/不可靠、频率、插值方式
- Bandwidth budget: define and track per-message-type bandwidth usage / 带宽预算：定义并跟踪每种消息类型的带宽使用
- Security: validate all incoming packet sizes and field ranges / 安全：验证所有传入数据包的大小和字段范围
