jest
  .dontMock '../src/index'

describe 'CommentBox', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentBox, CommentPreview} = require '../src/index'

  it 'clears the textarea on submit', ->
    commentBox = renderIntoDocument(<CommentBox />)

    form = findRenderedDOMComponentWithTag(commentBox, 'form')
    textarea = findRenderedDOMComponentWithTag(form, 'textarea')
    submitBtn = findRenderedDOMComponentWithTag(form, 'button')

    textarea.getDOMNode().innerHTML = "a comment"
    expect(textarea.getDOMNode().textContent).toEqual("a comment")
    Simulate.submit(form)
    expect(textarea.getDOMNode().textContent).toEqual("")

  it 'toggles a CommentPreview component', ->
    commentBox = renderIntoDocument(<CommentBox />)
    previewBtn = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-preview-button')

    preview = scryRenderedComponentsWithType(commentBox, CommentPreview)
    expect(preview.length).toBe(0)

    Simulate.click(previewBtn)
    previewAfterFirstClick = scryRenderedComponentsWithType(commentBox, CommentPreview)
    expect(previewAfterFirstClick.length).toBe(1)

    Simulate.click(previewBtn)
    previewAfterSecondClick = scryRenderedComponentsWithType(commentBox, CommentPreview)
    expect(previewAfterSecondClick.length).toBe(0)

  it 'sends the textarea content to the preview component', ->
    commentBox = renderIntoDocument(<CommentBox />)
    previewBtn = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-preview-button')
    textarea = findRenderedDOMComponentWithTag(commentBox, 'textarea')

    textarea.getDOMNode().innerHTML = "test comment"
    Simulate.click(previewBtn)

    preview = findRenderedComponentWithType(commentBox, CommentPreview)
    expect(preview.getDOMNode().textContent.match("test comment")).toBeTruthy()
