jest
  .dontMock '../src/index'

describe 'PrivateMessagePreview', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {PrivateMessagePreview} = require '../src/index'

  xit 'add tests here', ->
