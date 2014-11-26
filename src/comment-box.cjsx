React = require 'react'
CommentPreview = require './comment-preview'
CommentHelp = require './comment-help'
CommentImageSelector = require './comment-image-selector'

module?.exports = React.createClass
  displayName: 'Commentbox'

  getDefaultProps: ->
    submit: "Submit"
    header: "Add to the discussion"
    rows: 10
    cols: 100

  getInitialState: ->
    showing: null # name of child to show
    focusImage: 'http://placehold.it/200X200'

  onSubmitComment: (e) ->
    e.preventDefault()
    @refs.textarea.getDOMNode().value = ""
    @setState showing: null

  onPreviewClick: (e) ->
    @toggleComponent('preview')

  onHelpClick: (e) ->
    @toggleComponent('help')

  onImageSelectClick: (e) ->
    @toggleComponent('image-selector')

  onSelectImage: (image) ->
    @setState focusImage: image.location

  render: ->
    <div className="talk-comment-box">
      <h1>{@props.header}</h1>
      <img className="talk-comment-focus-image" src={@state.focusImage} />

      <form className="talk-comment-form" onSubmit={@onSubmitComment}>
        <textarea ref="textarea" rows={@props.rows} cols={@props.cols} />
        <button type="submit">{@props.submit}</button>
      </form>

      <div className="talk-comment-buttons-container">
        <button className='talk-comment-preview-button' onClick={@onPreviewClick}>Preview</button>
        <button className='talk-comment-help-button' onClick={@onHelpClick}>Help</button>
        <button className='talk-comment-image-select-button' onClick={@onImageSelectClick}>Select an Image</button>
      </div>

      <div className="talk-comment-children">
        {if @state.showing is 'image-selector'
          <CommentImageSelector onSelectImage={@onSelectImage}/>}

        {if @state.showing is 'preview'
          <CommentPreview content={@previewContent()} />}

        {if @state.showing is 'help'
          <CommentHelp />}
      </div>
    </div>

  toggleComponent: (name) ->
    @setState showing: if @state.showing is name then null else name

  previewContent: ->
    @refs.textarea.getDOMNode().value
