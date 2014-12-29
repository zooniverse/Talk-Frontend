React = require 'react'
CommentBox = require './comment-box'

module?.exports = React.createClass
  displayName: 'TalkCommentEdit'

  onSubmitComment: (e, textContent, focusImage) ->
    # update comment with new {textContent, focusImage}

  render: ->
    <div className="talk-comment-edit">
      <CommentBox
        header={"Edit a comment"}
        content={"Sample comment to edit"}
        submitFeedback={"Comment successfully Updated"}
        submit={"Update Comment"}
        onSubmitComment={@onSubmitComment}/>
    </div>
