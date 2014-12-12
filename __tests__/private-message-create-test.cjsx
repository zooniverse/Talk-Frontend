jest
  .dontMock '../src/index'

describe 'PrivateMessageCreate', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {PrivateMessageCreate} = require '../src/index'

  #privateMessageCreate = renderIntoDocument(<PrivateMessageCreate />)

  xit 'add tests here', ->
