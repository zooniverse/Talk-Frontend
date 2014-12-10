React = require 'react'
ToggleChildren = require './mixins/toggle-children'

CommentBox = require './comment-box'
CommentReportForm = require './comment-report-form'
CommentLink = require './comment-link'
SubjectDisplay = require './subject-display'
{timeStamp} = require './lib/time'

module?.exports = React.createClass
  displayName: 'TalkCommentDisplay'
  mixins: [ToggleChildren]

  propTypes:
    author: React.PropTypes.string
    time: React.PropTypes.string
    html: React.PropTypes.string

  onClickReply: (e) ->
    @toggleComponent('reply')

  onClickLink: (e) ->
    @toggleComponent('link')

  onClickReport: (e) ->
    @toggleComponent('report')

  render: ->
    <div className="talk-comment-display">
      <p className="talk-comment-display-author">
        by {@props.author} {timeStamp @props.date.toString()}
      </p>

      {if @props.comment?.focusImage
        <SubjectDisplay subject="put-subject-here..."/>}

      <div className="talk-comment-display-content" dangerouslySetInnerHTML={__html: @props.html}></div>

      <div className="talk-comment-display-links">
        <button className="talk-comment-display-reply-button" onClick={@onClickReply}>Reply</button>
        <button className="talk-comment-display-link-button" onClick={@onClickLink}>Link</button>
        <button className="talk-comment-display-report-button" onClick={@onClickReport}>Report</button>
      </div>

      <div className="talk-comment-display-children">
        {switch @state.showing
           when 'reply' then <CommentBox header="Reply to #{@props.author}" />
           when 'link' then <CommentLink />
           when 'report' then <CommentReportForm />}
      </div>
    </div>
