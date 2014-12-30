React = require 'react'
Validations = require './mixins/validations'

module?.exports = React.createClass
  displayName: 'TalkCommentReportForm'

  mixins: [Validations]

  validations: [
    {
      check: (text) -> text.trim().length is 0
      error: "Comment Reports must have content"
    }
  ]

  onSubmit: (e) ->
    e.preventDefault()
    comment = @refs.textarea.getDOMNode().value
    return if @setValidationErrors(comment)

    @refs.textarea.getDOMNode().value = ''
    @setState feedback: "Comment Report successfully submitted"
    # send comment id and report to server here

  render: ->
    validationErrors = @state.validationErrors.map (message, i) =>
      <p key={i} className="talk-validation-error">{message}</p>

    <div className="talk-comment-report-form">
      <h1>Report a comment here</h1>

      {validationErrors}

      {if @state.feedback
        <p className="talk-feedback">{@state.feedback}</p>}

      <form className="talk-comment-report-form-form" onSubmit={@onSubmit}>
        <textarea ref="textarea" placeholder="Why are you reporting this comment?"></textarea>
        <button type="submit">Report</button>
      </form>
    </div>
