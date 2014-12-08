React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkPostPreview'

  render: ->
    <div className="talk-post-preview">
      <a href="http://www.zooniverse.org/link-to-post">
        <h1>Example Post</h1>
      </a>
      <p>by <a href="http://www.zooniverse.org/link-to-user">(Post.user)</a> on {(new Date).toString()}</p>
    </div>