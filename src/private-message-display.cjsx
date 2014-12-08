React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkPrivateMessageDisplay'

  render: ->
    <div className="talk-private-message-display">
      <a href="http://www.zooniverse.org/link-to-pm">
        <h1>{@props.message.title}</h1>
      </a>
      <p>{@props.message.content}</p>
    </div>
