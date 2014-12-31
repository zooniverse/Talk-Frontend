React = require 'react'
ToggleChildren = require './mixins/toggle-children'
Feedback = require './mixins/feedback'
CommentBox = require './comment-box'
CommentReportForm = require './comment-report-form'
CommentLink = require './comment-link'
CommentPreview = require './comment-preview'
SubjectDisplay = require './subject-display'
{timeStamp} = require './lib/time'

module?.exports = React.createClass
  displayName: 'TalkCommentDisplay'
  mixins: [ToggleChildren, Feedback]

  propTypes:
    author: React.PropTypes.string
    time: React.PropTypes.string
    markdown: React.PropTypes.string

  getInitialState: ->
    editing: false

  onClickReply: (e) ->
    @toggleComponent('reply')

  onClickLink: (e) ->
    @toggleComponent('link')

  onClickReport: (e) ->
    @toggleComponent('report')

  onClickEdit: (e) ->
    @setState editing: true
    @removeFeedback()

  onSubmitComment: (e, textContent, focusImage) ->
    # update comment here...
    @setState editing: false
    @setFeedback "Comment Updated"

  render: ->
    feedback = @renderFeedback()

    <div className="talk-comment-display">
      <p className="talk-comment-display-author">
        by {@props.author} {timeStamp @props.date.toString()}
      </p>

      {feedback}

      {if not @state.editing
        <div className="talk-comment-display-content">
          {if @props.comment?.focusImage
            <SubjectDisplay subject="put-subject-here..."/>}

          <CommentPreview content={@props.markdown} header={null}/>

          <div className="talk-comment-display-links">
            <button className="talk-comment-display-reply-button" onClick={@onClickReply}>Reply</button>
            <button className="talk-comment-display-link-button" onClick={@onClickLink}>Link</button>
            <button className="talk-comment-display-report-button" onClick={@onClickReport}>Report</button>
            <button className="talk-comment-display-edit-button" onClick={@onClickEdit}>Edit</button>
          </div>

          <div className="talk-comment-display-children">
            {switch @state.showing
               when 'reply' then <CommentBox header="Reply to #{@props.author}" />
               when 'link' then <CommentLink />
               when 'report' then <CommentReportForm />}
          </div>
        </div>
      else
        <CommentBox
          header={"Editing Comment..."}
          content={@props.markdown}
          submitFeedback={"Comment will update here..."}
          submit={"Update Comment"}
          onSubmitComment={@onSubmitComment}/>}
    </div>
