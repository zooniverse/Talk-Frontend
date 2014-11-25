React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkCommentImageSelector'

  componentWillMount: ->
    # query suggested images here...

  onSubmitSearch: (e) ->
    e.preventDefault()
    query = @refs.imageSearch.getDOMNode().value
    console.log "image-search for", query

  render: ->
    <div className="talk-comment-image-selector">
      <h1>Select an image focus for this comment</h1>

      <form onSubmit={@onSubmitSearch}>
        <input ref="imageSearch" type="search" />
      </form>

      <div className="talk-comment-suggested-images">
        <img src="http://placehold.it/200X200" />
        <img src="http://placehold.it/200X200" />
        <img src="http://placehold.it/200X200" />
        <img src="http://placehold.it/200X200" />
        <img src="http://placehold.it/200X200" />
      </div>
    </div>
