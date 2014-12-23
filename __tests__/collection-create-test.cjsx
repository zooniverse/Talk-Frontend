jest
  .dontMock '../src/index'

describe 'CollectionCreate', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {CollectionCreate} = require '../src/index'

  collectionCreate = renderIntoDocument(<CollectionCreate />)
  form = findRenderedDOMComponentWithClass(collectionCreate, 'talk-collection-create-form')
  input = findRenderedDOMComponentWithTag(form, 'input')
  submit = findRenderedDOMComponentWithTag(form, 'button')

  describe 'on submit', ->
    it 'sends feedback on success', ->
      input.getDOMNode().value = "test comment"
      Simulate.submit(form)
      expect(collectionCreate.state.feedback).toBeTruthy()
      
    it 'sends failed validation if no length', ->
      input.getDOMNode().value = ""
      Simulate.submit(form)
      expect(!!~collectionCreate.state.validationErrors[0].indexOf('must have content')).toBeTruthy()
