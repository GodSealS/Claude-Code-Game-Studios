#!/usr/bin/env bash
# Notification hook — fires when CodeBuddy sends a notification
# 通知钩子——当CodeBuddy发送通知时触发
# Shows a Windows toast via PowerShell
# 通过PowerShell显示Windows toast通知

# Read notification JSON from stdin
# 从标准输入读取通知JSON
INPUT=$(cat)

# Extract message — try jq first, fall back to grep
# 提取消息——先尝试jq，回退到grep
if command -v jq &>/dev/null; then
  MESSAGE=$(echo "$INPUT" | jq -r '.message // empty' 2>/dev/null)
fi
if [ -z "$MESSAGE" ]; then
  MESSAGE=$(echo "$INPUT" | grep -oE '"message":"[^"]*"' | sed 's/"message":"//;s/"//')
fi
if [ -z "$MESSAGE" ]; then
  MESSAGE="CodeBuddy needs your attention"
fi

# Sanitize message for PowerShell string embedding (escape single quotes)
# 为PowerShell字符串嵌入清理消息（转义单引号）
MESSAGE_SAFE=$(echo "$MESSAGE" | sed "s/'/''/g" | head -c 200)

# Show Windows balloon tip notification (works on all Windows 10/11 without extra modules)
# 显示Windows气球提示通知（适用于所有Windows 10/11，无需额外模块）
powershell.exe -NonInteractive -WindowStyle Hidden -Command "
  Add-Type -AssemblyName System.Windows.Forms
  \$notify = New-Object System.Windows.Forms.NotifyIcon
  \$notify.Icon = [System.Drawing.SystemIcons]::Information
  \$notify.BalloonTipTitle = 'CodeBuddy'
  \$notify.BalloonTipText = '$MESSAGE_SAFE'
  \$notify.Visible = \$true
  \$notify.ShowBalloonTip(5000)
  Start-Sleep -Seconds 6
  \$notify.Dispose()
" 2>/dev/null &

echo "Notification: $MESSAGE_SAFE"
