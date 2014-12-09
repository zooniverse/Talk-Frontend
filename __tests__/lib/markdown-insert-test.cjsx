jest
  .dontMock '../../src/lib/markdown-insert'

{insertAtCursor} = require '../../src/lib/markdown-insert'

describe 'markdown insert', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils

  InputContainer = React.createClass
    render: -> <textarea ref="textarea"></textarea>

  inputContainer = renderIntoDocument(<InputContainer />)

  textarea = findRenderedDOMComponentWithTag(inputContainer, 'textarea').getDOMNode()

  describe '#insertAtCursor', ->
    it 'adds text to an input', ->
      insertAtCursor("Test Input", textarea)
      expect(textarea.value).toEqual("Test Input")

    it 'retains existing text', ->
      textarea.value = "Before"
      insertAtCursor("After", textarea)
      expect(textarea.value).toEqual("BeforeAfter")

