jest
  .dontMock '../../src/index'

TEST_IMAGES = [
  {title: "test 1", src: "test-image-1.jpg"}
  {title: "test 1", src: "test-image-2.jpg", description: "sadasd"}
  {src: "test-image-3.jpg", description: "sadasd"}
  ]

describe 'ImageCollection', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {ImageCollection} = require '../../src/index'

  ic = renderIntoDocument(<ImageCollection images={TEST_IMAGES} />)

  describe 'initializing', ->
    it 'sets the active page to null', ->
      expect(ic.state.activeImage).toEqual(null)

  describe 'clicking next', ->
    it 'advances the active image', ->
      ic.setState({activeImage: 0})
      ic.onClickNext()
      expect(ic.state.activeImage).toEqual(1)

    it 'stops at the max', ->
      lastImg = TEST_IMAGES.length - 1
      ic.setState(activeImage: lastImg)
      ic.onClickNext()
      expect(ic.state.activeImage).toEqual(lastImg)

  describe 'clicking prev', ->
    it 'decriments the active image', ->
      expect(ic.state.activeImage).toEqual(2)
      ic.onClickPrev()
      expect(ic.state.activeImage).toEqual(1)

    it 'stops at the max', ->
      firstImg = 0
      ic.setState(activeImage: firstImg)
      ic.onClickPrev()
      expect(ic.state.activeImage).toEqual(firstImg)

