React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkCommentReportForm'

  onSubmit: (e) ->
    e.preventDefault()

  render: ->
    <div className="talk-comment-report-form">
      <h1>Report a comment here</h1>

      <form onSubmit={@onSubmit}>
        <textarea></textarea>
        <button type="submit">Report</button>
      </form>
    </div>
