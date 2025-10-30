#!/bin/bash

# 修正所有markdown文件中的列表序号（全部重置为1.）

echo "开始修复所有category文件中的列表序号，全部重置为1...."

# 处理所有category-*.md文件
for file in docs/category-*.md; do
  if [ -f "$file" ]; then
    echo "处理文件: $(basename "$file")"
    
    # 创建临时文件
    temp_file="${file}.tmp"
    
    # 使用sed处理文件，将所有数字开头的列表项替换为1.
    sed 's/^\([[:space:]]*\)[0-9]\+[[:space:]]*\./\11./g' "$file" > "$temp_file"
    
    # 替换原文件
    mv "$temp_file" "$file"
    
    echo "已修复文件: $(basename "$file")"
  fi
done

echo "所有文件修复完成!"