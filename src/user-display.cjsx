React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkUserDisplay'

  render: ->
    <div className="talk-user-display">
      <a href="http://www.zooniverse.org/users/#{@props.name}">
        <img src="http://placehold.it/50&text=user+avatar" />
      </a>
      <span className="talk-user-display-name">{@props.name} </span>
      <span className="talk-user-display-formatted-name">{@props.formattedName}</span>
    </div>
