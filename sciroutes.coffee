############################################################
import * as h from "./scihandlers"

############################################################
#region routes

############################################################
#region regularOperations
export getLatestOrders = (req, res) ->
    try
        response = await h.getLatestOrders(
            req.body.authCode,
            req.body.assetPairs,
            req.body.subscriber
        )
        res.send(response)
    catch err then res.send({error: err.stack})
    return

export getLatestTickers = (req, res) ->
    try
        response = await h.getLatestTickers(
            req.body.authCode,
            req.body.assetPairs,
            req.body.subscriber
        )
        res.send(response)
    catch err then res.send({error: err.stack})
    return

export getLatestBalances = (req, res) ->
    try
        response = await h.getLatestBalances(
            req.body.authCode,
            req.body.assets,
            req.body.subscriber
        )
        res.send(response)
    catch err then res.send({error: err.stack})
    return

#endregion

############################################################
#region maintenanceOperations
export addRelevantAsset = (req, res) ->
    try
        response = await h.addRelevantAsset(
            req.body.authCode,
            req.body.exchangeName,
            req.body.ourName
        )
        res.send(response)
    catch err then res.send({error:err.stack})
    return    

export removeRelevantAsset = (req, res) ->
    try
        response = await h.removeRelevantAsset(
            req.body.authCode,
            req.body.ourName
        )
        res.send(response)
    catch err then res.send({error:err.stack})
    return    

export addRelevantAssetPair = (req, res) ->
    try
        response = await h.addRelevantAssetPair(
            req.body.authCode,
            req.body.exchangeName,
            req.body.ourName
        )
        res.send(response)
    catch err then res.send({error:err.stack})
    return

export removeRelevantAssetPair = (req, res) ->
    try
        response = await h.removeRelevantAssetPair(
            req.body.authCode,
            req.body.ourName
        )
        res.send(response)
    catch err then res.send({error:err.stack})
    return

export getRelevantAssets = (req, res) ->
    try
        response = await h.getRelevantAssets(
            req.body.authCode
        )
        res.send(response)
    catch err then res.send({error:err.stack})
    return

export getRelevantAssetPairs = (req, res) ->
    try
        response = await h.getRelevantAssetPairs(
            req.body.authCode
        )
        res.send(response)
    catch err then res.send({error:err.stack})
    return

export getFailingIdentifiers = (req, res) ->
    try
        response = await h.getFailingIdentifiers(
            req.body.authCode
        )
        res.send(response)
    catch err then res.send({error:err.stack})
    return

export getServiceStatus = (req, res) ->
    try
        response = await h.getServiceStatus(
            req.body.authCode
        )
        res.send(response)
    catch err then res.send({error:err.stack})
    return

export getNodeId = (req, res) ->
    try
        response = await h.getNodeId(
            req.body.authCode
        )
        res.send(response)
    catch err then res.send({error:err.stack})
    return

#endregion

#endregion