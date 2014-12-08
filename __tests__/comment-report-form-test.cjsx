jest
  .dontMock '../src/index'

describe 'CommentReportForm', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentReportForm} = require '../src/index'

  xit 'add tests here', ->
