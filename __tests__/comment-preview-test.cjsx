jest
  .dontMock '../src/index'

describe 'CommentBox', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentPreview} = require '../src/index'

  it 'replaces @user mentions with a link to the user', ->
    commentPreview = renderIntoDocument(<CommentPreview content="test content @user:test_user" />)
    commentPreviewText = findRenderedDOMComponentWithClass(commentPreview, 'talk-comment-preview-content')

    expect(commentPreviewText.getDOMNode().innerHTML).toEqual("test content <a href=\"http://www.zooniverse.org/user/test_user\">test_user</a>")
