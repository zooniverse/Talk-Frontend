React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkPaginate'

  propTypes:
    onPageChange: React.PropTypes.func # Triggered on page changes and passes {page: number, range: array}
    perPage: React.PropTypes.number    # Number of items to display per page
    collLength: React.PropTypes.number # length of collection to paginate

  getInitialState: ->
    activePage: 1

  displayItems: (n) ->
    # range of items to display as indexes
    firstItem = (n - 1) * @props.perPage
    lastItem = Math.min (firstItem + @props.perPage), @props.collLength
    [firstItem...lastItem]

  pageCount: ->
    Math.ceil(@props.collLength / @props.perPage)

  nextPage: ->
    pageCount = @pageCount()
    nextPage = if @state.activePage is pageCount then pageCount else @state.activePage + 1
    @setState activePage: nextPage
    nextPage

  prevPage: ->
    prevPage = if @state.activePage is 1 then @state.activePage else @state.activePage - 1
    @setState activePage: prevPage
    prevPage

  onPageClick: (pageClicked) ->
    page = switch pageClicked
      when 'next' then @nextPage()
      when 'prev' then @prevPage()
      else
        @setState activePage: +pageClicked
        +pageClicked

    @props.onPageChange({page: page, range: @displayItems(page)})

    return

  pageNum: (n, i) ->
    <button key={i} onClick={=> @onPageClick(n)} className={if n is @state.activePage then "active" else ""}>
      {n}
    </button>

  render: ->
    pageNums = [1..@pageCount()].map(@pageNum)

    <div className="talk-paginate">
      <button className="talk-paginate-prev-btn" onClick={=> @onPageClick('prev')}>Prev</button>
      {pageNums}
      <button className="talk-paginate-next-btn" onClick={=> @onPageClick('next')}>Next</button>
    </div>
