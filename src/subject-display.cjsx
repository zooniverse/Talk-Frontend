React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkSubjectDisplay'

  render: ->
    <div className="talk-subject-display">
      <h1>Subject EX123123</h1>
      <p>metadata</p>
      <p>stats, favorite count, etc</p>
      <img src="http://placehold.it/200X200&text=GZ12384" />
    </div>
