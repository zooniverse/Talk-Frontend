React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkCommentHelp'

  render: ->
    <div className="talk-comment-help">
      <h1>Guide to commenting on talk</h1>
      <p>Mention users with @username</p>
      <p>Mention subjects with ^subject_id</p>
      <p>Create hashtags with #hashtag</p>
    </div>
