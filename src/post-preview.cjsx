React = require 'react'
{timeStamp} = require './lib/time'
links = require './lib/links'

module?.exports = React.createClass
  displayName: 'TalkPostPreview'

  render: ->
    <div className="talk-post-preview">
      <a href={links.post('board-here', 'thread-here', 'post-here')}>
        <h1>Example Post</h1>
      </a>
      <p>by <a href={links.user('user-here')}>(Post.user)</a> on {timeStamp (new Date).toString()}</p>
    </div>
