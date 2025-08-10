$items = @(
    "项目 A"
    "项目 B"
    "项目 C"
)
 
$selectedItem = $items | Out-GridView -PassThru -Title "请选择一个项目"
 
if ($selectedItem) {
    Write-Host "你选择了: $selectedItem"
} else {
    Write-Host "没有选择任何项目。"
}
