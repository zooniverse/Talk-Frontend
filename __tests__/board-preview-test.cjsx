jest
  .dontMock '../src/index'

describe 'BoardPreview', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {BoardPreview} = require '../src/index'

  xit 'add tests here', ->
