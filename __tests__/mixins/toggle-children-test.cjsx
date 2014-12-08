jest
  .dontMock '../../src/mixins/toggle-children'

describe 'ToggleChildren', ->
  React = require 'react/addons'
  ToggleChildren = require '../../src/mixins/toggle-children'
  {renderIntoDocument, Simulate} = React.addons.TestUtils

  TestComponent = React.createClass
    mixins: [ToggleChildren]
    render: -> <div>Test Component</div>

  testComponent = renderIntoDocument(<TestComponent />)

  describe '#getInitialState', ->
    it 'adds a "showing" state to the owner component that defaults to null', ->
      expect(testComponent.state).toEqual(showing: null)

  describe '#toggleComponent', ->
    it 'sets the showing state to the component name if it is not already that', ->
      testComponent.toggleComponent('component-name')
      expect(testComponent.state.showing).toEqual('component-name')

    it 'sets showing state to null if the passed arg is already showing', ->
      testComponent.toggleComponent('component-name')
      expect(testComponent.state.showing).toEqual(null)

  describe '#hideChildren', ->
    it 'sets showing state to null', ->
      testComponent.setState showing: 'test'
      testComponent.hideChildren()
      expect(testComponent.state.showing).toEqual(null)
