React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkImageViewer'

  getInitialState: ->
    activeImage: 0

  imageView: (imageData) ->
    <div className="talk-image-viewer-image-view">
      {<h1>{imageData.title if imageData.title}</h1>}
      {<img src={imageData.src} /> if imageData.src}
      {<p>{imageData.description}</p> if imageData.description}
    </div>

  render: ->
    image = @imageView @props.images[@state.activeImage]

    <div className="talk-image-viewer">
      <button
        className="talk-image-viewer-prev"
        type="button"
        disabled={@viewingFirstImage()}
        onClick={@onClickPrev}>
        {@props.prevIcon ? '<'}
      </button>

      {image}

      <button
        className="talk-image-viewer-next"
        type="button"
        disabled={@viewingLastImage()}
        onClick={@onClickNext}>
        {@props.nextIcon ? '>'}
      </button>

      <button
        className="talk-image-viewer-close"
        type="button"
        onClick={@props.onClickClose}>
        {@props.closeIcon ? 'X'}
      </button>

      <p className="talk-image-viewer-active-num">{@state.activeImage + 1} / {@props.images.length}</p>
    </div>

  onClickNext: ->
    @setState({activeImage: @state.activeImage + 1}) unless @viewingLastImage()

  onClickPrev: ->
    @setState({activeImage: @state.activeImage - 1}) unless @viewingFirstImage()

  viewingFirstImage: ->
    @state.activeImage <= 0

  viewingLastImage: ->
    @state.activeImage + 1 >= @props.images.length
