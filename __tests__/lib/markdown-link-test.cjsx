jest
  .dontMock '../../src/index'

describe 'MarkdownLink', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedDOMComponentsWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {MarkdownLink} = require '../../src/index'
  onCreateLink = -> return false

  mdlink = renderIntoDocument(<MarkdownLink onCreateLink={onCreateLink} />)

  form = findRenderedDOMComponentWithTag(mdlink, 'form')

  it 'fires a callback #onCreateLink when the form is submitted', ->
    spyOn(mdlink.props, 'onCreateLink')
    Simulate.submit(form)

    expect(mdlink.props.onCreateLink).toHaveBeenCalled()
