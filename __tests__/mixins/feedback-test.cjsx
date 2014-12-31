jest
  .dontMock '../../src/mixins/feedback'

describe 'Feedback', ->
  React = require 'react/addons'
  Feedback = require '../../src/mixins/feedback'
  {renderIntoDocument, Simulate, findRenderedDOMComponentWithTag} = React.addons.TestUtils

  TestComponent = React.createClass
    mixins: [Feedback]

    render: ->
      feedback = @renderFeedback()
      <div>
        {feedback}
        Test Component
      </div>

  describe '#getInitialState', ->
    it 'adds a "feedback" state to the owner component that defaults to null', ->
      testInit = renderIntoDocument(<TestComponent />)
      expect(testInit.state).toEqual(feedback: null)

  describe '#setFeedback', ->
    test = renderIntoDocument(<TestComponent />)
    test.setFeedback("test feedback")

    it 'sets state.feedback to the text argument', ->
      expect(test.state.feedback).toEqual("test feedback")

    it 'adds a removeFeedback listener on click', ->
      test = renderIntoDocument(<TestComponent />)
      spyOn(window, 'addEventListener')
      test.setFeedback "test feedback"

      expect(window.addEventListener).toHaveBeenCalled()
      expect(window.addEventListener).toHaveBeenCalledWith('click', Feedback.removeFeedback)

  describe '#removeFeedback', ->
    test = renderIntoDocument(<TestComponent />)
    test.setState feedback: "test feedback"

    it 'removes a feedback state by setting to null', ->
      test.removeFeedback()
      expect(test.state.feedback).toEqual(null)

    it 'removes a removeFeedback listener on click', ->
      test = renderIntoDocument(<TestComponent />)
      spyOn(window, 'removeEventListener')
      test.removeFeedback "test feedback"

      expect(window.removeEventListener).toHaveBeenCalled()
      expect(window.removeEventListener).toHaveBeenCalledWith('click', Feedback.removeFeedback)
