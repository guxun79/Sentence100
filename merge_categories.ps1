# Simple category merge script using basic PowerShell syntax
$outputFile = "docs\sentence100.md"

# Create initial content with simple string concatenation
$content = "# 100个句子记完1200个小学单词`n`n"
$content += "This document contains all 18 categories of English sentences for overall learning and memorization.`n`n"
$content += "## 目录`n`n"

# Add table of contents
for ($i = 1; $i -le 18; $i++) {
    $content += "- [$i](#$i)`n"
}

$content += "`n`n"

# Process each category file
for ($i = 1; $i -le 18; $i++) {
    $filePath = "docs\category-$i.md"
    
    # Use number as title as requested
    $content += "### $i`n`n"
    
    if (Test-Path $filePath) {
        # Simplified file reading without try-catch
        $lines = Get-Content -Path $filePath
        
        if ($lines -ne $null -and $lines.Count -gt 0) {
            # Category title
            $title = $lines[0].TrimStart('# ')
            $content += "**$title**`n`n"
            
            # Add all sentences (skip title line)
            for ($j = 1; $j -lt $lines.Count; $j++) {
                $line = $lines[$j].Trim()
                if ($line -ne "") {
                    $content += "$line`n"
                }
            }
        }
    } else {
        $content += "Category $i (no content yet)`n"
    }
    
    $content += "`n`n"
}

# Add footer
$content += "---`n`n"
$content += "> Note: This file contains all 18 categories of English sentences for overall learning and memorization."

# Write to file (simplified without try-catch for better error handling)
Set-Content -Path $outputFile -Value $content
Write-Host "Merge completed: $outputFile"