React = require 'react'
SubjectDisplay = require './subject-display'

module?.exports = React.createClass
  displayName: 'TalkCollectionPreview'

  subjectDisplay: (data, i) ->
    <SubjectDisplay key={i} />

  render: ->
    <div className="talk-collection-preview">
      <a href="http://www.zooniverse.org/link-to-collection">
        <h1>Talk Collection Preview</h1>
      </a>
      {[1..3].map(@subjectDisplay)}
    </div>
