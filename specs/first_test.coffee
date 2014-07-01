require 'colors'

# require and init ChaiJS
chai = require 'chai'
chaiAsPromised = require "chai-as-promised"
expect = chai.expect
chai.use chaiAsPromised
chai.should()

# require webdriver
wd = require 'wd'

# enables chai assertion chaining in webdriver
chaiAsPromised.transferPromiseness = wd.transferPromiseness;

# load test config and testData
config = require '../config.json'
testData = require '../' + config.testDataFile

# desacribe application
describe 'Bing.com', ->
  #  initialize webdriver object
  this.timeout config.timeout
  browser = wd.promiseChainRemote(config.server)

  # before all examples
  before ->
    # start new browser session
    browser.init {browserName: config.browser}

  # after all examples
  after ->
    # close browser session
    browser.quit()

  # describe application context
  describe "landing page", ->

    # before all examples
    before ->
      browser.get "http://www.bing.com"

    # examples
    it 'should be successfuly displayed', ->
      browser.get "http://www.bing.com"
        .title()
          .should.become "Bing"

 # describe application context and user action
  describe "perform search", ->

    # before all examples perform action
    before ->
      browser
        .get testData.url
        .elementById 'sb_form_q'
          .type testData.search_term
          .submit()

    # examples - assert application state for test case
    it 'should display correct browser title', ->
      browser
        .title()
          .should.become testData.search_term + " - Bing"

    it 'should display results', ->
      browser
        .elementByCss("li.b_algo")
          .text()
            .then (text) ->
              text.should.include testData.search_term