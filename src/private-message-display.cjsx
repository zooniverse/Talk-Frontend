React = require 'react'
ToggleChildren = require './mixins/toggle-children'
CommentBox = require './comment-box'

module?.exports = React.createClass
  displayName: 'TalkPrivateMessageDisplay'
  mixins: [ToggleChildren]
  
  onClickReply: ->
    @toggleComponent('reply')

  render: ->
    <div className="talk-private-message-display">
      <h1>{@props.message.title}</h1>
      <p>on {(new Date).toString()}</p>
      <p>{@props.message.content}</p>

      <button onClick={@onClickReply}>Reply</button>

      {if @state.showing is 'reply'
        <CommentBox header="Reply to user" submit="Reply" />}
    </div>
