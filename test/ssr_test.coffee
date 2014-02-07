'use strict'

assert = require 'assert'
ssr    = require './../lib/ssr'

describe 'ssr.js', ->

  it 'should convert XML to JSON', (done) ->
    ssr 'Bergen', (err, data) ->
      throw err if err

      assert.equal typeof data.sokRes, 'object', 'property sokRes should be an object'
      assert.equal typeof data.sokRes.sokStatus, 'object', 'property sokRes.sokStatus should be an object'
      assert.equal typeof data.sokRes.sokStatus.ok, 'string', 'search status ok should be a string'
      assert.equal typeof data.sokRes.sokStatus.melding, 'string', 'search status message should be a string'
      assert.equal typeof data.sokRes.totaltAntallTreff, 'string', 'number of matches should be string'
      assert.equal typeof data.sokRes.stedsnavn, 'object', 'returned matches should be an object'

      for sted in data.sokRes.stedsnavn
        assert.equal typeof sted.ssrId, 'string', 'ssr id should be a string'
        assert.equal typeof sted.navnetype, 'string', 'ssr name type should be a string'
        assert.equal typeof sted.kommunenavn, 'string', 'ssr municipal name should be a string'
        assert.equal typeof sted.fylkesnavn, 'string', 'ssr county name should be a string'
        assert.equal typeof sted.stedsnavn, 'string', 'ssr place name should be a string'
        assert.equal typeof sted.aust, 'string', 'ssr east should be a string'
        assert.equal typeof sted.nord, 'string', 'ssr north should be a string'
        assert.equal typeof sted.skrivemaatestatus, 'string', 'ssr writing status should be a string'
        assert.equal typeof sted.spraak, 'string', 'ssr language should be a string'
        assert.equal typeof sted.skrivemaatenavn, 'string', 'ssr writing status name should be a string'
        assert.equal typeof sted.epsgKode, 'string', 'ssr EPSG code should be a string'

      done()

  it 'should handle emty result set', (done) ->
    ssr '', (err, data) ->
      throw err if err

      assert.equal typeof data.sokRes, 'object', 'property sokRes should be an object'
      assert.equal typeof data.sokRes.sokStatus, 'object', 'property sokRes.sokStatus should be an object'
      assert.equal data.sokRes.sokStatus.ok, 'true', 'search status should be OK'
      assert.equal data.sokRes.sokStatus.melding, '', 'search status message should be empty'
      assert.equal data.sokRes.totaltAntallTreff, '0', 'number of matches should be 0'
      assert.equal typeof data.sokRes.stedsnavn, 'undefined', 'data set should be undefined'

      done()

  it 'should fetch single ssr', (done) ->
    ssr 1148612, (err, data) ->
      throw err if err

      assert.equal data.sokRes.totaltAntallTreff, '1', 'number of matches should be 1'
      assert.equal typeof data.sokRes.stedsnavn, 'object', 'data set should be an object'

      assert.equal typeof data.sokRes.stedsnavn.ssrId, 'string', 'ssr id should be a string'
      assert.equal typeof data.sokRes.stedsnavn.navnetype, 'string', 'ssr name type should be a string'
      assert.equal typeof data.sokRes.stedsnavn.kommunenavn, 'string', 'ssr municipal name should be a string'
      assert.equal typeof data.sokRes.stedsnavn.fylkesnavn, 'string', 'ssr county name should be a string'
      assert.equal typeof data.sokRes.stedsnavn.stedsnavn, 'string', 'ssr place name should be a string'
      assert.equal typeof data.sokRes.stedsnavn.aust, 'string', 'ssr east should be a string'
      assert.equal typeof data.sokRes.stedsnavn.nord, 'string', 'ssr north should be a string'
      assert.equal typeof data.sokRes.stedsnavn.skrivemaatestatus, 'string', 'ssr writing status should be a string'
      assert.equal typeof data.sokRes.stedsnavn.spraak, 'string', 'ssr language should be a string'
      assert.equal typeof data.sokRes.stedsnavn.skrivemaatenavn, 'string', 'ssr writing status name should be a string'
      assert.equal typeof data.sokRes.stedsnavn.epsgKode, 'string', 'ssr EPSG code should be a string'

      done()
