React = require 'react'
ToggleChildren = require './mixins/toggle-children'
Validations  = require './mixins/validations'
Feedback = require './mixins/feedback'

CommentPreview = require './comment-preview'
CommentHelp = require './comment-help'
CommentImageSelector = require './comment-image-selector'
{insertAtCursor, getSelection, hrefLink, imageLink, bold, italic} = require './lib/markdown-insert'
MarkdownLink = require './lib/markdown-link'
MarkdownImage = require './lib/markdown-image'

module?.exports = React.createClass
  displayName: 'Commentbox'
  mixins: [ToggleChildren, Validations, Feedback]

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
    onSubmitComment: React.PropTypes.func # called on submit and passed (e, textarea-content, focusImage)
    parentValidationErrors: React.PropTypes.func # runs on submit, should return a bool if should continue to run onSubmitComment

  getDefaultProps: ->
    submit: "Submit"
    header: "Add to the discussion"
    placeholder: "Type your comment here"
    submitFeedback: "Comment Successfully Submitted"
    content: null
    focusImage: null

  getInitialState: ->
    focusImage: @props.focusImage
    content: @props.content

  onSubmitComment: (e) ->
    e.preventDefault()
    textareaValue = @refs.textarea.getDOMNode().value
    return if @setValidationErrors(textareaValue) or @props.parentValidationErrors?()

    @props.onSubmitComment?(e, textareaValue, @state.focusImage)
    # optional function called on submit ^
    # TODO: update this submit stuff for better reuse / prod

    @refs.textarea.getDOMNode().value = ""
    @hideChildren()
    @setState content: ""
    @setFeedback @props.submitFeedback

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
    {text, cursor} = bold(selection)

    insertAtCursor(text, textarea, cursor)
    @onInputChange()

  onItalicClick: (e) ->
    textarea = @refs.textarea.getDOMNode()
    selection = getSelection(textarea)
    {text, cursor} = italic(selection)

    insertAtCursor(text, textarea, cursor)
    @onInputChange()

  onSelectImage: (image) ->
    @setState focusImage: image.location

  onClearImageClick: (e) ->
    @setState focusImage: null

  onInputChange: ->
    @setState content: @refs.textarea.getDOMNode().value

  render: ->
    validationErrors = @renderValidations()
    feedback = @renderFeedback()

    <div className="talk-comment-box">
      <h1>{@props.header}</h1>

      {feedback}

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
        <textarea value={@state.content} onChange={@onInputChange} ref="textarea" placeholder={@props.placeholder} />
        <button type="submit">{@props.submit}</button>
        {validationErrors}
      </form>

      <div className="talk-comment-children">
        {switch @state.showing
          when 'image-selector'
            <CommentImageSelector onSelectImage={@onSelectImage}/>
          when 'preview'
            <CommentPreview content={@state.content} />
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
    {text, cursor} = hrefLink(url, title)

    insertAtCursor(text, textarea, cursor)
    @onInputChange()

  onCreateImage: (e, alt, title) ->
    textarea = @refs.textarea.getDOMNode()
    {text, cursor} = imageLink(alt, title)

    insertAtCursor(text, textarea, cursor)
    @onInputChange()
