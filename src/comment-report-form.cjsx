React = require 'react'
Validations = require './mixins/validations'
Feedback = require './mixins/feedback'

module?.exports = React.createClass
  displayName: 'TalkCommentReportForm'

  mixins: [Validations, Feedback]

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
    @setFeedback "Comment Report successfully submitted"
    # send comment id and report to server here

  render: ->
    validationErrors = @renderValidations()
    feedback = @renderFeedback()

    <div className="talk-comment-report-form">
      <h1>Report a comment here</h1>

      {validationErrors}

      {feedback}

      <form className="talk-comment-report-form-form" onSubmit={@onSubmit}>
        <textarea ref="textarea" placeholder="Why are you reporting this comment?"></textarea>
        <button type="submit">Report</button>
      </form>
    </div>
