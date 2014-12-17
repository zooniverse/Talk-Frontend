jest
  .dontMock '../../src/lib/markdown-insert'

{insertAtCursor, hrefLink, imageLink} = require '../../src/lib/markdown-insert'

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

  describe '#hrefLink', ->
    it 'formats a link when a title arg is passed', ->
      link = hrefLink("Test Link")
      expect(link).toEqual(' [Test Link](http://www.example.com) ')

    it 'returns an example link when no args are passed', ->
      link = hrefLink()
      expect(link).toEqual(" [Example Title](http://www.example.com) ")

  describe '#imageLink', ->
    it 'formats an image when href and title args are passed', ->
      image = imageLink("Test Image")
      expect(image).toEqual(" ![Test Image](http://www.example.com/image.png) ")

    it 'returns an example link when no args are passed', ->
      image = imageLink()
      expect(image).toEqual(" ![Example Image](http://www.example.com/image.png) ")


