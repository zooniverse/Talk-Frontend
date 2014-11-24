jest
  .dontMock '../src/index'

describe 'CommentPreview', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentPreview} = require '../src/index'

  it 'replaces @user mentions with a link to the user', ->
    commentPreview = renderIntoDocument(<CommentPreview content="test content @user:test_user" />)
    commentPreviewText = findRenderedDOMComponentWithClass(commentPreview, 'talk-comment-preview-content')

    expect(commentPreviewText.getDOMNode().innerHTML).toEqual("test content <a href=\"http://www.zooniverse.org/user/test_user\">test_user</a>")

  it 'replaces @subject mentions with a link to the subject', ->
    commentPreview = renderIntoDocument(<CommentPreview content="test content @subject:test_subject" />)
    commentPreviewText = findRenderedDOMComponentWithClass(commentPreview, 'talk-comment-preview-content')

    expect(commentPreviewText.getDOMNode().innerHTML).toEqual("test content <a href=\"http://www.zooniverse.org/subjects/test_subject\">test_subject</a>")
