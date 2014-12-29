jest
  .dontMock '../src/index'

describe 'CommentBox', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentBox, CommentPreview, CommentHelp, CommentImageSelector} = require '../src/index'

  commentBox = renderIntoDocument(<CommentBox onSubmitComment={=> return false}/>)
  form = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-form')
  textarea = findRenderedDOMComponentWithTag(form, 'textarea')
  previewBtn = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-preview-button')
  clearImageBtn = findRenderedDOMComponentWithClass(commentBox, 'talk-comment-clear-image-button')

  describe 'on submit', ->
    submitBtn = findRenderedDOMComponentWithTag(form, 'button')
    textarea.getDOMNode().innerHTML = "a comment"
    Simulate.submit(form)

    it 'clears the textarea', ->
      expect(textarea.getDOMNode().textContent).toEqual("")

    it 'sends feedback on success', ->
      expect(commentBox.state.feedback).toBeTruthy()

    it 'fires a props.onSubmitComment fn on a successful comment submit', ->
      textarea.getDOMNode().innerHTML = "a comment"
      spyOn(commentBox.props, 'onSubmitComment')
      Simulate.submit(form)
      expect(commentBox.props.onSubmitComment).toHaveBeenCalled()

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
    commentBox.setState content: "test comment"
    Simulate.click(previewBtn)

    preview = findRenderedComponentWithType(commentBox, CommentPreview)
    expect(preview.props.content).toEqual("test comment")

  it 'hides children on submit', ->
    expect(commentBox.state.showing).toEqual('preview')
    textarea.getDOMNode().innerHTML = "test commenent"
    Simulate.submit(form)
    expect(commentBox.state.showing).toBeNull()

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

  describe 'clicking clear image', ->
    it 'clears the focus image', ->
      commentBox.setState(focusImage: 'fake-test-image-source.jpg')
      Simulate.click(clearImageBtn)
      expect(commentBox.state.focusImage).toEqual(null)

  describe 'comment validations', ->
    it 'ensures comments have content', ->
      textarea.getDOMNode().innerHTML = ""
      Simulate.submit(form)
      expect(commentBox.state.validationErrors.length).toBe(1)
      expect(commentBox.state.validationErrors[0].match('must have content')).toBeTruthy()

  describe 'editing', ->
    editComment = renderIntoDocument(<CommentBox content="test edit content" />)
    editTextarea = findRenderedDOMComponentWithTag(editComment, 'textarea')

    it 'fills in the textarea with optional props.editContent', ->
      expect(editTextarea.getDOMNode().textContent).toEqual('test edit content')
