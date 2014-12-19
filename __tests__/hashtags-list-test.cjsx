jest
  .dontMock '../src/index'

describe 'HashtagsList', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {HashtagsList} = require '../src/index'

  xit 'add tests here', ->
