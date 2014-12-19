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
    it 'formats a complete link when 2 args are passed', ->
      link = hrefLink("Test Link", "http://www.test.com")
      expect(link).toEqual(' [Test Link](http://www.test.com) ')

    it 'formats a partial link when only one arg is passed', ->
      link = hrefLink("Test Link")
      expect(link).toEqual(' [Test Link](http://www.example.com) ')

    it 'accepts blank strings (for forms) as non-args', ->
      link = hrefLink("", "Test Image")
      expect(link).toEqual(" [Example Title](Test Image) ")

    it 'returns an example link when no args are passed', ->
      link = hrefLink()
      expect(link).toEqual(" [Example Title](http://www.example.com) ")

  describe '#imageLink', ->
    it 'formats a complete imagelink when 2 args are passed', ->
      link = imageLink("Test Image Link", "http://www.test.com/image.jpg")
      expect(link).toEqual(' ![Test Image Link](http://www.test.com/image.jpg) ')

    it 'accepts blank strings (for forms) as non-args', ->
      image = imageLink("", "Test Image")
      expect(image).toEqual(" ![Example Image](Test Image) ")

    it 'returns an example link when no args are passed', ->
      image = imageLink()
      expect(image).toEqual(" ![Example Image](http://www.example.com/image.png) ")
