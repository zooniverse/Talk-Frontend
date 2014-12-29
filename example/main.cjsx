React = require 'react'

{CommentBox
CommentDisplay
CommentEdit
UserDisplay
BoardPreview
PostPreview
DiscussionCreate
CollectionPreview
CollectionCreate
HashtagsList
PrivateMessagePreview
PrivateMessageDisplay
PrivateMessageCreate
SubjectCollections
Paginate
SubjectDisplay} = require '../src/index'

Components = React.createClass
  displayName: 'TalkComponentsExamples'

  render: ->
    pm = {title: 'Example Private Message', content: 'Example PM Content'}

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

      <CollectionPreview />

      <CollectionCreate />

      <SubjectCollections />

      <PrivateMessagePreview message={pm} />

      <PrivateMessageDisplay message={pm} />

      <PrivateMessageCreate />

      <DiscussionCreate />

      <HashtagsList title="Popular Hashtags" hashtags={["kelp", "help", "yelp", "welp"]} />

      <CommentEdit />

      <Paginate collLength={9} perPage={3} onPageChange={(data) => console.log data}/>

    </div>

React.render <Components />, document.getElementById('app')

console.log 'main'
