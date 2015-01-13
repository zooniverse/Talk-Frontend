React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkImageViewer'

  imageView: (imageData) ->
    <div className="talk-image-viewer-image-view">
      <div className="talk-image-viewer-image-heading" ref="imageHeading">
        <h1>{imageData.title if imageData.title}</h1>
      </div>

      {<img src={imageData.src} /> if imageData.src}

      <div className="talk-image-viewer-image-footer" ref="imageFooter">
        {<p>{imageData.description}</p> if imageData.description}
        <p>{@props.activeImage + 1} / {@props.images.length}</p>
      </div>
    </div>

  render: ->
    image = @imageView @props.images[@props.activeImage]

    <div className="talk-image-viewer">
      <button
        className="talk-image-viewer-prev"
        type="button"
        disabled={@props.viewingFirstImage()}
        onClick={@props.onClickPrev}>
        {@props.prevIcon ? '<'}
      </button>

      {image}

      <button
        className="talk-image-viewer-next"
        type="button"
        disabled={@props.viewingLastImage()}
        onClick={@props.onClickNext}>
        {@props.nextIcon ? '>'}
      </button>

      <button
        className="talk-image-viewer-close"
        type="button"
        onClick={@props.onClickClose}>
        {@props.closeIcon ? 'X'}
      </button>
    </div>
