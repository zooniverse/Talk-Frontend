React = require 'react'
{CommentBox, CommentDisplay, UserDisplay, BoardPreview, PostPreview, SubjectDisplay} = require '../src/index'

Components = React.createClass
  displayName: 'TalkComponentsExamples'

  render: ->
    <div className="talk-components-examples">
      <CommentBox />

      <CommentDisplay
        author="example_user"
        date={(new Date)}
        html={"<h1>Example Comment HTML</h1>"}/>

      <UserDisplay name="example_user" formattedName="Example User"/>

      <BoardPreview />

      <PostPreview />

      <SubjectDisplay />

    </div>

React.render <Components />, document.getElementById('app')

console.log 'main'
