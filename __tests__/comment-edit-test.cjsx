jest
  .dontMock '../src/index'

describe 'SubjectDisplay', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentEdit} = require '../src/index'

  xit 'add tests here', ->
