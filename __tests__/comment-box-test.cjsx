jest
  .dontMock '../src/index'

describe 'CommentBox', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentBox} = require '../src/index'

  it 'clears the textarea on submit', ->
    commentBox = renderIntoDocument(<CommentBox />)

    form = findRenderedDOMComponentWithTag(commentBox, 'form')
    textarea = findRenderedDOMComponentWithTag(form, 'textarea')
    submitBtn = findRenderedDOMComponentWithTag(form, 'button')

    textarea.getDOMNode().innerHTML = "a comment"
    expect(textarea.getDOMNode().textContent).toEqual("a comment")
    Simulate.submit(form)
    expect(textarea.getDOMNode().textContent).toEqual("")
