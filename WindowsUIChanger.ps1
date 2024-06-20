# Check if the script is running with administrative privileges
function Test-Admin {
    return ([bool](New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
}
# Relaunch the script with elevated privileges if not running as admin
if (-Not (Test-Admin)) {
    Start-Process powershell "-Command & {Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"' -Verb RunAs}" -NoNewWindow
    exit
}
# Check if the script is running with administrative privileges
function Test-Admin {
    return ([bool](New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
}
# Relaunch the script with elevated privileges if not running as admin
if (-Not (Test-Admin)) {
    Start-Process powershell "-Command & {Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"' -Verb RunAs}" -NoNewWindow
    exit
}

# Import Windows Forms for the GUI
Add-Type -AssemblyName System.Windows.Forms

# Object Variables
$FormObject = [System.Windows.Forms.Form]
$LabelObject = [System.Windows.Forms.Label]
$ButtonObject = [System.Windows.Forms.Button]

# Variables
$global:DarkMode = $true

# Functions
function ViewModeChanger {
    param (
        [ref]$MainForm,
        [ref]$ThemeButton,
        [ref]$DarkMode,
        [ref]$AdvTaskSettingsLabel,
        [ref]$AnimAndPerfLabel,
        [ref]$VersionLabel,
        [ref]$StartMenuLabel,
        [ref]$3DObjButton,
        [ref]$PresetsLabel,
        [ref]$BILabel,
        [ref]$3DObjLabel
    )

    if ($DarkMode.Value -eq $true) {
        $MainForm.Value.ForeColor = 'DimGray'
        $MainForm.Value.BackColor = 'White'

        $ThemeButton.Value.Text = 'Dark Theme'

        $AdvTaskSettingsLabel.Value.ForeColor = 'Black'
        $AnimAndPerfLabel.Value.ForeColor = 'Black'
        $VersionLabel.Value.ForeColor = 'Black'
        $StartMenuLabel.Value.ForeColor = 'Black'
        $3DObjButton.Value.ForeColor = 'Black'
        $PresetsLabel.Value.ForeColor = 'Black'
        $BILabel.Value.ForeColor = 'Black'
        $3DObjLabel.Value.ForeColor = 'Black'

        $DarkMode.Value = $false
    }
    elseif ($DarkMode.Value -eq $false) {
        $MainForm.Value.ForeColor = 'White'
        $MainForm.Value.BackColor = 'DimGray'

        $ThemeButton.Value.Text = 'Light Theme'

        $AdvTaskSettingsLabel.Value.ForeColor = 'LightGray'
        $AnimAndPerfLabel.Value.ForeColor = 'LightGray'
        $VersionLabel.Value.ForeColor = 'LightGray'
        $StartMenuLabel.Value.ForeColor = 'LightGray'
        $3DObjButton.Value.ForeColor = 'LightGray'
        $PresetsLabel.Value.ForeColor = 'LightGray'
        $BILabel.Value.ForeColor = 'LightGray'
        $3DObjLabel.Value.ForeColor = 'LightGray'

        $DarkMode.Value = $true
    }
}
function AdvancedTaskbarSettings {
    Start-Process "shell:::{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}"
}
function AdvancedAnimationSettings {
    Start-Process "SystemPropertiesAdvanced.exe"
}
function StartMenuPrograms {
    Start-Process "Shell:start menu"
    Start-Process "Shell:common start menu"
    Start-Process "shell:user pinned"
}
function Add3DObjects {
    Stop-Process -Name explorer -Force

    Start-Sleep -Seconds 2

# Check if the "3D Objects" folder exists in the user's profile, if not, create it

    $threeDObjectsPath = "$env:UserProfile\3D Objects"
    if (-Not (Test-Path -Path $threeDObjectsPath)) {
        New-Item -Path $threeDObjectsPath -ItemType Directory
    }

# Update the registry keys to set the "3D Objects" folder path in Explorer's shell folders
    $regPathShellFolders = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
    $regPathUserShellFolders = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
    $clsid = "{31C0DD25-9439-4F12-BF41-7FF4EDA38722}"

    Set-ItemProperty -Path $regPathShellFolders -Name $clsid -Value $threeDObjectsPath
    Set-ItemProperty -Path $regPathUserShellFolders -Name $clsid -Value "$env:USERPROFILE\3D Objects"

# Set the attributes of the "3D Objects" folder to read-only, removing system and hidden attributes
    Get-Item -Path $threeDObjectsPath | Set-ItemProperty -Name Attributes -Value "ReadOnly"

# Pin the 3DObjects Folder

    if (-Not (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -ItemType Directory
    }
    if (-Not (Test-Path -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}")) {
        New-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -ItemType Directory
    }

# Wait for 1 second
    Start-Sleep -Seconds 3

# Start the explorer.exe process
    Start-Process explorer.exe
}

# Form Properties
$MainForm = New-Object $FormObject

$MainForm.ClientSize = '650, 700'
$MainForm.MaximizeBox = $false
$MainForm.StartPosition = 'CenterScreen'
$MainForm.MaximumSize = '650, 700'
$MainForm.MinimumSize = '650, 700'

$MainForm.Text = 'Windows UI Changer'
$MainForm.Font = 'Segoe UI,12'
$MainForm.ForeColor = 'White'
$MainForm.BackColor = 'DimGray'

# Form Objects
$ThemeButton = New-Object $ButtonObject
$ThemeButton.AutoSize = $true
$ThemeButton.Location = New-Object System.Drawing.Point(524, 7)
$ThemeButton.Text = 'Light Theme'
$ThemeButton.Font = 'Segoe,12'
$ThemeButton.Cursor = 'Hand'
$ThemeButton.Add_Click({
    ViewModeChanger ([ref]$MainForm) ([ref]$ThemeButton) ([ref]$DarkMode) ([ref]$AdvTaskSettingsLabel) ([ref]$AnimAndPerfLabel) ([ref]$VersionLabel) ([ref]$StartMenuLabel) ([ref]$3DObjButton) ([ref]$PresetsLabel) ([ref]$BILabel) ([ref]$3DObjLabel)
})

$VersionLabel = New-Object $LabelObject
$VersionLabel.AutoSize = $true
$VersionLabel.Location = New-Object System.Drawing.Point(10, 7)
$VersionLabel.Text = 'Version 1.0.0'
$VersionLabel.ForeColor = 'LightGray'
$VersionLabel.Font = 'Segoe,12'

$BILabel = New-Object $LabelObject
$BILabel.Location = New-Object System.Drawing.Point(207, 7)
$BILabel.Text = 'Built-in and reversible features'
$BILabel.AutoSize = $true
$BILabel.Font = 'Segoe,12'
$BILabel.ForeColor = 'LightGray'

$AdvTaskSettingsButton = New-Object $ButtonObject
$AdvTaskSettingsButton.Size = '606, 38'
$AdvTaskSettingsButton.Location = New-Object System.Drawing.Point(13, 90)
$AdvTaskSettingsButton.Text = 'Advanced Taskbar Tweaks'
$AdvTaskSettingsButton.Cursor = 'Hand'
$AdvTaskSettingsButton.Font = 'Segoe,12'
$AdvTaskSettingsButton.Add_Click({AdvancedTaskbarSettings})

$AdvTaskSettingsLabel = New-Object $LabelObject
$AdvTaskSettingsLabel.Location = New-Object System.Drawing.Point(270, 132)
$AdvTaskSettingsLabel.Text = 'Windows 10'
$AdvTaskSettingsLabel.Font = 'Segoe,12'
$AdvTaskSettingsLabel.ForeColor = 'LightGray'

$AnimAndPerfButton = New-Object $ButtonObject
$AnimAndPerfButton.Size = '303, 38'
$AnimAndPerfButton.Location = New-Object System.Drawing.Point(13, 190)
$AnimAndPerfButton.Text = 'Advanced Animation Settings'
$AnimAndPerfButton.Cursor = 'Hand'
$AnimAndPerfButton.Font = 'Segoe,12'
$AnimAndPerfButton.Add_Click({AdvancedAnimationSettings})

$AnimAndPerfLabel = New-Object $LabelObject
$AnimAndPerfLabel.AutoSize = $true
$AnimAndPerfLabel.Location = New-Object System.Drawing.Point(103, 232)
$AnimAndPerfLabel.Text = 'Windows 10 && 11'
$AnimAndPerfLabel.Font = 'Segoe,12'
$AnimAndPerfLabel.ForeColor = 'LightGray'

$StartMenuLocationButton = New-Object $ButtonObject
$StartMenuLocationButton.Size = '303, 38'
$StartMenuLocationButton.Location = New-Object System.Drawing.Point(318, 190)
$StartMenuLocationButton.Text = 'Startmenu Apps && Taskbar Pinned Apps'
$StartMenuLocationButton.Cursor = 'Hand'
$StartMenuLocationButton.Font = 'Segoe,12'
$StartMenuLocationButton.Add_Click({StartMenuPrograms})

$StartMenuLabel = New-Object $LabelObject
$StartMenuLabel.AutoSize = $true
$StartMenuLabel.Location = New-Object System.Drawing.Point(408, 232)
$StartMenuLabel.Text = 'Windows 10 && 11'
$StartMenuLabel.Font = 'Segoe,12'
$StartMenuLabel.ForeColor = 'LightGray'

$3DObjButton = New-Object $ButtonObject
$3DObjButton.Size = '606, 38'
$3DObjButton.Location = New-Object System.Drawing.Point(13, 290)
$3DObjButton.Text = 'Enable 3D Objects Folder in File Explorer'
$3DObjButton.Cursor = 'Hand'
$3DObjButton.Font = 'Segoe,12'
$3DObjButton.Add_Click({Add3DObjects})

$3DObjLabel = New-Object $LabelObject
$3DObjLabel.Location = New-Object System.Drawing.Point(250, 332)
$3DObjLabel.Text = 'Windows 10 && 11'
$3DObjLabel.AutoSize = $true
$3DObjLabel.Font = 'Segoe,12'
$3DObjLabel.ForeColor = 'LightGray'

$PresetsLabel = New-Object $LabelObject
$PresetsLabel.Location = New-Object System.Drawing.Point(249, 392)
$PresetsLabel.Text = 'TASKBAR PRESETS'
$PresetsLabel.AutoSize = $true
$PresetsLabel.Font = 'Segoe,12'
$PresetsLabel.ForeColor = 'LightGray'

# Show On Display
$MainForm.Controls.AddRange(@($ThemeButton,$AdvTaskSettingsButton,$AdvTaskSettingsLabel,$AnimAndPerfButton,$AnimAndPerfLabel,$VersionLabel,$StartMenuLocationButton,$StartMenuLabel,$3DObjButton,$3DObjLabel,$PresetsLabel,$BILabel))

$MainForm.ShowDialog()
$MainForm.Dispose()
