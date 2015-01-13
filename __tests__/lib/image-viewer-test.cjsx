jest
  .dontMock '../../src/index'

TEST_IMAGES = [
  {title: "test 1", src: "test-image-1.jpg"}
  {title: "test 1", src: "test-image-2.jpg", description: "sadasd"}
  {src: "test-image-3.jpg", description: "sadasd"}
  ]

describe 'ImageViewer', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {ImageViewer} = require '../../src/index'

  xit 'add tests here', ->
