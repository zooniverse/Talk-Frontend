jest
  .dontMock '../src/index'

describe 'PostPreview', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {Post} = require '../src/index'

  xit 'add tests here', ->
