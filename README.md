# LantherNT
LantherNT, an installer for windows written in batch!
# Features
Product key prompt.
WIM and ESD support.

# How to install?
Use a Windows PE image of Windows ADK, download LantherNT.cmd and rename it to startnet.cmd.
You can also use the premade WIM files in the releases page.
To install the WIM from the releases page:/n
Download the WIM and rename it to boot.wim, and replace the boot.wim inside your ISO with the installer one./n
# Notes
LantherNT doesn't support multiple Windows versions in a single WIM file, so make sure to remove all versions from install.wim EXCEPT the only one you need.
Multiple Windows versions in a single WIM file will be supported in 0.11.
# Why?
Mainly to make a installer that looks like the legacy NT installer, in NT 3.1 - XP.
# Credits
Original code and uploading the most recent version at the time of uploading by Windows XP Pro.
Most modifications made by Toiletflusher.
Disk manager by pog5.
