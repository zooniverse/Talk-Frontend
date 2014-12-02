jest
  .dontMock '../src/index'

describe 'CommentDisplay', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentDisplay, CommentBox, CommentLink, CommentReportForm} = require '../src/index'

  commentDisplay = renderIntoDocument(<CommentDisplay date={(new Date)} html="<h1>Test Header</h1>"/>)

  it 'renders talk comments as HTML', ->
    displayContent = findRenderedDOMComponentWithClass(commentDisplay, "talk-comment-display-content")
    expect(displayContent.getDOMNode().innerHTML).toEqual("<h1>Test Header</h1>")
  
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

