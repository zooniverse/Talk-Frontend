jest
  .dontMock '../../src/index'

TEST_IMAGES = [
  {title: "test 1", src: "test-image-1.jpg"}
  {title: "test 1", src: "test-image-2.jpg", description: "sadasd"}
  {src: "test-image-3.jpg", description: "sadasd"}
  ]

describe 'ImageViewer', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {ImageViewer} = require '../../src/index'
   
  iv = renderIntoDocument(<ImageViewer images={TEST_IMAGES} />)

  describe 'initializing', ->
    it 'sets the active page to 0', ->
      expect(iv.state.activeImage).toEqual(0)

  describe 'clicking next', ->
    nextBtn = findRenderedDOMComponentWithClass(iv, 'talk-image-viewer-next')

    it 'advances the active image', ->
      Simulate.click(nextBtn)
      expect(iv.state.activeImage).toEqual(1)

    it 'stops at the max', ->
      lastImg = TEST_IMAGES.length - 1
      iv.setState(activeImage: lastImg)
      Simulate.click(nextBtn)
      expect(iv.state.activeImage).toEqual(lastImg)

  describe 'clicking prev', ->
    prevBtn = findRenderedDOMComponentWithClass(iv, 'talk-image-viewer-prev')

    it 'decriments the active image', ->
      expect(iv.state.activeImage).toEqual(2)
      Simulate.click(prevBtn)
      expect(iv.state.activeImage).toEqual(1)

    it 'stops at the max', ->
      firstImg = 0
      iv.setState(activeImage: firstImg)
      Simulate.click(prevBtn)
      expect(iv.state.activeImage).toEqual(firstImg)

