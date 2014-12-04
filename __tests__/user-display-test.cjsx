jest
  .dontMock '../src/index'

describe 'UserDisplay', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {UserDisplay} = require '../src/index'

  xit 'add tests here', ->
