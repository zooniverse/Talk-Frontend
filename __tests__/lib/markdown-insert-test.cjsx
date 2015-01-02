jest
  .dontMock '../../src/lib/markdown-insert'

{insertAtCursor, hrefLink, bold, italic, imageLink} = require '../../src/lib/markdown-insert'

describe 'markdown insert', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils

  InputContainer = React.createClass
    render: -> <textarea ref="textarea"></textarea>

  inputContainer = renderIntoDocument(<InputContainer />)

  textarea = findRenderedDOMComponentWithTag(inputContainer, 'textarea').getDOMNode()

  describe '#insertAtCursor', ->
    it 'adds text to an input', ->
      insertAtCursor("Test Input", textarea, {start: 0, end: 0})
      expect(textarea.value).toEqual("Test Input")

    it 'retains existing text', ->
      textarea.value = "Before"
      insertAtCursor("After", textarea, {start: 'Before'.length, end: 'Before'.length})
      expect(textarea.value).toEqual("BeforeAfter")

  describe '#hrefLink', ->
    it 'formats a complete link when 2 args are passed', ->
      {text} = hrefLink("Test Link", "http://www.test.com")
      expect(text).toEqual(' [Test Link](http://www.test.com) ')

    it 'formats a partial link when only one arg is passed', ->
      {text} = hrefLink("Test Link")
      expect(text).toEqual(' [Test Link](http://www.example.com) ')

    it 'accepts blank strings (for forms) as non-args', ->
      {text} = hrefLink("", "Test Image")
      expect(text).toEqual(" [Example Title](Test Image) ")

    it 'returns an example link when no args are passed', ->
      {text} = hrefLink()
      expect(text).toEqual(" [Example Title](http://www.example.com) ")

    it 'returns cursor position at end of input', ->
      {text, cursor} = hrefLink("Test Link", "http://www.test.com")
      expect(cursor).toEqual(start: ' ['.length, end: ' [Test Link'.length)

  describe '#imageLink', ->
    it 'formats a complete imagelink when 2 args are passed', ->
      {text} = imageLink("Test Image Link", "http://www.test.com/image.jpg")
      expect(text).toEqual(' ![Test Image Link](http://www.test.com/image.jpg) ')

    it 'accepts blank strings (for forms) as non-args', ->
      {text} = imageLink("", "Test Image")
      expect(text).toEqual(" ![Example Image](Test Image) ")

    it 'returns an example link when no args are passed', ->
      {text} = imageLink()
      expect(text).toEqual(" ![Example Image](http://www.example.com/image.png) ")

    it 'highlights the title text', ->
      {text, cursor} = imageLink("Test Image Link", "http://www.test.com/image.jpg")
      expect(cursor).toEqual(start: ' !['.length, end: " ![Test Image Link".length)

  describe '#bold', ->
    {text, cursor} = bold("text")

    it 'wraps text in double earmuffs', ->
      expect(text).toEqual(" **text** ")

    it 'returns cursor position at end of text, but before closing earmuffs', ->
      expect(cursor).toEqual(start: ' **'.length, end: (' **text'.length))

  describe '#italic', ->
    {text, cursor} = italic("text")
    
    it 'wraps text in earmuffs', ->
      expect(text).toEqual(" *text* ")

    it 'returns cursor position at end of text, but before closing earmuff', ->
      expect(cursor).toEqual(start: ' *'.length, end: (' *text'.length))
