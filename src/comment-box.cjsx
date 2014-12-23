React = require 'react'
ToggleChildren = require './mixins/toggle-children'
Validations  = require './mixins/validations'

CommentPreview = require './comment-preview'
CommentHelp = require './comment-help'
CommentImageSelector = require './comment-image-selector'
{insertAtCursor, getSelection, hrefLink, imageLink, bold, italic} = require './lib/markdown-insert'
MarkdownLink = require './lib/markdown-link'
MarkdownImage = require './lib/markdown-image'

module?.exports = React.createClass
  displayName: 'Commentbox'
  mixins: [ToggleChildren, Validations]

  validations: [
    {
      check: (text) -> text.trim().length is 0
      error: "Comments must have content"
    }
  ]

  propTypes:
    submit: React.PropTypes.string
    header: React.PropTypes.string
    placeholder: React.PropTypes.string
    submitFeedback: React.PropTypes.string
    onSubmitComment: React.PropTypes.func # called on submit and passed (e, textarea-content)

  getDefaultProps: ->
    submit: "Submit"
    header: "Add to the discussion"
    placeholder: "Type your comment here"
    submitFeedback: "Comment Successfully Submitted"

  getInitialState: ->
    focusImage: null
    previewContent: ''
    feedback: null

  onSubmitComment: (e) ->
    e.preventDefault()
    textareaValue = @refs.textarea.getDOMNode().value
    return if @setValidationErrors(textareaValue)

    @props.onSubmitComment?(e, textareaValue, @state.focusImage)
    # optional function called on submit ^
    # TODO: update this submit stuff for better reuse / prod

    @refs.textarea.getDOMNode().value = ""
    @hideChildren()
    @setState previewContent: "", feedback: @props.submitFeedback

  onPreviewClick: (e) ->
    @toggleComponent('preview')

  onHelpClick: (e) ->
    @toggleComponent('help')

  onImageSelectClick: (e) ->
    @toggleComponent('image-selector')

  onInsertLinkClick: (e) ->
    @toggleComponent('markdown-link')

  onInsertImageClick: (e) ->
    @toggleComponent('markdown-image')

  onBoldClick: (e) ->
    textarea = @refs.textarea.getDOMNode()
    selection = getSelection(textarea)

    insertAtCursor(bold(selection), textarea)
    @onInputChange()

  onItalicClick: (e) ->
    textarea = @refs.textarea.getDOMNode()
    selection = getSelection(textarea)

    insertAtCursor(italic(selection), textarea)
    @onInputChange()

  onSelectImage: (image) ->
    @setState focusImage: image.location

  onClearImageClick: (e) ->
    @setState focusImage: null

  onInputChange: ->
    @setState previewContent: @refs.textarea.getDOMNode().value

  render: ->
    validationErrors = @state.validationErrors.map (message, i) =>
      <p key={i} className="talk-validation-error">{message}</p>

    <div className="talk-comment-box">
      <h1>{@props.header}</h1>

      {if @state.feedback
        <p className="talk-feedback">{@state.feedback}</p>}

      <div className="talk-comment-buttons-container">
        <button className='talk-comment-preview-button' onClick={@onPreviewClick}>Preview</button>
        <button className='talk-comment-help-button' onClick={@onHelpClick}>Help</button>
        <button className='talk-comment-image-select-button' onClick={@onImageSelectClick}>Select an Image</button>
        <button className='talk-comment-clear-image-button' onClick={@onClearImageClick}>Clear image</button>
        <button className='talk-comment-insert-link-button' onClick={@onInsertLinkClick}>Insert Link</button>
        <button className='talk-comment-insert-image-button' onClick={@onInsertImageClick}>Insert Image Link</button>
        <button className='talk-comment-bold-button' onClick={@onBoldClick}>Bold</button>
        <button className='talk-comment-italic-button' onClick={@onItalicClick}>Italicize</button>
      </div>

      <img className="talk-comment-focus-image" src={@state.focusImage} />

      <form className="talk-comment-form" onSubmit={@onSubmitComment}>
        <textarea onInput={@onInputChange} ref="textarea" placeholder={@props.placeholder} />
        <button type="submit">{@props.submit}</button>
        {validationErrors}
      </form>

      <div className="talk-comment-children">
        {switch @state.showing
          when 'image-selector'
            <CommentImageSelector onSelectImage={@onSelectImage}/>
          when 'preview'
            <CommentPreview content={@state.previewContent} />
          when 'help'
            <CommentHelp />
          when 'markdown-link'
            <MarkdownLink onCreateLink={@onCreateLink} />
          when 'markdown-image'
            <MarkdownImage onCreateImage={@onCreateImage} />}
      </div>
    </div>

  onCreateLink: (e, url, title) ->
    textarea = @refs.textarea.getDOMNode()
    insertAtCursor(hrefLink(url, title), textarea)
    @onInputChange()

  onCreateImage: (e, alt, title) ->
    textarea = @refs.textarea.getDOMNode()
    insertAtCursor(imageLink(alt, title), textarea)
    @onInputChange()

