############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("scimodule")
#endregion

############################################################
#region node_modules
import * as sciBase from "thingy-sci-base"
import * as routes from "./sciroutes.js"
import * as handlers from "./scihandlers.js"

#endregion

############################################################
export initialize = ->
    log "initialize"
    return

############################################################
export prepareAndExpose = ->
    log "prepareAndExpose"
    sciBase.prepareAndExpose(handlers.authenticate, routes)
    return