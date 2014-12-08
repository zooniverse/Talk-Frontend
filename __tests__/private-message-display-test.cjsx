jest
  .dontMock '../src/index'

describe 'PrivateMessageDisplay', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {PrivateMessageDisplay} = require '../src/index'

  xit 'add tests here', ->
