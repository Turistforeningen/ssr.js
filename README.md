ssr.js
======

SSR.js is a NodeJS wrapper for the official place registry ([SSR](http://www.statkart.no/Kart/Kartverksted/Stedsnavnsok/)) from the Norwegian Mapping Authority – [Kartverket](http://kartverket.no/en/About-The-Norwegian-Mapping-Authority/) – whom bears nationwide responsibility for geographical information, operates the national property registry and undertakes all property registration in Norway.

## Disclaimer
The Kartverket name and logo are copyright of the Norwegian Mapping Authority. This application is not produced by or affiliated with Kartverket. 

## The SSR Service

The data are suitable for use in the search for solutions name research, navigation on land and sea, searching medium of interactive maps, preparation of topographic maps and data for SSR-search in map solutions on the Internet.

### Documentation

* [User guide (PDF)](http://www.kartverket.no/Documents/Kart/Stedsnavn/Veledning_indeksert_stedsnavnsok.pdf)
* [Terms of Service](http://www.statkart.no/Kart/Kartverksted/Lisens/)

### Service Uptime

Unfortunately the service from Karverket is highly unreliable and we advice against using this for production purposes.

![Pingdom Uptime Report for SSR server](https://share.pingdom.com/banners/a3d99065)

## ssr.js wrapper

### Usage

```javascript
var places = ssrjs('Jotunheimen*', function(err, data) {
  if (err) { return console.err(err); }
  console.log(data);
});
```

### Build

```
npm run-script build
```

### Test

```
npm run-script test
```

### Copyright

Copyright (c) 2013, Turistforeningen, Hans Kristian Flaatten

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.