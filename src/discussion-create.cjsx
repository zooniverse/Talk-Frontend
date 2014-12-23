React = require 'react'
ToggleChildren = require './mixins/toggle-children'
Validations  = require './mixins/validations'
CommentBox = require './comment-box'

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
    commentPlaceholder: "Start the discussion with a comment"

  onSubmitDiscussion: (e) ->
    e.preventDefault()
    return if @setValidationErrors(@refs.title.getDOMNode().value)

    # title & focus-image will be the discussion itself
    # textarea value will be top discussion comment

    @refs.title.getDOMNode().value = ""
    @refs.textarea.getDOMNode().value = ""

    @hideChildren()
    @setState feedback: "Discussion Successfully Created"

  render: ->
    validationErrors = @state.validationErrors.map (message, i) =>
      <p key={i} className="talk-validation-error">{message}</p>

    <div className="talk-discussion-create">
      <h1>{@props.header}</h1>

      {if @state.feedback
        <p className="talk-feedback">{@state.feedback}</p>}


      <form className="talk-discussion-form" onSubmit={@onSubmitDiscussion}>
        <input ref="title" placeholder="Discussion Title" />

        {validationErrors}
      </form>

      <CommentBox header={null} placeholder={@props.commentPlaceholder} />
    </div>

  previewContent: ->
    @refs.textarea.getDOMNode().value

  insertLink: ->
    insertAtCursor(hrefLink(), @refs.textarea.getDOMNode())

  insertImageLink: ->
    insertAtCursor(imageLink(), @refs.textarea.getDOMNode())
