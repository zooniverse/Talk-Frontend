React = require 'react'
CommentBox = require './comment-box'

module?.exports = React.createClass
  displayName: 'TalkCommentDisplay'

  propTypes:
    author: React.PropTypes.string
    time: React.PropTypes.string
    html: React.PropTypes.string

  formatDate: (date) ->
    # TODO: update with actual date formatting
    date.toString()

  render: ->
    <div className="talk-comment-display">
      <p className="talk-comment-display-author">
        by {@props.author} {@formatDate(@props.date)} ago
      </p>

      <div className="talk-comment-display-content" dangerouslySetInnerHTML={__html: @props.html}></div>

      <div className="talk-comment-display-links">
        <button>Reply</button>
        <button>Link</button>
        <button>Report</button>
      </div>
    </div>
