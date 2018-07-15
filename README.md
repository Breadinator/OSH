# OSH
OpenScriptHandler. A program for the Minecraft mod OpenComputers. This is a very WIP program. 

# Files
## osh.lua
This is the server for OSH. Configuration at the top of this file for now.

## oshl.lua
A library for making requests to an OSH server.

## oshpm.lua
OSH Package Manager. Actually installs scripts. Requires oshl.lua.
Usage: 
* `oshpm update` gets the list of available scripts.
* `oshpm -i <script name>` installs the specified script globally (to /bin/)
* `oshpm -il <script name>` installs the specified script locally (to the current directory)
