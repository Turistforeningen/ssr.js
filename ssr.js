var https = require('https');
var proj4node = require('proj4node')
var xml2js = require('xml2js');

var epsg = {
  'EPSG:900913': proj4node('+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs'),
  'EPSG:4326'  : proj4node('+proj=longlat +datum=WGS84 +no_defs'),
  'EPSG:27391' : proj4node('+proj=tmerc +lat_0=58 +lon_0=-4.666666666666667 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs'),
  'EPSG:27392' : proj4node('+proj=tmerc +lat_0=58 +lon_0=-2.333333333333333 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs'),
  'EPSG:27393' : proj4node('+proj=tmerc +lat_0=58 +lon_0=0 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs'),
  'EPSG:27394' : new proj4node('+proj=tmerc +lat_0=58 +lon_0=2.5 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs'),
  'EPSG:27395' : new proj4node('+proj=tmerc +lat_0=58 +lon_0=6.166666666666667 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs'),
  'EPSG:27396' : new proj4node('+proj=tmerc +lat_0=58 +lon_0=10.16666666666667 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs'),
  'EPSG:27397' : new proj4node('+proj=tmerc +lat_0=58 +lon_0=14.16666666666667 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs'),
  'EPSG:27398' : new proj4node('+proj=tmerc +lat_0=58 +lon_0=18.33333333333333 +k=1 +x_0=0 +y_0=0 +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +pm=oslo +units=m +no_defs'),
  'EPSG:3034'  : proj4node('+proj=utm +zone=40 +ellps=helmert +units=m +no_defs'),
  'EPSG:32635' : proj4node('+proj=utm +zone=35 +datum=WGS84 +units=m +no_defs'),
  'EPSG:32633' : proj4node('+proj=utm +zone=33 +datum=WGS84 +units=m +no_defs'),
  'EPSG:32634' : proj4node('+proj=utm +zone=34 +datum=WGS84 +units=m +no_defs'),
  'EPSG:32631' : proj4node('+proj=utm +zone=31 +datum=WGS84 +units=m +no_defs'),
  'EPSG:32636' : proj4node('+proj=utm +zone=36 +datum=WGS84 +units=m +no_defs'),
  'EPSG:32632' : proj4node('+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs'),
  'EPSG:25832' : proj4node('+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'),
  'EPSG:25833' : proj4node('+proj=utm +zone=33 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'),
  'EPSG:25834' : proj4node('+proj=utm +zone=34 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'),
  'EPSG:25835' : proj4node('+proj=utm +zone=35 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'),
  'EPSG:25836' : proj4node('+proj=utm +zone=36 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
}

function parseSSRs(data, cb) {
  if (data.sokRes.sokStatus.ok) {
    for (var i = 0; i < data.sokRes.stedsnavn.length; i++) {
      var ssr = data.sokRes.stedsnavn[i];
      var  ll = proj4node.WGS84.transform(epsg['EPSG:' + ssr.epsgKode], {x:ssr.aust, y:ssr.nord});
      console.log(ssr.stedsnavn, ll.x, ll.y);
    }
    
  } else {
    
  }
}

// var parser = new xml2js.Parser({explicitArray: false, ignoreAttrs: true});
// fs.readFile(__dirname + '/ssr.xml', function(err, data) {
//   parser.parseString(data, function (err, result) {
//     parseSSRs(result);
//   });
// });

https.get('https://ws.geonorge.no/SKWS3Index/ssr/sok?navn=Bergen', function(res) {
  console.log('connection established!...');

  var parser = new xml2js.Parser({
    explicitArray: false
    ,ignoreAttrs: true
  });
  parser.addListener('end', function(result) {
    parseSSRs(result, function() {
      console.log('done');
    })
  });

  res.on('data', function(d) {
    parser.parseString(d);
  });

}).on('error', function(e) {
  console.error(e);
});
