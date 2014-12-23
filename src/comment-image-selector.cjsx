React = require 'react'

DEV_IMAGES = [
  {
    id: "GZ12384"
    location: "http://placehold.it/200X200&text=GZ12384"
  },
  {
    id: "GZ21414"
    location: "http://placehold.it/200X200&text=GZ21414"
  },
  {
    id: "GZ21444"
    location: "http://placehold.it/200X200&text=GZ21444"
  }
]

module?.exports = React.createClass
  displayName: 'TalkCommentImageSelector'

  getInitialState: ->
    images: []

  getDefaultProps: ->
    header: "Select a focus image"

  componentWillMount: ->
    @setInitialImages()

  setInitialImages: ->
    # fake query for suggested images
    setTimeout (=>
      @setState images: DEV_IMAGES
    ), 500

  queryForImages: (query) ->
    # this will make a db query and then return array of matching images
    DEV_IMAGES.filter (img) => img.id.toLowerCase() is query.toLowerCase()

  onSubmitSearch: (e) ->
    e.preventDefault()
    query = @refs.imageSearch.getDOMNode().value
    if query is ""
      @setInitialImages()
    else
      @setState images: @queryForImages(query)

  imageItem: (image, i) ->
    <div key={i} className="talk-comment-image-item">
      <img src={image.location} />
      <button onClick={=> @props.onSelectImage(image)}>Select</button>
    </div>

  render: ->
    <div className="talk-comment-image-selector">
      <h1>{@props.header}</h1>

      <form onSubmit={@onSubmitSearch}>
        <input ref="imageSearch" type="search" placeholder="Search by ID"/>
      </form>

      <div className="talk-comment-suggested-images">
        {@state.images.map(@imageItem)}
      </div>
    </div>
