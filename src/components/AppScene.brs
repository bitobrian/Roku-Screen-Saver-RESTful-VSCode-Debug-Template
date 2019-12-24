sub init()
    canvasObject = CreateObject("roDeviceInfo")
    canvasSize = canvasObject.GetDisplaySize()
    example = m.top.findNode("textRectangle")
    examplerect = example.boundingRect()
    centerx = (canvasSize.w - examplerect.width) / 2
    centery = (canvasSize.h - examplerect.height) / 2
    example.translation = [centerx, centery]
    m.movinglabel = m.top.findNode("movingLabel")
    scrollback = m.top.findNode("scrollbackAnimation")
    datatimer = m.top.findNode("dataTimer")
    m.defaulttext = canvasSize.w
    m.alternatetext = canvasSize.h
    m.textchange = false
    datatimer.observeField("fire", "getdata")
    scrollback.control = "start"
    datatimer.control = "start"
    m.top.setFocus(true)
end sub

sub getdata()
    m.movinglabel.text = m.global.globalVariable
end sub
