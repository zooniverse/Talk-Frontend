jest
  .dontMock '../../src/lib/time'

{timeStamp} = require '../../src/lib/time'

describe 'time', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils

  describe '#timeStamp', ->
    testTime = '2014-12-09T17:10:32.895Z'

    it 'returns a string', ->
      expect(typeof timeStamp(testTime)).toEqual('string')
      
    it 'formats the time', ->
      expect(timeStamp(testTime)).toEqual('December 9th 2014, 11:10 am')
