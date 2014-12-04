jest
  .dontMock '../src/index'

describe 'CollectionPreview', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CollectionPreview} = require '../src/index'

  xit 'add tests here', ->
