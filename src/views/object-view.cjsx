React = require 'react'
SubjectDisplay = require '../subject-display'
CommentDisplay = require '../comment-display'
CommentBox = require '../comment-box'

DEV_COMMENTS = [
  {
    author: "some_user"
    date: (new Date)
    markdown: "# Comment 1 \n a comment!"
  }
  {
    author: "some_user"
    date: (new Date)
    markdown: "# Comment 2 \n @a_user mention"
  }
  {
    author: "some_user"
    date: (new Date)
    markdown: "# Comment 3  \n hello1"
  }
]

module?.exports = React.createClass
  displayName: 'TalkObjectView'

  onSubmitComment: (e, content, focusImage) ->
    # submit comment and append/render

  commentDisplay: (comment, i) ->
    <CommentDisplay
      key={i}
      author={comment.author}
      date={comment.date}
      markdown={comment.markdown}/>

  render: ->
    comments = DEV_COMMENTS.map(@commentDisplay)

    <div className="talk-object-view" style={backgroundColor: "grey"}>
      <h1>Object View</h1>

      <SubjectDisplay />

      {comments}

      <CommentBox onSubmitComment={@onSubmitComment}/>
    </div>
