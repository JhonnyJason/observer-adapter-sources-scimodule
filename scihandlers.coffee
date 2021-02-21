
scihandlers = {name: "scihandlers"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["scihandlers"]?  then console.log "[scihandlers]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
data = require("./datahandlermodule")

############################################################
scihandlers.authenticate = (req, res, next) ->
    try
        if req.body.authCode == "deadbeef" then next()
        else throw new Error("Wrong Auth Code!")
    catch err then res.send({error: err.stack})
    return

############################################################
#region handlerFunctions

############################################################
#region regularOperations
scihandlers.getLatestOrders = (authCode, assetPairs, subscriber) ->
    result = {}
    for pair in assetPairs
        sellStack = data.getSellStack(pair)
        buyStack = data.getBuyStack(pair)
        cancelledStack = data.getCancelledStack(pair)
        filledStack = data.getFilledStack(pair)
        if sellStack? and buyStack? and cancelledStack? and filledStack? then result[pair] = {sellStack, buyStack, cancelledStack, filledStack}
    return result

scihandlers.getLatestTickers = (authCode, assetPairs, subscriber) ->
    result = {}
    for pair in assetPairs
        result[pair] = data.getTicker(pair)
    return result

scihandlers.getLatestBalances = (authCode, assets, subscriber) ->
    result = {}
    for asset in assets
        result[asset] = data.getAssetBalance(asset)
    return result

#endregion

############################################################
#region maintenanceOperations
scihandlers.addRelevantAsset = (authCode, exchangeName, ourName) ->
    result = {}
    result.answerTo = "addRelevantAsset"
    return result

scihandlers.removeRelevantAsset = (authCode, ourName) ->
    result = {}
    result.answerTo = "removeRelevantAsset"
    return result

scihandlers.addRelevantAssetPair = (authCode, exchangeName, ourName) ->
    result = {}
    result.answerTo = "addRelevantAssetPair"
    return result

scihandlers.removeRelevantAssetPair = (authCode, ourName) ->
    result = {}
    result.answerTo = "removeRelevantAssetPair"
    return result

scihandlers.getRelevantAssets = (authCode) ->
    result = {}
    result.answerTo = "getRelevantAssets"
    return result

scihandlers.getRelevantAssetPairs = (authCode) ->
    result = {}
    result.answerTo = "getRelevantAssetPairs"
    return result

scihandlers.getFailingIdentifiers = (authCode) ->
    result = {}
    result.answerTo = "getFailingIdentifiers"
    return result

scihandlers.getServiceStatus = (authCode) ->
    result = {}
    result.answerTo = "getServiceStatus"
    return result

scihandlers.getNodeId = (authCode) ->
    result = {}
    result.answerTo = "getNodeId"
    return result

#endregion


#endregion exposed functions

export default scihandlers