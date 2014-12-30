jest
  .dontMock '../src/index'

describe 'CommentReportForm', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentReportForm} = require '../src/index'

  commentReportForm = renderIntoDocument(<CommentReportForm />)

  form = findRenderedDOMComponentWithTag(commentReportForm, 'form')
  textarea = findRenderedDOMComponentWithTag(form, 'textarea')

  it 'errors if the report form is blank', ->
    textarea.getDOMNode().value = ''
    Simulate.submit(form)
    expect(commentReportForm.state.validationErrors.length).toBeTruthy()

  it 'sends success feedback if no errors', ->
    textarea.getDOMNode().value = 'success'
    Simulate.submit(form)

    expect(commentReportForm.state.validationErrors.length).toBeFalsy()
    expect(!!~commentReportForm.state.feedback.indexOf('success')).toBeTruthy()
