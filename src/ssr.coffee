'use strict'

https     = require 'https'
xml2js    = require 'xml2js'

#
# Fetch remote XML and parse as JSON
#
# @param params - {@code String) search params
# @param cb - callback function (err, data)
#
# @rturn void
#
fetchAndParse = (params, cb) ->
  url = "https://ws.geonorge.no/SKWS3Index/ssr/sok?#{params}"
  req = https.get url, (res) ->
    parser = new xml2js.Parser
      explicitArray: false
      ignoreAttrs: true

    parser.addListener 'end', (r) ->
      cb null, r
  
    res.on 'data', (d) ->
      parser.parseString d
  
  req.on 'error', (e) -> cb e

#
# Public API
#
module.exports = (search, cb) ->
  if typeof search is 'object'
    # parse the search object
    fetchAndParse(search, cb)
  else if typeof search is 'string'
    fetchAndParse("navn=#{search}&epsgKode=4326", cb)
  else if typeof search is 'number'
    fetchAndParse("ssrId=#{search}&epsgKode=4326", cb)
  else
    cb new Error('Unsupported search type')
