jest
  .dontMock '../src/index'

TEST_COLLS = [
  {
    id: 123
    name: "Sample Collection"
    member: false
  }
  {
    id: 456
    name: "Example Collection"
    member: true
  }
]

describe 'SubjectCollections', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedDOMComponentsWithTag, scryRenderedComponentsWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {SubjectCollections} = require '../src/index'

  subjectColls = renderIntoDocument(<SubjectCollections />)
  form = findRenderedDOMComponentWithClass(subjectColls, "talk-subject-collections-form")
  inputs = scryRenderedDOMComponentsWithTag(form, 'input')

  describe '#getSelectedInputValues', ->
    it 'returns value attributes the inputs that are selected', ->
      subjectColls.setState collections: TEST_COLLS
      Simulate.submit(form)
      expect(subjectColls.getSelectedInputValues()).toEqual(['456'])

