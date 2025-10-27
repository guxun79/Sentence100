#!/bin/bash

# 跨平台合并脚本 - 可在Git Bash、macOS和Linux上运行

OUTPUT_FILE="docs/sentence100.md"

# 创建文件
cat > "$OUTPUT_FILE" << 'EOL'
# 100个句子记完1200个小学单词

This document contains all 18 categories of English sentences for overall learning and memorization.

## 目录

EOL

# 添加目录
for i in {1..18}; do
  echo "- [$i](#$i)" >> "$OUTPUT_FILE"
done

echo "" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 处理每个分类
for i in {1..18}; do
  # 添加分类标题
  echo "### $i" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  
  # 检查文件是否存在
  FILE="docs/category-$i.md"
  if [ -f "$FILE" ]; then
    # 读取文件内容并添加
    cat "$FILE" >> "$OUTPUT_FILE"
  else
    echo "Category $i (no content yet)" >> "$OUTPUT_FILE"
  fi
  
  echo "" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
done

# 添加页脚
echo "---" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "> Note: This file contains all 18 categories of English sentences for overall learning and memorization." >> "$OUTPUT_FILE"

# 显示完成信息
echo "合并完成: $OUTPUT_FILE"

echo "注意: 请在Git Bash或其他shell环境中运行此脚本"