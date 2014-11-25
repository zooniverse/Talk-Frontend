jest
  .dontMock '../src/index'

describe 'CommentBox', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentBox, CommentPreview, CommentHelp} = require '../src/index'

  it 'clears the textarea on submit', ->
    commentBox = renderIntoDocument(<CommentBox />)

    form = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-form')
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

  it 'hides the comment preview on submit', ->
    commentBox = renderIntoDocument(<CommentBox />)
    form = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-form')

    commentBox.setState showing: 'preview'

    previewBeforeSubmit = scryRenderedComponentsWithType(commentBox, CommentPreview)
    expect(previewBeforeSubmit.length).toBe(1)

    Simulate.submit(form)

    previewAfterSubmit = scryRenderedComponentsWithType(commentBox, CommentPreview)
    expect(previewAfterSubmit.length).toBe(0)

  it 'toggles a comment help component', ->
    commentBox = renderIntoDocument(<CommentBox />)
    helpBtn = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-help-button')

    helpDialog = scryRenderedComponentsWithType(commentBox, CommentHelp)
    expect(helpDialog.length).toBe(0)

    Simulate.click(helpBtn)
    helpDialogAfterFirstClick = scryRenderedComponentsWithType(commentBox, CommentHelp)
    expect(helpDialogAfterFirstClick.length).toBe(1)

    Simulate.click(helpBtn)
    helpDialogAfterSecondClick = scryRenderedComponentsWithType(commentBox, CommentHelp)
    expect(helpDialogAfterSecondClick.length).toBe(0)
