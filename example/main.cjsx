React = require 'react'
{CommentBox} = require '../src/index'

Components = React.createClass
  displayName: 'TalkComponentsExamples'

  render: ->
    <div className="talk-components-examples">
      <CommentBox />
    </div>

React.render <Components />, document.getElementById('app')

console.log 'main'
