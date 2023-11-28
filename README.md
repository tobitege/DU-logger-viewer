# DU-logger-viewer

## Introduction

Based on Jason Bloomer's [LUA scripts](https://github.com/Jason-Bloomer/DU-Lua-Scripts) for Dual Universe (DU).
In this repo I combined his "*Proximity Detection*" and "*Databank Key Viewer*"
scripts into a working "Player logging and viewer" version with some added
error handling and fixes.

Currently the data viewer output is a barebones, textual version of
the pure data, not a fancy UI with designed layout and formatted text.
In future updates I might extend the display to a fancier design.

This was a learning experience for me to get this working as a
[DU-LuaC](https://github.com/wolfe-labs/DU-LuaC) project.
DU-LuaC is a great "packaging" tool for developers to get LUA scripts
into a "ready-to-install" json (or .conf) file for DU.
**I love that tool! :)**

The "out" folder contains the latest builds in the "development"
and "release" sub-folders. The "development" version keeps the source
in a readable format whereas the "release" version is a much compressed
version to save space on the programming board (ingame).

## Required elements

- 2 programming boards
- 2 databanks
- 1 screen (XS size suffices)
- 1 detection zone (XS could suffice)

## Setup

All elements need to be deployed on the same construct, but can be
placed apart as needed, i.e. the detection zone can be close
to a construct's door while all the rest could be anywhere else
within the construct.

### Logger programming board

- Deploy 1 programming board, 2 databanks and 1 detection zone.
- First link the constructs' core to the board.
- Link both databanks to the board.
- Lastly, link the detection zone to the board.
- Install onto the board the "logger.json" script from either
the "out\development" or "out\release" folders (see installation section below).

### Viewer programming board

- Deploy 1 programming board and 1 screen (any size).
- First link the screen to the board.
- Link the specific databank to the board which was linked 2nd(!) to the logger board.
- Install the "viewer.json" script onto the board (see installation section below).

### Viewer Screen

Copy the "viewer.screen.lua" file content into the screen's LUA editor
(see next section). The screen uses DU's RenderScript lua code.

On screen there are at the bottom left/right arrows to move between logged
entries. Next to the "left" arrow normally the logged player's ID is shown.
At the right screen border is a scrollbar, whose "grabber" is at the top
top right corner and can be dragged down/up over the full height of the screen
to scroll data up and down respectively.

The bigger area of the screen is used to display the data in a plain
output based on JSON data format.
The displayed attributes are currently not sorted, but depend on how
LUA is (seemingly randomly) storing them.
This whole output format was not meant to be fancy and thus may change
with future patches.

## Script Installation

General installation steps in DU:
For *programming boards* open a .json file in the above mentioned out\development
(or out\release) folder, copy its full content to clipboard and - in game - right
click the programming board to get the "Advanced" menu. Then click the menu item
"Paste Lua configuration from clipboard" to have the script installed on it.

*For a screen*, copy the scripts' content to the clipboard.
Then either

- point at the screen and hit CTRL+L
OR
- right click the screen, select the "Advanced" menu item, click "Edit content".

The above opens the screen's LUA editor into which the script can now be
pasted into. Then hit "Apply" to save it.

### Credits

Big thanks to Wolfe and Jason for their work and creating open source software!
