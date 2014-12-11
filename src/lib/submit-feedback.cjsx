React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkSubmitFeedback'

  render: ->
    <div className="talk-submit-feedback">
      <p>{@props.feedback}</p>
    </div>
