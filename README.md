# Roku-Screensaver-REST-VSCode-Debug
I wanted to make a screen saver on Roku to pull a plain text string from a personal web api server to display my daughter's blood glucose level.

## Get started

### Roku Device Dev Mode
On a device, press Home Home Home UP UP RIGHT LEFT RIGHT LEFT RIGHT. You should be able to grab IP and set password here.

### Setup launch.json
Replace host/password values with your device IP and password.

### Pick an API and Update main.brs line 38
I typically use an ExpressJS or .NET Core Web API locally. Something with a plain text GET endpoint to start with will work!

## Extension Debug Support
https://marketplace.visualstudio.com/items?itemName=celsoaf.brightscript
