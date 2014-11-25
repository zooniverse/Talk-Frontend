jest
  .dontMock '../src/index'

indexOf = (elem) ->
  (elem while elem = elem.previousSibling).length

describe 'Paginate', ->
  React = require 'react/addons'
  {findRenderedDOMComponentWithTag, scryRenderedComponentsWithType, scryRenderedDOMComponentsWithClass, findRenderedComponentWithType, findRenderedDOMComponentWithClass, renderIntoDocument, Simulate} = React.addons.TestUtils
  {Paginate} = require '../src/index'
   
  describe 'page count', ->
    it 'has the correct number of pages for evenly divisible nums', ->
      paginator = renderIntoDocument(<Paginate onPageChange={(data) => return data} perPage={3} collLength={9} />)
      expect(paginator.pageCount()).toEqual(3)

    it 'rounds down the page count for non evenly divisble nums', ->
      paginator = renderIntoDocument(<Paginate onPageChange={(data) => return data} perPage={4} collLength={13} />)
      expect(paginator.pageCount()).toEqual(3)

  describe 'changing pages', ->
    paginatorCallback = (data) -> data

    paginator = renderIntoDocument(<Paginate onPageChange={paginatorCallback} perPage={3} collLength={9} />)
    nextBtn = findRenderedDOMComponentWithClass(paginator, 'talk-paginate-next-btn')
    prevBtn = findRenderedDOMComponentWithClass(paginator, 'talk-paginate-prev-btn')

    it 'defaults to page 1', ->
      expect(paginator.state.activePage).toEqual(1)

    it 'increments the active page when next page is clicked', ->
      expect(paginator.state.activePage).toEqual(1)
      Simulate.click(nextBtn)
      expect(paginator.state.activePage).toEqual(2)

    it 'decriments the active page when prev page is clicked', ->
      expect(paginator.state.activePage).toEqual(2)
      Simulate.click(prevBtn)
      expect(paginator.state.activePage).toEqual(1)

    it 'stops at the smallest page', ->
      expect(paginator.state.activePage).toEqual(1)
      Simulate.click(prevBtn)
      expect(paginator.state.activePage).toEqual(1)

    it 'stops at the largest page', ->
      pageCount = paginator.pageCount()
      paginator.setState activePage: pageCount

      expect(paginator.state.activePage).toEqual(3)
      Simulate.click(nextBtn)
      expect(paginator.state.activePage).toEqual(3)

    it 'adds an active class to the button with the active page', ->
      paginator.setState activePage: 2
      activeBtn = findRenderedDOMComponentWithClass(paginator, 'active')
      expect(indexOf(activeBtn.getDOMNode())).toEqual(2)

    it 'fires a callback #onPageChange that returns the active page and array of collection indexes to show', ->
      spyOn(paginator.props, 'onPageChange')
      Simulate.click(nextBtn)

      expect(paginator.props.onPageChange).toHaveBeenCalled()
      expect(paginator.props.onPageChange).toHaveBeenCalledWith({page: 3, range: [6,7,8]})
