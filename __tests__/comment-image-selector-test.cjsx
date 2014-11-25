jest
  .dontMock '../src/index'
  
TEST_IMAGES = [
  {
    id: "GZ12384"
    location: "http://placehold.it/200X200&text=GZ12384"
  },
  {
    id: "GZ21414"
    location: "http://placehold.it/200X200&text=GZ21414"
  }
]

describe 'CommentImageSelector', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CommentImageSelector} = require '../src/index'

  it 'holds a list of images', ->
    selector = renderIntoDocument(<CommentImageSelector />)
    selector.setState(images: [])

    images = scryRenderedDOMComponentsWithClass(selector, 'talk-comment-image-item')
    expect(images.length).toEqual(0)

    selector.setState(images: TEST_IMAGES)
    imagesAfterUpdate = scryRenderedDOMComponentsWithClass(selector, 'talk-comment-image-item')
    expect(imagesAfterUpdate.length).toEqual(TEST_IMAGES.length)

  it 'updates images after a search query', ->
    selector = renderIntoDocument(<CommentImageSelector />)
    selector.setState(images: TEST_IMAGES)

    # stub query for images
    selector.queryForImages = (query) ->
      TEST_IMAGES.filter (img) => img.id.toLowerCase() is query.toLowerCase()

    form = findRenderedDOMComponentWithTag(selector, 'form')
    input = findRenderedDOMComponentWithTag(form, 'input')

    input.getDOMNode().value = 'gz12384'
    images = scryRenderedDOMComponentsWithClass(selector, 'talk-comment-image-item')
    expect(images.length).toEqual(2)

    Simulate.submit(form)

    filteredImages = scryRenderedDOMComponentsWithClass(selector, 'talk-comment-image-item')
    expect(filteredImages.length).toEqual(1)
    expect(selector.state.images[0].id).toEqual('GZ12384')
