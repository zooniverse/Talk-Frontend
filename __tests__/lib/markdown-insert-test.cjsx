jest
  .dontMock '../../src/lib/markdown-insert'

{insertAtCursor, quote, hrefLink, bold, italic, imageLink, bullet, numberedList} = require '../../src/lib/markdown-insert'

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
      {text} = hrefLink("http://www.test.com", "Test Link")
      expect(text).toEqual(' [Test Link](http://www.test.com) ')

    it 'formats a partial link when only one arg is passed', ->
      {text} = hrefLink("url")
      expect(text).toEqual(' [Example Title](url) ')

    it 'accepts blank strings (for forms) as non-args', ->
      {text} = hrefLink("Test Url", "")
      expect(text).toEqual(" [Example Title](Test Url) ")

    it 'returns an example link when no args are passed', ->
      {text} = hrefLink()
      expect(text).toEqual(" [Example Title](http://www.example.com) ")

    it 'returns cursor position at end of input', ->
      {text, cursor} = hrefLink("url", "Test Link")
      expect(cursor).toEqual(start: ' [Test Link]('.length, end: ' [Test Link](url'.length)

  describe '#imageLink', ->
    it 'formats a complete imagelink when 2 args are passed', ->
      {text} = imageLink("http://www.test.com/image.jpg", "Test Image Link")
      expect(text).toEqual(' ![Test Image Link](http://www.test.com/image.jpg) ')

    it 'accepts blank strings (for forms) as non-args', ->
      {text} = imageLink("", "Test Image")
      expect(text).toEqual(" ![Test Image](http://www.example.com/image.png) ")

    it 'returns an example link when no args are passed', ->
      {text} = imageLink()
      expect(text).toEqual(" ![Example Image](http://www.example.com/image.png) ")

    it 'highlights the title text', ->
      {text, cursor} = imageLink("location", "Test Image Link")
      expect(cursor).toEqual(start: ' ![Test Image Link]('.length, end: " ![Test Image Link](location".length)

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

  describe '#quote', ->
    {text, cursor} = quote("text")

    it 'puts a > symbol before text', ->
      expect(text).toEqual("> text")

    it 'returns cursor position at end of text', ->
      expect(cursor).toEqual(start: '> '.length, end: ('> text'.length))

  describe '#bullet', ->
    {text, cursor} = bullet("text")

    it 'puts a > symbol before text', ->
      expect(text).toEqual("- text")

    it 'returns cursor position at end of text', ->
      expect(cursor).toEqual(start: '- '.length, end: ('- text'.length))

  describe '#numberedList', ->
    {text, cursor} = numberedList("text")

    it 'puts a > symbol before text', ->
      expect(text).toEqual("1. text")

    it 'returns cursor position at end of text', ->
      expect(cursor).toEqual(start: '1. '.length, end: ('1. text'.length))


