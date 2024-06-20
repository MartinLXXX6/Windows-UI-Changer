# Import Windows Forms for the GUI
Add-Type -AssemblyName System.Windows.Forms

# Object Variables
$FormObject = [System.Windows.Forms.Form]
$LabelObject = [System.Windows.Forms.Label]
$ButtonObject = [System.Windows.Forms.Button]
$DropDownListObject = [System.Windows.Forms.ComboBox] 

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
        [ref]$StartMenuLabel
    )

    if ($DarkMode.Value -eq $true) {
        $MainForm.Value.ForeColor = 'DimGray'
        $MainForm.Value.BackColor = 'White'

        $ThemeButton.Value.Text = 'Dark Theme'

        $AdvTaskSettingsLabel.Value.ForeColor = 'DimGray'
        $AnimAndPerfLabel.Value.ForeColor = 'DimGray'
        $VersionLabel.Value.ForeColor = 'DimGray'
        $StartMenuLabel.Value.ForeColor = 'DimGray'

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
    ViewModeChanger ([ref]$MainForm) ([ref]$ThemeButton) ([ref]$DarkMode) ([ref]$AdvTaskSettingsLabel) ([ref]$AnimAndPerfLabel) ([ref]$VersionLabel) ([ref]$StartMenuLabel)
})

$VersionLabel = New-Object $LabelObject
$VersionLabel.AutoSize = $true
$VersionLabel.Location = New-Object System.Drawing.Point(10, 7)
$VersionLabel.Text = 'Version 1.0.0'
$VersionLabel.ForeColor = 'LightGray'
$VersionLabel.Font = 'Segoe,12'

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
$StartMenuLocationButton.Text = 'Startmenu Programs'
$StartMenuLocationButton.Cursor = 'Hand'
$StartMenuLocationButton.Font = 'Segoe,12'
$StartMenuLocationButton.Add_Click({StartMenuPrograms})

$StartMenuLabel = New-Object $LabelObject
$StartMenuLabel.AutoSize = $true
$StartMenuLabel.Location = New-Object System.Drawing.Point(408, 232)
$StartMenuLabel.Text = 'Windows 10 && 11'
$StartMenuLabel.Font = 'Segoe,12'
$StartMenuLabel.ForeColor = 'LightGray'

# Show On Display
$MainForm.Controls.AddRange(@($ThemeButton,$AdvTaskSettingsButton,$AdvTaskSettingsLabel,$AnimAndPerfButton,$AnimAndPerfLabel,$VersionLabel,$StartMenuLocationButton,$StartMenuLabel))

$MainForm.ShowDialog()
$MainForm.Dispose()
