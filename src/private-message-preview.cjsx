React = require 'react'
truncate = require './lib/truncate'
links = require './lib/links'

module?.exports = React.createClass
  displayName: 'TalkPrivateMessagePreview'

  render: ->
    <div className="talk-private-message-preview #{if @props.message?.read then 'read' else ''}">
      <a href={links.message('put-message-id-here')}>
        <h1>{@props.message.title}</h1>
      </a>
      <p>{truncate @props.message.content}</p>
    </div>
