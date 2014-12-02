React = require 'react'
ToggleChildren = require './mixins/toggle-children'

CommentBox = require './comment-box'
CommentReportForm = require './comment-report-form'
CommentLink = require './comment-link'

module?.exports = React.createClass
  displayName: 'TalkCommentDisplay'
  mixins: [ToggleChildren]

  propTypes:
    author: React.PropTypes.string
    time: React.PropTypes.string
    html: React.PropTypes.string

  formatDate: (date) ->
    # TODO: update with actual date formatting, move to a mixin
    date.toString()

  onClickReply: (e) ->
    @toggleComponent('reply')

  onClickLink: (e) ->
    @toggleComponent('link')

  onClickReport: (e) ->
    @toggleComponent('report')

  render: ->
    <div className="talk-comment-display">
      <p className="talk-comment-display-author">
        by {@props.author} {@formatDate(@props.date)} ago
      </p>

      <div className="talk-comment-display-content" dangerouslySetInnerHTML={__html: @props.html}></div>

      <div className="talk-comment-display-links">
        <button className="talk-comment-display-reply-button" onClick={@onClickReply}>Reply</button>
        <button className="talk-comment-display-link-button" onClick={@onClickLink}>Link</button>
        <button className="talk-comment-display-report-button" onClick={@onClickReport}>Report</button>
      </div>

      <div className="talk-comment-display-children">
        {switch @state.showing
           when 'reply' then <CommentBox />
           when 'link' then <CommentLink />
           when 'report' then <CommentReportForm />}
      </div>
    </div>
