# 7-zip�̃C���X�g�[���p�X�i7z.exe�̃p�X�j
$7zip = 'C:\Program Files\7-Zip\7z.exe'
# �p�X���[�h�i�����w��j
$passwords = @()
$passwords += 'password2'
$passwords += 'password1'

# �𓀑Ώۂ̃t�@�C���i�t���p�X�j
$targetFile = $Args[0]
# �𓀃t�@�C���̊g���q
$extension = (Get-ChildItem $targetFile).Extension
# �𓀐�̃f�B���N�g��
$outputPath = $targetFile.Replace((Get-ChildItem $targetFile).Name, '')

if ($extension -eq '.ex_') {
    # �g���q��ύX
    $changeTargetFile = $targetFile.Replace('.ex_', '.exe')
    Rename-Item -Path $targetFile -NewName $changeTargetFile
    $targetFile = $changeTargetFile
}

if ($extension -eq '.zi_') {
    # �g���q��ύX
    $changeTargetFile = $targetFile.Replace('.zi_', '.zip')
    Rename-Item -Path $targetFile -NewName $changeTargetFile
    $targetFile = $changeTargetFile
}

$passwords | ForEach-Object {
    # 7zip�ŉ�
    <#
    7zip�̈��� http://fla-moo.blogspot.com/2013/05/7-zip.html

    x : ��
    -y : �����I�ɏ����𑱍s
    -p : �p�X���[�h��ݒ�
    -o : �o�͐���w��
    #>
    $arg = "x -y -p`"$_`" -o`"$outputPath`" `"$targetFile`""
    $result = Start-Process -FilePath "$7zip" -ArgumentList $arg -Wait -PassThru -NoNewWindow

    if ($result -eq 0) {
        return
    }
}
