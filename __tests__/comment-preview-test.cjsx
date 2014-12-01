jest
  .dontMock '../src/index'

describe 'CommentPreview', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentPreview} = require '../src/index'

  describe '#replaceSymbols', ->
    it 'replaces @user mentions with a link to the user', ->
      commentPreview = renderIntoDocument(<CommentPreview content="test content @test_user" />)
      formattedContent = commentPreview.replaceSymbols(commentPreview.props.content)

      expect(formattedContent).toEqual("test content <a href=\'http://www.zooniverse.org/user/test_user\'>test_user</a>")

    it 'replaces ^subject mentions with a link to the subject', ->
      commentPreview = renderIntoDocument(<CommentPreview content="test content ^GZ12384" />)
      formattedContent = commentPreview.replaceSymbols(commentPreview.props.content)

      expect(formattedContent).toEqual("test content <a href=\'http://www.zooniverse.org/subjects/GZ12384\'>GZ12384</a>")

    it 'replaces #hashtag mentions with a link to other hashtagged items', ->
      commentPreview = renderIntoDocument(<CommentPreview content="test content #testHashTag" />)
      formattedContent = commentPreview.replaceSymbols(commentPreview.props.content)

      expect(formattedContent).toEqual("test content <a href=\'http://www.zooniverse.org/tags/testHashTag\'>#testHashTag</a>")

  describe '#markdownify', ->
    it 'renders markdown', ->
      commentPreview = renderIntoDocument(<CommentPreview content="test content" />)
      markdown = commentPreview.markdownify(commentPreview.props.content)

      expect(markdown.trim()).toEqual("<p>test content</p>")

    it 'calls the #replaceSymbols callback with transformed markdown', ->
      commentPreview = renderIntoDocument(<CommentPreview content="test content" />)
      spyOn(commentPreview, 'replaceSymbols')

      commentPreview.markdownify(commentPreview.props.content)
      expect(commentPreview.replaceSymbols).toHaveBeenCalled()
      expect(commentPreview.replaceSymbols).toHaveBeenCalledWith("<p>test content</p>\n")
