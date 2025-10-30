#!/bin/bash

# 修正所有markdown文件中的列表序号（全局连续编号1-100）

echo "开始修复所有category文件中的列表序号，确保全局连续编号1-100..."

# 初始化全局计数器
global_counter=1

# 按照文件编号顺序处理category文件
for i in {1..18}; do
  file="docs/category-${i}.md"
  if [ -f "$file" ]; then
    echo "处理文件: $(basename "$file")"
    
    # 创建临时文件
    temp_file="${file}.tmp"
    
    # 使用awk处理文件，使用全局计数器
    awk -v counter=$global_counter '{
      # 检查是否是列表项（以数字+点开头）
      if ($0 ~ /^[[:space:]]*[0-9]+[[:space:]]*\./) {
        # 替换序号为全局连续编号
        gsub(/^[[:space:]]*[0-9]+[[:space:]]*\./, counter ".", $0)
        counter++
      }
      
      # 输出处理后的行
      print
    }' "$file" > "$temp_file"
    
    # 计算该文件中有多少个列表项，更新全局计数器
    list_count=$(grep -c '^[[:space:]]*[0-9]\+[[:space:]]*\.' "$temp_file")
    global_counter=$((global_counter + list_count))
    
    # 替换原文件
    mv "$temp_file" "$file"
    
    echo "已修复文件: $(basename "$file")，当前全局序号: $global_counter"
  fi
done

echo "所有文件修复完成! 总列表项数: $((global_counter - 1))"