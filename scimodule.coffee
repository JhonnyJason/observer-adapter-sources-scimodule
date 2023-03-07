############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("scimodule")
#endregion

############################################################
import net from 'net'

############################################################
#region MonkeyPatch Server Prototype, from https://github.com/rubenv/node-systemd
Server = net.Server.prototype;
PipeWrap = process.binding('pipe_wrap');
Pipe = PipeWrap.Pipe;

oldListen = Server.listen

############################################################
Server.listen = ->
    self = this
    backlog
    callback

    if (arguments[0] == 'systemd')

        if typeof arguments[1] == 'function' then callback = arguments[1]
        else if typeof arguments[1] == 'number'
            backlog = arguments[1]
            callback = arguments[2]

        if !process.env.LISTEN_FDS || parseInt(process.env.LISTEN_FDS, 10) != 1 then throw new Error('No or too many file descriptors received.')
        
        if callback then self.once('listening', callback)

        if PipeWrap.constants? and PipeWrap.constants.SOCKET? then self._handle = new Pipe(PipeWrap.constants.SOCKET)
        else self._handle = new Pipe()

        self._handle.open(3)
        self._listen2(null, -1, -1, backlog)
    else oldListen.apply(self, arguments)
    return self

#endregion

############################################################
import express from 'express'
import bodyParser from 'body-parser'
import expressWs from 'express-ws'


############################################################
# import * as notificationHandler from "./notificationmodule.js"
# import * as seatManager from "./seatmanagermodule.js"
import * as authenticationOptions from "./authenticationrpcoptions.js"
import * as testOptions from "./rpctesteroptions.js"
import * as rpc from "./thingyrpcmodule.js"

############################################################
app = express()
app.set("trust proxy", 1)
WS = expressWs(app)
# app = expressWs(app)

app.use bodyParser.urlencoded(extended: false)
app.use bodyParser.json()


############################################################
export prepareAndExpose = ->

    rpcOptions = new Map()
    # for func,options of authenticationOptions
    #     rpcOptions.set(func, options)
    for func,options of testOptions
        rpcOptions.set(func, options)
    # for func,options of observerOptions
    #     rpcOptions.set(func, options)

    rpc.setRPCOptions(rpcOptions)
    # rpc.setSeatManagement(seatManager)
    # rpc.setNotificationHandler(notificationHandler)

    app.post("/thingy-post-rpc", rpc.handlePostRequest)
    app.ws("/thingy-rpc-socket", rpc.handleWSConnect)

    ## TODO handle regular SCI calls / maybe...
    app.listen "systemd"
    return
