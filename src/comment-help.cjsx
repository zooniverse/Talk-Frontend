React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkCommentHelp'

  render: ->
    <div className="talk-comment-help">
      <h1>Guide to commenting on talk</h1>
      <p>Mention users with "@user:sample_username"</p>
      <p>Mention subjects with "@subject:sample_subject"</p>
    </div>
