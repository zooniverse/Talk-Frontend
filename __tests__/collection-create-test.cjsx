jest
  .dontMock '../src/index'

describe 'CollectionCreate', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CollectionCreate} = require '../src/index'

  xit 'add tests here', ->
