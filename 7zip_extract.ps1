# 7-zipのインストールパス（7z.exeのパス）
$7zip = 'C:\Program Files\7-Zip\7z.exe'
# パスワード（複数指定可）
$passwords = @()
$passwords += 'password2'
$passwords += 'password1'

# 解凍対象のファイル（フルパス）
$targetFile = $Args[0]
# 解凍ファイルの拡張子
$extension = (Get-ChildItem $targetFile).Extension
# 解凍先のディレクトリ
$outputPath = $targetFile.Replace((Get-ChildItem $targetFile).Name, '')

if ($extension -eq '.ex_') {
    # 拡張子を変更
    $changeTargetFile = $targetFile.Replace('.ex_', '.exe')
    Rename-Item -Path $targetFile -NewName $changeTargetFile
    $targetFile = $changeTargetFile
}

if ($extension -eq '.zi_') {
    # 拡張子を変更
    $changeTargetFile = $targetFile.Replace('.zi_', '.zip')
    Rename-Item -Path $targetFile -NewName $changeTargetFile
    $targetFile = $changeTargetFile
}

$passwords | ForEach-Object {
    # 7zipで解凍
    <#
    7zipの引数 http://fla-moo.blogspot.com/2013/05/7-zip.html

    x : 解凍
    -y : 強制的に処理を続行
    -p : パスワードを設定
    -o : 出力先を指定
    #>
    $arg = "x -y -p`"$_`" -o`"$outputPath`" `"$targetFile`""
    $result = Start-Process -FilePath "$7zip" -ArgumentList $arg -Wait -PassThru -NoNewWindow

    if ($result -eq 0) {
        return
    }
}
