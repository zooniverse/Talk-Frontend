jest
  .dontMock '../../src/lib/markdown-insert'

{insertAtCursor, strikethrough, heading, horizontalRule, quote, hrefLink, bold, italic, imageLink, bullet, numberedList} = require '../../src/lib/markdown-insert'

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
      textarea.selectionStart = textarea.value.length # fake it for jsdom
      textarea.selectionEnd = textarea.value.length   # fake it for jsdom

      insertAtCursor("After", textarea, {start: 'Before'.length, end: 'Before'.length})
      expect(textarea.value).toEqual("BeforeAfter")

    it 'optionally ensures content is on new line', ->
      textarea.value = "Before"
      insertAtCursor("After", textarea, {start: 'Before'.length, end: 'Before'.length}, {ensureNewLine: true})
      expect(textarea.value).toEqual("Before\nAfter")

  describe '#hrefLink', ->
    it 'formats a complete link when 2 args are passed', ->
      {text} = hrefLink("Test Link", "http://www.test.com")
      expect(text).toEqual('[Test Link](http://www.test.com)')

    it 'formats a partial link when only one arg is passed', ->
      {text} = hrefLink("title")
      expect(text).toEqual('[title](http://www.example.com)')

    it 'accepts blank strings (for forms) as non-args', ->
      {text} = hrefLink("Test title", "")
      expect(text).toEqual("[Test title](http://www.example.com)")

    it 'returns an example link when no args are passed', ->
      {text} = hrefLink()
      expect(text).toEqual("[Example Text](http://www.example.com)")

    it 'returns cursor position at end of input', ->
      {text, cursor} = hrefLink("Test Link", "url")
      expect(cursor).toEqual(start: '[Test Link]('.length, end: '[Test Link](url'.length)

  describe '#imageLink', ->
    it 'formats a complete imagelink when 2 args are passed', ->
      {text} = imageLink("http://www.test.com/image.jpg", "Test Image Link")
      expect(text).toEqual('![Test Image Link](http://www.test.com/image.jpg)')

    it 'accepts blank strings (for forms) as non-args', ->
      {text} = imageLink("", "Test Image")
      expect(text).toEqual("![Test Image](http://www.example.com/image.png)")

    it 'returns an example link when no args are passed', ->
      {text} = imageLink()
      expect(text).toEqual("![Example Alt Text](http://www.example.com/image.png)")

    it 'highlights the title text', ->
      {text, cursor} = imageLink("location", "Test Image Link")
      expect(cursor).toEqual(start: '![Test Image Link]('.length, end: "![Test Image Link](location".length)

  describe '#bold', ->
    {text, cursor} = bold("text")

    it 'wraps text in double earmuffs', ->
      expect(text).toEqual("**text**")

    it 'returns cursor position at end of text, but before closing earmuffs', ->
      expect(cursor).toEqual(start: '**'.length, end: ('**text'.length))

  describe '#italic', ->
    {text, cursor} = italic("text")
    
    it 'wraps text in earmuffs', ->
      expect(text).toEqual("*text*")

    it 'returns cursor position at end of text, but before closing earmuff', ->
      expect(cursor).toEqual(start: '*'.length, end: ('*text'.length))

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

  describe '#heading', ->
    {text, cursor} = heading("text")

    it 'wraps text in double pound symbols', ->
      expect(text).toEqual("## text ##")

    it 'returns cursor position at end of text', ->
      expect(cursor).toEqual(start: '## '.length, end: ('## text'.length))

  describe '#horizontalRule', ->
    {text, cursor} = horizontalRule("text")

    it 'adds 10 hyphens before the text, and a new line', ->
      expect(text).toEqual("----------\ntext")

    it 'returns cursor position at end of text', ->
      expect(cursor).toEqual(start: "----------\n".length, end: ("----------text\n".length))


  describe '#strikethrough', ->
    {text, cursor} = strikethrough("text")

    it 'adds 10 hyphens before the text, and a new line', ->
      expect(text).toEqual("~~text~~")

    it 'returns cursor position at end of text', ->
      expect(cursor).toEqual(start: "~~".length, end: ("~~text".length))
