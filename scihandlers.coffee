
############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("scihandlers")
#endregion

############################################################
import * as data from "./datahandlermodule.js"

############################################################
export authenticate = (req, res, next) ->
    try
        if req.body.authCode == "deadbeef" then next()
        else throw new Error("Wrong Auth Code!")
    catch err then res.send({error: err.stack})
    return

############################################################
#region handlerFunctions

############################################################
#region regularOperations
export getLatestOrders = (authCode, assetPairs, subscriber) ->
    result = {}
    for pair in assetPairs
        sellStack = data.getSellStack(pair)
        buyStack = data.getBuyStack(pair)
        cancelledStack = data.getCancelledStack(pair)
        filledStack = data.getFilledStack(pair)
        if sellStack? and buyStack? and cancelledStack? and filledStack? then result[pair] = {sellStack, buyStack, cancelledStack, filledStack}
    return result

export getLatestTickers = (authCode, assetPairs, subscriber) ->
    result = {}
    for pair in assetPairs
        result[pair] = data.getTicker(pair)
    return result

export getLatestBalances = (authCode, assets, subscriber) ->
    result = {}
    for asset in assets
        result[asset] = data.getAssetBalance(asset)
    return result

#endregion

############################################################
#region maintenanceOperations
export addRelevantAsset = (authCode, exchangeName, ourName) ->
    result = {}
    result.answerTo = "addRelevantAsset"
    return result

export removeRelevantAsset = (authCode, ourName) ->
    result = {}
    result.answerTo = "removeRelevantAsset"
    return result

export addRelevantAssetPair = (authCode, exchangeName, ourName) ->
    result = {}
    result.answerTo = "addRelevantAssetPair"
    return result

export removeRelevantAssetPair = (authCode, ourName) ->
    result = {}
    result.answerTo = "removeRelevantAssetPair"
    return result

export getRelevantAssets = (authCode) ->
    result = {}
    result.answerTo = "getRelevantAssets"
    return result

export getRelevantAssetPairs = (authCode) ->
    result = {}
    result.answerTo = "getRelevantAssetPairs"
    return result

export getFailingIdentifiers = (authCode) ->
    result = {}
    result.answerTo = "getFailingIdentifiers"
    return result

export getServiceStatus = (authCode) ->
    result = {}
    result.answerTo = "getServiceStatus"
    return result

export getNodeId = (authCode) ->
    result = {}
    result.answerTo = "getNodeId"
    return result

#endregion

#endregion exposed functions

