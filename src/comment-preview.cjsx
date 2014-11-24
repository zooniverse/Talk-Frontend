React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkCommentPreview'

  render: ->
    <div className='talk-comment-preview'>
      <h1>Preview</h1>
      <p>
        {@props.content}
      </p>
    </div>
