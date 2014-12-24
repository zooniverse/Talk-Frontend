jest
  .dontMock '../../src/mixins/toggle-children'

TEST_VALIDATIONS = [
    {
      check: (text) -> text.trim().length is 0
      error: "Comments must have content"
    }
  ]


describe 'Validations', ->
  React = require 'react/addons'
  Validations = require '../../src/mixins/validations'
  {renderIntoDocument, Simulate} = React.addons.TestUtils

  TestComponent = React.createClass
    mixins: [Validations]
    validations: TEST_VALIDATIONS
    render: -> <div>Test Component</div>

  testComponent = renderIntoDocument(<TestComponent />)

  describe '#getInitialState', ->
    testComponent = renderIntoDocument(<TestComponent />)
    it 'adds a "validationErrors" state to the owner component that defaults to an empty array', ->
    expect(testComponent.state).toEqual(validationErrors: [])

  describe '#getValidationErrors', ->
    describe 'when passed a test string to test against a validations array of objects with "check" and "error" keys', ->
      it 'returns an array of validation errors', ->
        errors = testComponent.getValidationErrors("")
        expect(errors).toEqual([TEST_VALIDATIONS[0].error])

  describe '#setValidationErrors', ->
    testComponent = renderIntoDocument(<TestComponent />)
    setErrors = testComponent.setValidationErrors("")

    it 'sets state key "validationErrors" to an array of errors', ->
      expect(testComponent.state.validationErrors).toEqual([TEST_VALIDATIONS[0].error])

    it 'returns truthy if there are errors', ->
      expect(setErrors).toBeTruthy()

    it 'returns falsy if there are no errors errors', ->
      setValidErrors = testComponent.setValidationErrors("A valid test comment")
      expect(setValidErrors).toBeFalsy()

  describe '#clearValidationErrors', ->
    componentToClear = renderIntoDocument(<TestComponent />)

    it 'sets state.validationErrors to []', ->
      componentToClear.setValidationErrors("") # has 1 validation error
      componentToClear.clearValidationErrors()
      expect(componentToClear.state.validationErrors).toEqual([])

