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
        [ref]$MainForm,[ref]$ThemeButton,[ref]$DarkMode,[ref]$AdvTaskSettingsLabel,[ref]$AnimAndPerfLabel,[ref]$VersionLabel,[ref]$StartMenuLabel,[ref]$3DObjButton,
        [ref]$PresetsLabel,[ref]$BILabel,[ref]$3DObjLabel,[ref]$AdvTaskSettingsButton,[ref]$AnimAndPerfButton,[ref]$StartMenuLocationButton,[ref]$EnableOldContextMenuButton,
        [ref]$DisableOldContextMenuButton,[ref]$PresetsWindowsLabel,[ref]$ContextMenuLabel,[ref]$Preset1Button,[ref]$Preset2Button,[ref]$Preset3Button,[ref]$Preset4Button,
        [ref]$UISettingsLabel
    )

    if ($DarkMode.Value -eq $true) {
        $MainForm.Value.ForeColor = 'DimGray'
        $MainForm.Value.BackColor = 'White'

        $ThemeButton.Value.Text = 'Dark Theme'

        $ThemeButton.Value.ForeColor = 'Black'
        $AdvTaskSettingsLabel.Value.ForeColor = 'Black'
        $AnimAndPerfLabel.Value.ForeColor = 'Black'
        $VersionLabel.Value.ForeColor = 'Black'
        $StartMenuLabel.Value.ForeColor = 'Black'
        $3DObjButton.Value.ForeColor = 'Black'
        $PresetsLabel.Value.ForeColor = 'Black'
        $BILabel.Value.ForeColor = 'Black'
        $3DObjLabel.Value.ForeColor = 'Black'
        $AdvTaskSettingsButton.Value.ForeColor = 'Black'
        $AnimAndPerfButton.Value.ForeColor = 'Black'
        $StartMenuLocationButton.Value.ForeColor = 'Black'
        $EnableOldContextMenuButton.Value.ForeColor = 'Black'
        $DisableOldContextMenuButton.Value.ForeColor = 'Black'
        $PresetsWindowsLabel.Value.ForeColor = 'Black'
        $ContextMenuLabel.Value.ForeColor = 'Black'
        $Preset1Button.Value.ForeColor = 'Black'
        $Preset2Button.Value.ForeColor = 'Black'
        $Preset3Button.Value.ForeColor = 'Black'
        $Preset4Button.Value.ForeColor = 'Black'
        $UISettingsLabel.Value.ForeColor = 'Black'

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
        $PresetsLabel.Value.ForeColor = 'LightGray'
        $BILabel.Value.ForeColor = 'LightGray'
        $3DObjLabel.Value.ForeColor = 'LightGray'
        $PresetsWindowsLabel.Value.ForeColor = 'LightGray'
        $ContextMenuLabel.Value.ForeColor = 'LightGray'
        $UISettingsLabel.Value.ForeColor = 'LightGray'
        
        $ThemeButton.Value.ForeColor = 'Control'
        $3DObjButton.Value.ForeColor = 'Control'
        $AdvTaskSettingsButton.Value.ForeColor = 'Control'
        $AnimAndPerfButton.Value.ForeColor = 'Control'
        $StartMenuLocationButton.Value.ForeColor = 'Control'
        $EnableOldContextMenuButton.Value.ForeColor = 'Control'
        $DisableOldContextMenuButton.Value.ForeColor = 'Control'
        $Preset1Button.Value.ForeColor = 'Control'
        $Preset2Button.Value.ForeColor = 'Control'
        $Preset3Button.Value.ForeColor = 'Control'
        $Preset4Button.Value.ForeColor = 'Control'

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

    # Stop the explorer.exe process
    Stop-Process -Name explorer -Force

    # Wait for a few seconds to ensure the process has fully stopped
    Start-Sleep -Seconds 5

    # Restart the explorer shell
    Start-Process -FilePath "explorer.exe" -ArgumentList "/factory,{682159d9-c321-47ca-b3f1-30e36b2ec8b9} -Embedding"
}
function StandardTB{
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCopilotButton" -Value "1" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Value "1" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value "1" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value "2" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value "1" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "IsLocationTurnedOn" -Value "1" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Value "1" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarOpenOnHover" -Value "1" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value "1" -Type Dword
    

    # Stop the explorer.exe process
    Stop-Process -Name explorer -Force

    # Wait for a few seconds to ensure the process has fully stopped
    Start-Sleep -Seconds 5

    # Restart the explorer shell
    Start-Process -FilePath "explorer.exe" -ArgumentList "/factory,{682159d9-c321-47ca-b3f1-30e36b2ec8b9} -Embedding"
}
function DeblotedTB{
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCopilotButton" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value "2" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value "2" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "IsLocationTurnedOn" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarOpenOnHover" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value "0" -Type Dword
    
    
    # Stop the explorer.exe process
    Stop-Process -Name explorer -Force

    # Wait for a few seconds to ensure the process has fully stopped
    Start-Sleep -Seconds 5

    # Restart the explorer shell
    Start-Process -FilePath "explorer.exe" -ArgumentList "/factory,{682159d9-c321-47ca-b3f1-30e36b2ec8b9} -Embedding"
}
function ProductivityTB{
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCopilotButton" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value "2" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value "2" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "IsLocationTurnedOn" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarOpenOnHover" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value "0" -Type Dword
    
    
    # Stop the explorer.exe process
    Stop-Process -Name explorer -Force

    # Wait for a few seconds to ensure the process has fully stopped
    Start-Sleep -Seconds 5

    # Restart the explorer shell
    Start-Process -FilePath "explorer.exe" -ArgumentList "/factory,{682159d9-c321-47ca-b3f1-30e36b2ec8b9} -Embedding"
}
function SimplicityTB{
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCopilotButton" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value "1" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value "1" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value "2" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "IsLocationTurnedOn" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarOpenOnHover" -Value "0" -Type Dword
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value "0" -Type Dword
    
    
    # Stop the explorer.exe process
    Stop-Process -Name explorer -Force

    # Wait for a few seconds to ensure the process has fully stopped
    Start-Sleep -Seconds 5

    # Restart the explorer shell
    Start-Process -FilePath "explorer.exe" -ArgumentList "/factory,{682159d9-c321-47ca-b3f1-30e36b2ec8b9} -Embedding"
}
function EnableOldContextMenu{
    if (-Not (Test-Path -Path "HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32")) {
        New-Item -Path "HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -ItemType Directory -Force
    }

    Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value ""

        # Stop the explorer.exe process
        Stop-Process -Name explorer -Force

        # Wait for a few seconds to ensure the process has fully stopped
        Start-Sleep -Seconds 5
    
        # Restart the explorer shell
        Start-Process -FilePath "explorer.exe" -ArgumentList "/factory,{682159d9-c321-47ca-b3f1-30e36b2ec8b9} -Embedding"
}
function DisableOldContextMenu{
    if (Test-Path -Path "HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32") {
        Remove-Item -Path "HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force
        Remove-Item -Path "HKCU:\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Force
    }

        # Stop the explorer.exe process
        Stop-Process -Name explorer -Force

        # Wait for a few seconds to ensure the process has fully stopped
        Start-Sleep -Seconds 5
    
        # Restart the explorer shell
        Start-Process -FilePath "explorer.exe" -ArgumentList "/factory,{682159d9-c321-47ca-b3f1-30e36b2ec8b9} -Embedding"
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
    ViewModeChanger ([ref]$MainForm) ([ref]$ThemeButton) ([ref]$DarkMode) ([ref]$AdvTaskSettingsLabel) ([ref]$AnimAndPerfLabel) ([ref]$VersionLabel) ([ref]$StartMenuLabel) ([ref]$3DObjButton) ([ref]$PresetsLabel) ([ref]$BILabel) ([ref]$3DObjLabel) ([ref]$AdvTaskSettingsButton) ([ref]$AnimAndPerfButton) ([ref]$StartMenuLocationButton) ([ref]$EnableOldContextMenuButton) ([ref]$DisableOldContextMenuButton) ([ref]$PresetsWindowsLabel) ([ref]$ContextMenuLabel) ([ref]$Preset1Button) ([ref]$Preset2Button) ([ref]$Preset3Button) ([ref]$Preset4Button) ([ref]$UISettingsLabel)
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

$UISettingsLabel = New-Object $LabelObject
$UISettingsLabel.Location = New-Object System.Drawing.Point(190, 40)
$UISettingsLabel.Text = 'GENERAL SETTINGS'
$UISettingsLabel.AutoSize = $true
$UISettingsLabel.Font = 'Segoe,20,style=Bold'
$UISettingsLabel.ForeColor = 'LightGray'

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

$EnableOldContextMenuButton = New-Object $ButtonObject
$EnableOldContextMenuButton.Size = '303, 38'
$EnableOldContextMenuButton.Location = New-Object System.Drawing.Point(13, 384)
$EnableOldContextMenuButton.Text = 'Enable Old Context Menu'
$EnableOldContextMenuButton.Cursor = 'Hand'
$EnableOldContextMenuButton.Font = 'Segoe,12'
$EnableOldContextMenuButton.Add_Click({EnableOldContextMenu})

$DisableOldContextMenuButton = New-Object $ButtonObject
$DisableOldContextMenuButton.Size = '303, 38'
$DisableOldContextMenuButton.Location = New-Object System.Drawing.Point(318, 384)
$DisableOldContextMenuButton.Text = 'Disable Old Context Menu'
$DisableOldContextMenuButton.Cursor = 'Hand'
$DisableOldContextMenuButton.Font = 'Segoe,12'
$DisableOldContextMenuButton.Add_Click({DisableOldContextMenu})

$ContextMenuLabel = New-Object $LabelObject
$ContextMenuLabel.Location = New-Object System.Drawing.Point(270, 426)
$ContextMenuLabel.Text = 'Windows 11'
$ContextMenuLabel.Font = 'Segoe,12'
$ContextMenuLabel.ForeColor = 'LightGray'

$PresetsLabel = New-Object $LabelObject
$PresetsLabel.Location = New-Object System.Drawing.Point(190, 470)
$PresetsLabel.Text = 'TASKBAR PRESETS'
$PresetsLabel.AutoSize = $true
$PresetsLabel.Font = 'Segoe,20,style=Bold'
$PresetsLabel.ForeColor = 'LightGray'

$PresetsWindowsLabel = New-Object $LabelObject
$PresetsWindowsLabel.Location = New-Object System.Drawing.Point(250, 525)
$PresetsWindowsLabel.Text = 'Windows 10 && 11'
$PresetsWindowsLabel.AutoSize = $true
$PresetsWindowsLabel.Font = 'Segoe,12'
$PresetsWindowsLabel.ForeColor = 'LightGray'

$Preset1Button = New-Object $ButtonObject
$Preset1Button.Size = '303, 38'
$Preset1Button.Location = New-Object System.Drawing.Point(13, 560)
$Preset1Button.Text = 'Standard'
$Preset1Button.Cursor = 'Hand'
$Preset1Button.Font = 'Segoe,12'
$Preset1Button.Add_Click({StandardTB})

$Preset2Button = New-Object $ButtonObject
$Preset2Button.Size = '303, 38'
$Preset2Button.Location = New-Object System.Drawing.Point(318, 560)
$Preset2Button.Text = 'Standard: Debloted'
$Preset2Button.Cursor = 'Hand'
$Preset2Button.Font = 'Segoe,12'
$Preset2Button.Add_Click({DeblotedTB})

$Preset3Button = New-Object $ButtonObject
$Preset3Button.Size = '303, 38'
$Preset3Button.Location = New-Object System.Drawing.Point(13, 610)
$Preset3Button.Text = 'Custom: Productivity'
$Preset3Button.Cursor = 'Hand'
$Preset3Button.Font = 'Segoe,12'
$Preset3Button.Add_Click({ProductivityTB})

$Preset4Button = New-Object $ButtonObject
$Preset4Button.Size = '303, 38'
$Preset4Button.Location = New-Object System.Drawing.Point(318, 610)
$Preset4Button.Text = 'Custom: Simplicity'
$Preset4Button.Cursor = 'Hand'
$Preset4Button.Font = 'Segoe,12'
$Preset4Button.Add_Click({SimplicityTB})

# Show On Display
$MainForm.Controls.AddRange(@($ThemeButton,$AdvTaskSettingsButton,$AdvTaskSettingsLabel,$AnimAndPerfButton,$AnimAndPerfLabel,$VersionLabel,$StartMenuLocationButton,$StartMenuLabel,$3DObjButton,$3DObjLabel,$PresetsLabel,$BILabel,$Preset1Button,$Preset3Button,$Preset2Button,$Preset4Button,$EnableOldContextMenuButton,$DisableOldContextMenuButton,$ContextMenuLabel,$PresetsWindowsLabel,$UISettingsLabel))

$MainForm.ShowDialog()
$MainForm.Dispose()
