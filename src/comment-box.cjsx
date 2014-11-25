React = require 'react'
CommentPreview = require './comment-preview'
CommentHelp = require './comment-help'
CommentImageSelector = require './comment-image-selector'

module?.exports = React.createClass
  displayName: 'Commentbox'

  getDefaultProps: ->
    focusImage: 'http://placehold.it/200X200'
    submit: "Submit"
    header: "Add to the discussion"
    rows: 8
    cols: 30

  getInitialState: ->
    showing: null # name of child to show

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

  render: ->
    <div className="talk-comment-box">
      <h1>{@props.header}</h1>
      <img src={@props.focusImage} />

      <form className="talk-comment-form" onSubmit={@onSubmitComment}>
        <textarea ref="textarea" rows={@props.rows} cols={@props.cols} />
        <button type="submit">{@props.submit}</button>
      </form>

      <button className='talk-comment-preview-button' onClick={@onPreviewClick}>Preview</button>
      <button className='talk-comment-help-button' onClick={@onHelpClick}>Help</button>
      <button className='talk-comment-image-select-button' onClick={@onImageSelectClick}>Select an Image</button>

      {if @state.showing is 'image-selector'
        <CommentImageSelector />}

      {if @state.showing is 'preview'
        <CommentPreview content={@previewContent()} />}

      {if @state.showing is 'help'
        <CommentHelp />}
    </div>

  toggleComponent: (name) ->
    @setState showing: if @state.showing is name then null else name

  previewContent: ->
    @refs.textarea.getDOMNode().value
