React = require 'react'
truncate = require './lib/truncate'

module?.exports = React.createClass
  displayName: 'TalkPrivateMessagePreview'

  render: ->
    <div className="talk-private-message-preview #{if @props.message?.read then 'read' else ''}">
      <a href="http://www.zooniverse.org/link-to-pm">
        <h1>{@props.message.title}</h1>
      </a>
      <p>{truncate @props.message.content}</p>
    </div>
