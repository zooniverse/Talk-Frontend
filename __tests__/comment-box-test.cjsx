jest
  .dontMock '../src/index'

describe 'CommentBox', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentBox, CommentPreview, CommentHelp, CommentImageSelector} = require '../src/index'

  commentBox = renderIntoDocument(<CommentBox />)
  form = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-form')
  textarea = findRenderedDOMComponentWithTag(form, 'textarea')
  previewBtn = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-preview-button')

  it 'clears the textarea on submit', ->
    submitBtn = findRenderedDOMComponentWithTag(form, 'button')

    textarea.getDOMNode().innerHTML = "a comment"
    expect(textarea.getDOMNode().textContent).toEqual("a comment")
    Simulate.submit(form)
    expect(textarea.getDOMNode().textContent).toEqual("")

  it 'toggles a CommentPreview component', ->
    preview = scryRenderedComponentsWithType(commentBox, CommentPreview)
    expect(preview.length).toBe(0)

    Simulate.click(previewBtn)
    previewAfterFirstClick = scryRenderedComponentsWithType(commentBox, CommentPreview)
    expect(previewAfterFirstClick.length).toBe(1)

    Simulate.click(previewBtn)
    previewAfterSecondClick = scryRenderedComponentsWithType(commentBox, CommentPreview)
    expect(previewAfterSecondClick.length).toBe(0)

  it 'sends the textarea content to the preview component', ->
    textarea.getDOMNode().innerHTML = "test comment"
    Simulate.click(previewBtn)

    preview = findRenderedComponentWithType(commentBox, CommentPreview)

    expect(preview.props.content).toEqual("test comment")

  it 'hides the comment preview on submit', ->
    commentBox.setState showing: 'preview'

    previewBeforeSubmit = scryRenderedComponentsWithType(commentBox, CommentPreview)
    expect(previewBeforeSubmit.length).toBe(1)

    Simulate.submit(form)

    previewAfterSubmit = scryRenderedComponentsWithType(commentBox, CommentPreview)
    expect(previewAfterSubmit.length).toBe(0)

  it 'toggles a comment help component', ->
    helpBtn = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-help-button')

    helpDialog = scryRenderedComponentsWithType(commentBox, CommentHelp)
    expect(helpDialog.length).toBe(0)

    Simulate.click(helpBtn)
    helpDialogAfterFirstClick = scryRenderedComponentsWithType(commentBox, CommentHelp)
    expect(helpDialogAfterFirstClick.length).toBe(1)

    Simulate.click(helpBtn)
    helpDialogAfterSecondClick = scryRenderedComponentsWithType(commentBox, CommentHelp)
    expect(helpDialogAfterSecondClick.length).toBe(0)

  it 'toggles a comment image selector component', ->
    helpBtn = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-image-select-button')

    imageSelector = scryRenderedComponentsWithType(commentBox, CommentImageSelector)
    expect(imageSelector.length).toBe(0)

    Simulate.click(helpBtn)
    imageSelectorAfterFirstClick = scryRenderedComponentsWithType(commentBox, CommentImageSelector)
    expect(imageSelectorAfterFirstClick.length).toBe(1)

    Simulate.click(helpBtn)
    imageSelectorAfterSecondClick = scryRenderedComponentsWithType(commentBox, CommentImageSelector)
    expect(imageSelectorAfterSecondClick.length).toBe(0)

  describe 'comment validations', ->
    it 'ensures comments have content', ->
      textarea.getDOMNode().innerHTML = ""
      Simulate.submit(form)
      expect(commentBox.state.validationErrors.length).toBe(1)
      expect(commentBox.state.validationErrors[0].match('must have content')).toBeTruthy()
