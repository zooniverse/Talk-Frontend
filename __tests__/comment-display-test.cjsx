jest
  .dontMock '../src/index'

describe 'CommentDisplay', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentDisplay, CommentBox, CommentLink, CommentReportForm} = require '../src/index'

  commentDisplay = renderIntoDocument(<CommentDisplay date={(new Date)} markdown="# Test Header"/>)

  describe 'toggling children', ->
    replyButton = findRenderedDOMComponentWithClass(commentDisplay, 'talk-comment-display-reply-button')
    linkButton = findRenderedDOMComponentWithClass(commentDisplay, 'talk-comment-display-link-button')
    reportButton = findRenderedDOMComponentWithClass(commentDisplay, 'talk-comment-display-report-button')

    it 'sets showing state to "reply" when clicked', ->
      Simulate.click(replyButton)
      expect(commentDisplay.state.showing).toEqual('reply')
      
    it 'sets showing state to "report" when clicked', ->
      Simulate.click(reportButton)
      expect(commentDisplay.state.showing).toEqual('report')

    it 'sets showing state to "link" when clicked', ->
      Simulate.click(linkButton)
      expect(commentDisplay.state.showing).toEqual('link')


  describe 'editing', ->
    editButton = findRenderedDOMComponentWithClass(commentDisplay, 'talk-comment-display-edit-button')

    it 'sets state.editing to true when the button is clicked', ->
      Simulate.click(editButton)
      expect(commentDisplay.state.editing).toEqual(true)

    it 'shows a CommentBox to make edits', ->
      commentBox = findRenderedComponentWithType(commentDisplay, CommentBox)
      expect(commentBox?).toBeTruthy()

    it 'sets state.editing to false when a comment is submitted', ->
      commentDisplay.onSubmitComment()
      expect(commentDisplay.state.editing).toEqual(false)
