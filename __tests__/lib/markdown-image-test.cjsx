jest
  .dontMock '../../src/index'

describe 'MarkdownImage', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedDOMComponentsWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {MarkdownImage} = require '../../src/index'
  onCreateImage = -> return false

  mdimage = renderIntoDocument(<MarkdownImage onCreateImage={onCreateImage} />)

  form = findRenderedDOMComponentWithTag(mdimage, 'form')

  it 'fires a callback #onCreateImage when the form is submitted', ->
    spyOn(mdimage.props, 'onCreateImage')
    Simulate.submit(form)

    expect(mdimage.props.onCreateImage).toHaveBeenCalled()

  it 'clears the form on submit', ->
    mdimage.refs.alt.getDOMNode().value = "test title"
    mdimage.refs.url.getDOMNode().value = "test url"

    Simulate.submit(form)

    expect(mdimage.refs.alt.getDOMNode().value).toEqual('')
    expect(mdimage.refs.url.getDOMNode().value).toEqual('')
    
