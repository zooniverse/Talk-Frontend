React = require 'react'
ImageViewer = require './image-viewer'

module?.exports = React.createClass
  displayName: 'TalkImageCollection'

  getInitialState: ->
    activeImage: null

  activateImage: (i) ->
    @setState activeImage: i

  image: (image, i) ->
    <div key={i} className="talk-image-collection-image">
      <img onClick={=> @activateImage(i)} src={image.src} />
    </div>

  render: ->
    images = @props.images.map(@image)

    <div className="talk-image-collection">
      <div className="talk-image-collection-images">
        {images}
      </div>

      {if @state.activeImage isnt null
        <ImageViewer
          activeImage={@state.activeImage}
          images={@props.images}
          onClickClose={@onClickCloseImageViewer}
          onClickNext={@onClickNext}
          onClickPrev={@onClickPrev}
          viewingLastImage={@viewingLastImage}
          viewingFirstImage={@viewingFirstImage}/>}
    </div>

  onClickNext: ->
    @setState({activeImage: @state.activeImage + 1}) unless @viewingLastImage()

  onClickPrev: ->
    @setState({activeImage: @state.activeImage - 1}) unless @viewingFirstImage()

  onClickCloseImageViewer: ->
    @setState activeImage: null

  viewingFirstImage: ->
    @state.activeImage <= 0

  viewingLastImage: ->
    @state.activeImage + 1 >= @props.images.length

