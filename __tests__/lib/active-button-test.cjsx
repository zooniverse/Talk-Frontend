jest
  .dontMock '../../src/index'

describe 'ActiveButton', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {ActiveButton} = require '../../src/index'

  describe 'initializing', ->
    it 'sets the initial "active" state to an optional active prop', ->
      activeButton = renderIntoDocument(<ActiveButton active={true} />)
      expect(activeButton.state.active).toEqual(true)

    it 'defaults the active state to false if no active prop is passed', ->
      activeButton = renderIntoDocument(<ActiveButton />)
      expect(activeButton.state.active).toEqual(false)

  describe 'toggling active state', ->
    activeButton = renderIntoDocument(<ActiveButton />)
    domBtn = findRenderedDOMComponentWithTag(activeButton, 'button')

    it 'toggles an active state on click', ->
      expect(activeButton.state.active).toEqual(false)
      Simulate.click(domBtn)
      expect(activeButton.state.active).toEqual(true)
      Simulate.click(domBtn)
      expect(activeButton.state.active).toEqual(false)

  describe 'css "active" class', ->
    activeButton = renderIntoDocument(<ActiveButton active={true} />)

    it 'adds an "active" class when the state is "active"', ->
      activeClassElems = scryRenderedDOMComponentsWithClass(activeButton, 'active')
      expect(activeClassElems.length).toEqual(1)

    it 'removes an "active" class when the state is not "active"', ->
      activeButton.setState active: false
      activeClassElems =  scryRenderedDOMComponentsWithClass(activeButton, 'active')
      expect(activeClassElems.length).toEqual(0)

  describe 'onClick callback', ->
    it 'fires a normal onClick callback when clicked', ->
      onClickActiveButton = (e) -> return
      activeButton = renderIntoDocument(<ActiveButton onClick={onClickActiveButton} />)
      domBtn = findRenderedDOMComponentWithTag(activeButton, 'button')

      spyOn(activeButton.props, 'onClick')
      Simulate.click(domBtn)
      expect(activeButton.props.onClick).toHaveBeenCalled()
