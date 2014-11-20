jest
  .dontMock '../src/index'

describe 'ExampleComponent', ->
  React = require 'react/addons'
  TestUtils = React.addons.TestUtils
  {ExampleComponent} = require '../src/index'

  it 'has text content of "Example"', ->
    example = TestUtils.renderIntoDocument(<ExampleComponent />)
    div = TestUtils.findRenderedDOMComponentWithTag(example, 'div')

    expect(div.getDOMNode().textContent).toEqual("Example")

