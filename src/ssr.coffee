'use strict'

https     = require 'https'
xml2js    = require 'xml2js'
proj4node = require 'proj4node'

epsg =
  'EPSG:900913': proj4node('+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs')
  'EPSG:4326'  : proj4node('+proj=longlat +datum=WGS84 +no_defs')
  'EPSG:27391' : proj4node('+proj=tmerc +lat_0=58 +lon_0=-4.666666666666667 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs')
  'EPSG:27392' : proj4node('+proj=tmerc +lat_0=58 +lon_0=-2.333333333333333 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs')
  'EPSG:27393' : proj4node('+proj=tmerc +lat_0=58 +lon_0=0 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs')
  'EPSG:27394' : proj4node('+proj=tmerc +lat_0=58 +lon_0=2.5 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs')
  'EPSG:27395' : proj4node('+proj=tmerc +lat_0=58 +lon_0=6.166666666666667 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs')
  'EPSG:27396' : proj4node('+proj=tmerc +lat_0=58 +lon_0=10.16666666666667 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs')
  'EPSG:27397' : proj4node('+proj=tmerc +lat_0=58 +lon_0=14.16666666666667 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs')
  'EPSG:27398' : proj4node('+proj=tmerc +lat_0=58 +lon_0=18.33333333333333 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs')
  'EPSG:3034'  : proj4node('+proj=utm +zone=40 +ellps=helmert +units=m +no_defs')
  'EPSG:32635' : proj4node('+proj=utm +zone=35 +datum=WGS84 +units=m +no_defs')
  'EPSG:32633' : proj4node('+proj=utm +zone=33 +datum=WGS84 +units=m +no_defs')
  'EPSG:32634' : proj4node('+proj=utm +zone=34 +datum=WGS84 +units=m +no_defs')
  'EPSG:32631' : proj4node('+proj=utm +zone=31 +datum=WGS84 +units=m +no_defs')
  'EPSG:32636' : proj4node('+proj=utm +zone=36 +datum=WGS84 +units=m +no_defs')
  'EPSG:32632' : proj4node('+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs')
  'EPSG:25832' : proj4node('+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
  'EPSG:25833' : proj4node('+proj=utm +zone=33 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
  'EPSG:25834' : proj4node('+proj=utm +zone=34 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
  'EPSG:25835' : proj4node('+proj=utm +zone=35 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
  'EPSG:25836' : proj4node('+proj=utm +zone=36 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')

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
    console.log('connected')
    
    parser = new xml2js.Parser
      explicitArray: false
      ignoreAttrs: true

    parser.addListener 'end', (r) ->
      utmToLatLng r, cb
  
    res.on 'data', (d) ->
      parser.parseString d
  
  req.on 'error', (e) -> cb e

#
# Converts UTM coordinates to LatLon
#
# @param data - {@code Object} data set
# @param cb - callback function (err, data)
#
# @rturn void
#
utmToLatLng = (data, cb) ->
  if data.sokRes.sokStatus.ok
    for ssr in data.sokRes.stedsnavn
      ll = proj4node.WGS84.transform epsg["EPSG:#{ssr.epsgKode}"],
        x:ssr.aust
        y:ssr.nord

      delete ssr.aust
      delete ssr.nord

      ssr.lat = ll.x
      ssr.lon = ll.y

  cb null, data

#
# Public API
#
module.exports = (search, cb) ->
  if typeof search is 'object'
    # parse the search object
    fetchAndParse(search, cb)
  else if typeof search is 'string'
    fetchAndParse("navn=#{search}", cb)
  else
    cb new Error('Unsupported search type')