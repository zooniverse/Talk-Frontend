jest
  .dontMock '../src/index'

describe 'CollectionPreview', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CollectionPreview} = require '../src/index'

  preview = renderIntoDocument(<CollectionPreview />)
  deleteButton = findRenderedDOMComponentWithClass(preview, 'talk-collection-preview-delete-button')

  it 'calls window confirm before deleting a collection', ->
    spyOn(window, 'confirm')
    Simulate.click(deleteButton)
    expect(window.confirm).toHaveBeenCalled()
