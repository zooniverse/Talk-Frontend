React = require 'react'
CommentBox = require './comment-box'

module?.exports = React.createClass
  displayName: 'TalkPrivateMessageCreate'

  render: ->
    <div className="talk-private-message-create">
      <CommentBox header="Send Private Message to User" submit="Send" />
    </div>
