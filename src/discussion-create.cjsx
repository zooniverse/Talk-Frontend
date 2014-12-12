React = require 'react'
ToggleChildren = require './mixins/toggle-children'
Validations  = require './mixins/validations'

CommentPreview = require './comment-preview'
CommentHelp = require './comment-help'
CommentImageSelector = require './comment-image-selector'
{insertAtCursor, hrefLink, imageLink} = require './lib/markdown-insert'

module?.exports = React.createClass
  displayName: 'DiscussionCreate'
  mixins: [ToggleChildren, Validations]

  validations: [
    {
      check: (text) -> text.trim().length is 0
      error: "Discussion must have a title"
    }
  ]

  propTypes:
    submit: React.PropTypes.string
    header: React.PropTypes.string

  getDefaultProps: ->
    submit: "Submit"
    header: "Create a discussion"

  getInitialState: ->
    focusImage: null
    previewContent: ''
    feedback: null

  onSubmitDiscussion: (e) ->
    e.preventDefault()
    return if @setValidationErrors(@refs.title.getDOMNode().value)

    # title & focus-image will be the discussion itself
    # textarea value will be top discussion comment

    @refs.title.getDOMNode().value = ""
    @refs.textarea.getDOMNode().value = ""

    @hideChildren()
    @setState {previewContent: "", feedback: "Discussion Successfully Created"}

  onPreviewClick: (e) ->
    @toggleComponent('preview')

  onHelpClick: (e) ->
    @toggleComponent('help')

  onImageSelectClick: (e) ->
    @toggleComponent('image-selector')

  onSelectImage: (image) ->
    @setState focusImage: image.location

  onClearImageClick: (e) ->
    @setState focusImage: null

  onInputChange: ->
    @setState previewContent: @previewContent()

  render: ->
    validationErrors = @state.validationErrors.map (message, i) =>
      <p key={i} className="talk-validation-error">{message}</p>

    <div className="talk-discussion-create">
      <h1>{@props.header}</h1>

      {if @state.feedback
        <p className="talk-feedback">{@state.feedback}</p>}

      <img className="talk-discussion-focus-image" src={@state.focusImage} />

      <form className="talk-discussion-form" onSubmit={@onSubmitDiscussion}>
        <input ref="title" placeholder="Discussion Title" />
        <textarea onInput={@onInputChange} ref="textarea" placeholder="Discussion Body [Optional]" />
        <button type="submit">{@props.submit}</button>
        {validationErrors}
      </form>

      <div className="talk-discussion-buttons-container">
        <button className='talk-discussion-preview-button' onClick={@onPreviewClick}>Preview</button>
        <button className='talk-discussion-help-button' onClick={@onHelpClick}>Help</button>
        <button className='talk-discussion-image-select-button' onClick={@onImageSelectClick}>Select an Image</button>
        <button className='talk-discussion-clear-image-button' onClick={@onClearImageClick}>Clear image</button>
        <button onClick={@insertLink}>Insert Link</button>
        <button onClick={@insertImageLink}>Insert Image Link</button>
      </div>

      <div className="talk-discussion-children">
        {switch @state.showing
          when 'image-selector'
            <CommentImageSelector onSelectImage={@onSelectImage}/>
          when 'preview'
            <CommentPreview content={@state.previewContent} />
          when 'help'
            <CommentHelp />}
      </div>
    </div>

  previewContent: ->
    @refs.textarea.getDOMNode().value

  insertLink: ->
    insertAtCursor(hrefLink(), @refs.textarea.getDOMNode())

  insertImageLink: ->
    insertAtCursor(imageLink(), @refs.textarea.getDOMNode())
