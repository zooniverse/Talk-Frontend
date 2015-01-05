React = require 'react'
ToggleChildren = require './mixins/toggle-children'
Validations  = require './mixins/validations'
Feedback = require './mixins/feedback'

CommentPreview = require './comment-preview'
CommentHelp = require './comment-help'
CommentImageSelector = require './comment-image-selector'
{horizontalRule, insertAtCursor, getSelection, heading, hrefLink, imageLink, quote, bold, italic} = require './lib/markdown-insert'

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
    @wrapSelectionIn(hrefLink)

  onInsertImageClick: (e) ->
    @wrapSelectionIn(imageLink)

  onBoldClick: (e) ->
    @wrapSelectionIn(bold)

  onItalicClick: (e) ->
    @wrapSelectionIn(italic)

  onHeadingClick: (e) ->
    @wrapSelectionIn(heading)

  onQuoteClick: ->
    @wrapSelectionIn(quote)

  onHorizontalRuleClick: (e) ->
    @wrapSelectionIn(horizontalRule)

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
        <button className='talk-comment-image-select-button' onClick={@onImageSelectClick}>Featured Image</button>
        <button className='talk-comment-insert-link-button' onClick={@onInsertLinkClick}>Insert Link</button>
        <button className='talk-comment-insert-image-button' onClick={@onInsertImageClick}>Insert Image</button>
        <button className='talk-comment-bold-button' onClick={@onBoldClick}>Bold</button>
        <button className='talk-comment-italic-button' onClick={@onItalicClick}>Italicize</button>
        <button className='talk-comment-insert-quote-button' onClick={@onQuoteClick}>Quote</button>
        <button className='talk-comment-heading-button' onClick={@onHeadingClick}>Heading</button>
        <button className='talk-comment-hr-button' onClick={@onHorizontalRuleClick}>Horizontal Rule</button>
      </div>

      <img className="talk-comment-focus-image" src={@state.focusImage} />

      <form className="talk-comment-form" onSubmit={@onSubmitComment}>
        <textarea value={@state.content} onChange={@onInputChange} ref="textarea" placeholder={@props.placeholder} />
        <section>
          <button type="button" className='talk-comment-preview-button' onClick={@onPreviewClick}>Preview</button>
          <button type="button" className='talk-comment-help-button' onClick={@onHelpClick}>Help</button>

          <button type="submit">{@props.submit}</button>
        </section>
        {validationErrors}
      </form>

      <div className="talk-comment-children">
        {switch @state.showing
          when 'image-selector'
            <CommentImageSelector
              onSelectImage={@onSelectImage}
              onClearImageClick= {@onClearImageClick}/>
          when 'preview'
            <CommentPreview content={@state.content} />
          when 'help'
            <CommentHelp />}
      </div>
    </div>

  wrapSelectionIn: (wrapFn) ->
    # helper to call markdown-insert functions on the textarea
    # wrapFn takes / returns a string (from ./lib/markdown-insert.cjsx)

    textarea = @refs.textarea.getDOMNode()
    selection = getSelection(textarea)
    {text, cursor} = wrapFn(selection)

    insertAtCursor(text, textarea, cursor)
    @onInputChange()

