React = require 'react'
ToggleChildren = require './mixins/toggle-children'
Validations  = require './mixins/validations'

CommentPreview = require './comment-preview'
CommentHelp = require './comment-help'
CommentImageSelector = require './comment-image-selector'

module?.exports = React.createClass
  displayName: 'Commentbox'
  mixins: [ToggleChildren, Validations]

  validations: [
    {
      check: (text) -> text.trim().length is 0
      error: "Comments must have content"
    }
  ]

  getDefaultProps: ->
    submit: "Submit"
    header: "Add to the discussion"
    rows: 10
    cols: 100

  getInitialState: ->
    focusImage: 'http://placehold.it/200X200'

  onSubmitComment: (e) ->
    e.preventDefault()
    return if @setValidationErrors(@refs.textarea.getDOMNode().value)
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
    validationErrors = @state.validationErrors.map (message, i) =>
      <p key={i}>{message}</p>

    <div className="talk-comment-box">
      <h1>{@props.header}</h1>
      <img className="talk-comment-focus-image" src={@state.focusImage} />

      <form className="talk-comment-form" onSubmit={@onSubmitComment}>
        <textarea ref="textarea" rows={@props.rows} cols={@props.cols} />
        <button type="submit">{@props.submit}</button>
        {validationErrors}
      </form>

      <div className="talk-comment-buttons-container">
        <button className='talk-comment-preview-button' onClick={@onPreviewClick}>Preview</button>
        <button className='talk-comment-help-button' onClick={@onHelpClick}>Help</button>
        <button className='talk-comment-image-select-button' onClick={@onImageSelectClick}>Select an Image</button>
      </div>

      <div className="talk-comment-children">
        {switch @state.showing
          when 'image-selector'
            <CommentImageSelector onSelectImage={@onSelectImage}/>
          when 'preview'
            <CommentPreview content={@previewContent()} />
          when 'help'
            <CommentHelp />}
      </div>
    </div>

  previewContent: ->
    @refs.textarea.getDOMNode().value
