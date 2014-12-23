React = require 'react'
links = require './lib/links'

module?.exports = React.createClass
  displayName: 'HashtagsList'

  hashtagItem: (tagName, i) ->
    <a key={i} href={links.hashtag(tagName)} className="talk-hashtags-list-item">
      <p>#{tagName}</p>
    </a>

  render: ->
    <div className="talk-hashtags-list">
      <h1>{@props.title}</h1>
      <div className="talk-hashtags-list-items">
        {@props.hashtags.map(@hashtagItem)}
      </div>
    </div>
