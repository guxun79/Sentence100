# 重置列表序号脚本 - 所有列表项重置为1.
Write-Host "开始修复所有category文件中的列表序号，全部重置为1...." -ForegroundColor Green

# 处理所有category文件
$files = Get-ChildItem -Path "docs\category-*.md"

foreach ($file in $files) {
    Write-Host "处理文件: $($file.Name)"
    
    # 读取文件内容
    $lines = Get-Content -Path $file.FullName -Encoding UTF8
    $newLines = @()
    
    foreach ($line in $lines) {
        if ($line -match "^\s*\d+\s*\.") {
            # 这是列表项，替换为1.
            $newLine = $line -replace "^\s*\d+\s*\.", "1."
            $newLines += $newLine
        } else {
            # 非列表项，保持不变
            $newLines += $line
        }
    }
    
    # 写回文件
    $newLines | Set-Content -Path $file.FullName -Encoding UTF8
    
    Write-Host "已修复文件: $($file.Name)" -ForegroundColor Cyan
}

Write-Host "所有文件修复完成!" -ForegroundColor Green