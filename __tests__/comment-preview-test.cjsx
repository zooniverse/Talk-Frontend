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

    it 'calls #replaceSymbols with transformed markdown', ->
      commentPreview = renderIntoDocument(<CommentPreview content="test content" />)
      spyOn(commentPreview, 'replaceSymbols')

      commentPreview.markdownify(commentPreview.props.content)
      expect(commentPreview.replaceSymbols).toHaveBeenCalled()
      expect(commentPreview.replaceSymbols).toHaveBeenCalledWith("<p>test content</p>\n")

    describe 'custom image sizing', ->
      it 'sets width and height when a "widthXheight" argument is passed', ->
        image = "![Example Image](/image.jpg '100x200')"
        commentPreview = renderIntoDocument(<CommentPreview content={image} />)
        markdown = commentPreview.markdownify(commentPreview.props.content)

        expect(markdown.trim()).toEqual("<p><img src=/image.jpg alt=Example Image width=100 height=200 /></p>")

      it 'sets width when a "width" argument is passed', ->
        image = "![Example Image](/image.jpg '100')"
        commentPreview = renderIntoDocument(<CommentPreview content={image} />)
        markdown = commentPreview.markdownify(commentPreview.props.content)

        expect(markdown.trim()).toEqual("<p><img src=/image.jpg alt=Example Image width=100  /></p>")

  describe '#emojify', ->
    it 'replaces emoji', ->
      commentPreview = renderIntoDocument(<CommentPreview content=":smile:" />)
      emojiOutput = commentPreview.emojify(commentPreview.props.content)
      expect(emojiOutput.trim()).toEqual("<img class='talk-emoji' src='http://www.tortue.me/emoji/smile.png' alt=':smile:' title=':smile:' />")

