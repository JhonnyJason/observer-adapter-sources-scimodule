############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("scimodule")
#endregion

############################################################
#region modules from the Environment
import * as sciBase from "thingy-sci-ws-base"
import * as wsi from "./wsimodule.js"

############################################################
import * as authenticationRoutes from "./authenticationroutes.js"
import * as observerRoutes from "./observerroutes.js"

#endregion

############################################################
export prepareAndExpose = ->
    log "scimodule.prepareAndExpose"
    restRoutes = Object.assign({}, authenticationRoutes)
    restRoutes = Object.assign(restRoutes, observerRoutes)
        
    # wsi.mountWSFunctions()
    sciBase.prepareAndExpose(null, restRoutes)
    sciBase.onWebsocketConnect("/", wsi.onConnect)
    
    return