
# Protanki client source code (remake)
Remake of Protanki client. The code is mostly based on decompiled Tanki Online 2019 client code. Some code (for example, CTF, missions, assault) is from 2017 client. The network protocol is reverse engineered from Protanki client.
Video recorded from the client: https://odysee.com/@juho:5/2026-01-26-03-03-56:1

![Client picture](/ReadmePictures/client.png)
![Hack menu](/ReadmePictures/hack_menu.png)
## Download
You can download binaries from: https://github.com/juhe1/ProtankiClientRemake/releases
## Compiling
#### General
Download binaries from releases and paste them into "Code/bin/", so that after compilation, you have launcher that can run the compiled swf file. This is necessary even if you are launching the game using debug.
#### Preparing the SDKs
We need two SDKs, AIR SDK for debugging and FLEX SDK for compiling.

For compiling you should use flex_sdk_4.6.0.23201. It can be found here: https://github.com/JamesMGreene/node-flex-sdk/blob/master/FlexSDKs.md After extracting the SDK, you should replace "flex_sdk_4.6.0.23201/frameworks/libs/air/airglobal.swc" file with "this_repo/tools/airglobal.swc" file. The tools folder is on this repository. Tools folder can be deleted after the swc file is replaced.

Next download air SDK (https://airsdk.harman.com/download). Extract it where ever you want.

#### Configuring Visual Studio Code for compile
First install "AS3, MXML and SWF Extension Pack" extension. You can get it here: https://marketplace.visualstudio.com/items?itemName=bowlerhatllc.vscode-nextgenas.

To get debugging working, go into "this_repo/.vscode/launch.json" and change "runtimeExecutable" to point to your "adl.exe" (it is inside "air_sdk/bin/").

To be alble to compile, you should make some changes to your "settings.json" and to "this_repo/.vscode/tasks.json". Let's edit tasks.json first:
1. open tasks.json
2. Paste these lines: 
```
{
    "type": "actionscript",
    "debug": true,
    "group": "build",
    "problemMatcher": [],
    "label": "ActionScript: compile debug - asconfig.json"
},
{
    "type": "actionscript",
    "debug": false,
    "group": "build",
    "problemMatcher": [],
    "label": "ActionScript: compile release - asconfig.json"
}
```
3. Save (:D)

Now let's edit settings.json. You can open settings.json by pressing ctrl+shift+p and then type "Open User Settings (JSON)": 
1. Add new json line "as3mxml.sdk.framework":"path_to_sdk" to the json and replace "path_to_sdk" with your SDK location. example:
```
"as3mxml.sdk.framework": "D:\\juho1\\tankkin_modaus\\flash_SDKs\\flex_sdk_4.6.0.23201_mpl",
```
2. save

Now you can compile by clicking "ctrl+shift+p" (you can also get there by pressing "Terminal" from the vscode menu and then press "Run build task.."). Then search "ActionScript: compile debug - asconfig.json" and click it. Now it should compile.
![VSCode](/ReadmePictures/vscode_compile.png)

You can debug by clicking "Run" and then "Start Debugging". Or then just hit "f5". Note that you need to be inside tab that contains actionscript code when you start debugger.

#### Configuring FlashDevelop for compile
Click "Project" button from top bar and then click "Properties" (Project->Properties). Now go to the SDK tab and paste your SDK path into the Custom SDK box (see picture below).
![FlashDevelop](/ReadmePictures/flash_develop.png)

After that go to Output tab. Then in the TestProject section select "Run Custom Command...". After that click edit and paste your adl.exe location(it is inside the air SDK bin folder) and the repo bin folders apllication.xml location. Example: 
```
D:\juho1\omat_sovelukset\airsdk\bin\adl.exe D:\juho1\tankkin_modaus\protanki\ProtankiRemake\Code\bin\application.xml
```
![FlashDevelop](/ReadmePictures/flash_develop_run.png)

Now you can compile by clicking the compile button. To debug press play button next to the compile button.
![FlashDevelop](/ReadmePictures/flash_develop_compile.png)
