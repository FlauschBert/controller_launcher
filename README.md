# controller_launcher
Launch applications with controller using Löve2D. Commands for starting applications address windows only. The rest works on all desktop based platforms because of Löve2D.

## Motivation
You sit on the sofa with the controller in your hands and want to play. The computer stands somewhere else, boots and shows Steam Big Picture Mode. So far so fine. But what if you want to run other games not part of Steam Big Picture Mode?  
This is about presenting a window with a list of games after system start and auto login. Games can be started with a press of a controller button or keyboard key :)

## Preparations
Configure windows to auto login into a user. This is what you would do if using Steam Big Picture Mode too. Instead of starting Steam Big Picture Mode we run our Löve2D project.  
Löve2D has to be installed on the system.  
For Minecraft backup https://www.7-zip.org/ is used.

## Supported Games
The "hardest" part was to figure out how to run the games (or tools) from command line on windows. In all cases the `start` command is used. The used commands are found in `choose_state.lua`.

### Mass Effect Andromeda Mod Launcher
To be able to play Mass Effect Andromeda without buggy behaviour I use the Frosty Mod Manager. Create a default profile with your favourite mods and you are done.

### Steam Big Picture Mode
There is nothing to do but starting the Steam executable. Big Picture Mode is setup inside Steam.

### Minecraft Java Edition
What has Steam to do with Minecraft?  
Nothing, except absolutely perfect mouse and keyboard emulation with a controller!  
Add the Minecraft launcher executable to Steam to be able to start it out of Steam Big Picture Mode. Use at the added entry for Minecraft the controller configuration. (Please search on the web for more information on how to do this).

The files are organized in one folder for Minecraft server, client and backup and the users profile (`C:\Users\<user>\AppData\roaming\.minecraft`). The server is started directly out of the main folder. The client files are inside the `client` sub folder and backups are saved into the `backup` sub folder.  

#### Backup Minecraft world data files
Before starting the Minecraft server all data can be backup'd to be able to restore in case of complete disaster ;)  
Ths is done with 7z and a timestamp for the archive name.

#### Run the Minecraft server
There is always the possibility to run client and server separately. This is done also if played in singleplayer mode. It has the advantage that others can play in the same world from another computer. Or it allows playing with another computer with not enough performance for client and server all at once.

#### Run the Minecraft client
Run the client with the Minecraft launcher executable directly as further step or out of Steam Big Picture Mode.

## Future work
For now the launcher allows to start a game only once and has no detection whether it was closed or something like that.  
At least starting another game would be nice for instance. But it is not possible to bring up the window to front again with Löve2D.