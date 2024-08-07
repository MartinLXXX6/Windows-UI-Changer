# OVERVIEW
Features Available:
- Customization of taskbar icons (Volume, Notificacion Centre, Clock etc). (Win10 only)
- View all startmenu and taskbar shortcuts and customize them.
- Remove/add advanced animations.
- Enable 3D objects folder in File Explorer.
- Enable/disable Windows 10 context menu. (Win11 only)
- Apply custom taskbar presets.

Note: All of these are registry changes, making them reversible features and not using third party software. Enjoy

# HOW TO RUN .PS1 FILES
FIRST METHOD (Windows 10 only):
- Right click the .ps1 file and click "Run with PowerShell"
- Now go over the SmartScreen prompts if necessary. (Note: You need to show all the details to see the "RUN" button).
- Enjoy the script!!

SECOND METHOD:
- Run a new empty Windows Powershell instance.
- Type the following command: "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process" (without the quotation marks) NOTE: This sets the process scope as bypass but only for that PowerShell instance.
- Type "A" on the Powershell propt to continue.
- Nextly, locate the .ps1 script in File Explorer and copy the path to it without any quotation marks (Example: "C:\Users\\(YOUR USERNAME)\Downloads").
- Now type the following command: "(PASTE THE LOCATION COPIED BEFORE)\WindowsUIChanger.ps1"
- Enjoy the script!!

POSSIBLE ISSUES:
- When attempting the first method, is possible you may encounter an issue where the PowerShell window closes immediately or doesn't appear altogether. This happens in Windows 11 only I believe. Anyways, the second method should work perfectly so just try the second one.
- You may have disabled the ability to run PowerShell scripts for security purposes. You can know this by typing the following command "Get-ExecutionPolicy -List" and checking the Machine Policy state. If it is set to restricted, that means that you are unable to run PowerShell scripts. For more information about how to disable it, there is a great video from ThioJoe called "Disable These 3 Windows Settings Now! (For Security)". This setting is found from the minute 4:22 to 8:27. You might wanna disable it just for this time but if you dont run powershell scripts very frequently I do recommend turning it on.
- On the other hand, there is a chance that you mistyped commands so try another method or retry the methods.
- Dont hesitate to search the web on how to run PowerShell scripts or by typing the error given by PowerShell.
