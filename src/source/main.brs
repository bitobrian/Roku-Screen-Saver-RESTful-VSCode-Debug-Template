Function RunScreenSaver(params As Object) As Object 'Required entrypoint for screensavers
    main()
End Function

sub main()
    screen = createObject("roSGScreen")
    screen.setMessagePort(createObject("roMessagePort"))

    ' Make a reference to the global node where we'll set a dynamic variable
    m.glb = screen.getGlobalNode()
    m.glb.Addfield("globalVariable", "string", true)
    m.glb.globalVariable = "Global Variable"

    scene = screen.createScene("AppScene") 
    scene.backgroundColor="0x00000000"
    scene.backgroundUri = ""
    screen.show()

    while(true)
        ' Get value from RESTful API and set to our created global variable
        m.glb.globalVariable = GetHttpData()
        print m.glb.globalVariable

        msg = wait(1000, screen.GetMessagePort())

        ' Check to stop screensaver
        if(msg <> invalid)
            if msgType = "roSGScreenEvent"
                if msg.isScreenClosed() then return
            end if
        end if
    end while
end sub

sub GetHttpData() as dynamic
    ' Set up some config
    ' TODO: Setup json parsing
    apiUrl = "http://some-plain-text-api"
    timeout = 1500
    num_retries = 1

    ' Set up roku objects for http client and port to chat on
    http = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")

    ' Set up http client
    http.SetUrl(apiUrl)
    http.SetMessagePort(port)
    http.SetRequest("GET")

    ' Set up header data
    ' http.AddHeader("Content-Type", "application/json")
    http.AddHeader("X-Roku-Reserved-Dev-Id", "ROKU!!")

    ' Set up https
    http.SetCertificatesFile("pkg:/source/certificates/cafile.pem")
    http.EnableHostVerification(true)
    http.EnablePeerVerification(true)
    http.InitClientCertificates()
    http.RetainBodyOnError(true)

    ' Cycle through attempts
    while num_retries > 0
        ' https://developer.roku.com/docs/references/brightscript/interfaces/ifurltransfer.md
        if (http.AsyncGetToString())
            event = wait(timeout, http.GetPort())
            if type(event) = "roUrlEvent"
                responseData = event.GetString()
                code = event.GetResponseCode()
                print code
                if code = 200
                    print "OK HTTP data:" + responseData
                    ' TODO: Setup json parsing
                    return responseData
                else
                    print "NOT-OK HTTP data:" + responseData
                    timeout = timeout * 2
                    num_retries = num_retries - 1
                end if
            else
                timeout = timeout * 2
                num_retries = num_retries - 1
            end if
        end if
    end while
end sub