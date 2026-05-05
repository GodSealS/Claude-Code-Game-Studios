@echo off
chcp 65001 >nul
echo [CN -> CC] 正在根据 CC_CN_Config 切换模型配置...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0CN_2_CC.ps1"
if %errorlevel% neq 0 (
    echo 执行失败，请检查错误信息.
    pause
)
