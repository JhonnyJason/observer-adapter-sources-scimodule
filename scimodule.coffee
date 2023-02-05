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

############################################################
app = express()




#################################################################
mountMiddleWare = (middleWare) ->
    if typeof middleWare ==  "function"
        app.use middleWare
        return
    if middleWare.length?
        app.use fun for fun in middleWare
        return
    return

############################################################
attachSCIFunctions = ->
    app.post("/"+route,fun) for route,fun of routes
    return

#################################################################
listenForRequests = ->
    if process.env.SOCKETMODE then app.listen "systemd"
    else app.listen port
    return

############################################################
export setProxyTrust = (arg) ->
    app.set("trust proxy", arg)
    return

############################################################
export prepareAndExpose = (middleWare, leRoutes, lePort = 3333) ->
    throw new Error("No routes Object provided!") unless typeof leRoutes == "object"
    
    routes = leRoutes
    port = process.env.PORT || lePort

    if middleWare? then mountMiddleWare(middleWare)

    attachSCIFunctions()
    listenForRequests()
    return
    
# ############################################################
# #region modules from the Environment
# import * as sciBase from "thingy-sci-ws-base"
# import * as wsi from "./wsimodule.js"

# ############################################################
# import * as authenticationRoutes from "./authenticationroutes.js"
# import * as observerRoutes from "./observerroutes.js"

# #endregion

# ############################################################
# export prepareAndExpose = ->
#     log "scimodule.prepareAndExpose"
#     restRoutes = Object.assign({}, authenticationRoutes)
#     restRoutes = Object.assign(restRoutes, observerRoutes)
        
#     # wsi.mountWSFunctions()
#     sciBase.prepareAndExpose(null, restRoutes)
#     sciBase.onWebsocketConnect("/", wsi.onConnect)
    
#     return