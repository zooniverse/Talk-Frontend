React = require 'react'
ToggleChildren = require './mixins/toggle-children'
Validations  = require './mixins/validations'
CommentBox = require './comment-box'

module?.exports = React.createClass
  displayName: 'DiscussionCreate'
  mixins: [Validations]

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

  onSubmitDiscussion: (e, commentText, focusImage) ->
    e.preventDefault()
    discussionTitle = @refs.title.getDOMNode().value
    # send to server: commentText, focusImage, discussionTitle

    @refs.title.getDOMNode().value = ""
    @setState feedback: "Discussion Successfully Created"

  validationErrors: ->
    @setValidationErrors(@refs.title.getDOMNode().value)

  render: ->
    validationErrors = @state.validationErrors.map (message, i) =>
      <p key={i} className="talk-validation-error">{message}</p>

    <div className="talk-discussion-create">
      <h1>{@props.header}</h1>

      {if @state.feedback
        <p className="talk-feedback">{@state.feedback}</p>}

      <form className="talk-discussion-form" onSubmit={@onSubmitDiscussion}>
        <input ref="title" placeholder="Discussion Title" />
      </form>

      <CommentBox
        header={null}
        onSubmitComment={@onSubmitDiscussion}
        parentValidationErrors={@validationErrors}
        submitFeedback={null}
        placeholder={@props.commentPlaceholder} />
      {validationErrors}
    </div>

  previewContent: ->
    @refs.textarea.getDOMNode().value

  insertLink: ->
    insertAtCursor(hrefLink(), @refs.textarea.getDOMNode())

  insertImageLink: ->
    insertAtCursor(imageLink(), @refs.textarea.getDOMNode())
