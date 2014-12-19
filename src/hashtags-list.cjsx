React = require 'react'

module?.exports = React.createClass
  displayName: 'HashtagsList'

  hashtagItem: (tagName, i) ->
    <p key={i} className="talk-hashtags-list-item">#{tagName}</p>

  render: ->
    <div className="talk-hashtags-list">
      <h1>{@props.title}</h1>
      <div className="talk-hashtags-list-items">
        {@props.hashtags.map(@hashtagItem)}
      </div>
    </div>
