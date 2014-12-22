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

  it 'clears the form on submit', ->
    mdlink.refs.title.getDOMNode().value = "test title"
    mdlink.refs.url.getDOMNode().value = "test url"

    Simulate.submit(form)

    expect(mdlink.refs.title.getDOMNode().value).toEqual('')
    expect(mdlink.refs.url.getDOMNode().value).toEqual('')

