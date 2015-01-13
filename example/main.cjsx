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
ImageViewer
ImageCollection
PrivateMessagePreview
PrivateMessageDisplay
PrivateMessageCreate
SubjectCollections
Paginate
ObjectView
SubjectDisplay} = require '../src/index'

exampleImages = [
  {title: "test 1", src: "http://placehold.it/600X400&text=1"}
  {title: "test 2", src: "http://placehold.it/600X400&text=2", description: "sadasd"}
  {title: "test 3", src: "http://placehold.it/600X400&text=3", description: "sadasd"}
  ]

Components = React.createClass
  displayName: 'TalkComponentsExamples'

  render: ->
    pm = {title: 'Example Private Message', content: 'Example PM Content'}

    <div className="talk-components-examples">
      <CommentBox />

      <CommentDisplay
        author="example_user"
        date={(new Date)}
        markdown={"# Example Comment"}/>

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

ImageViewerView = React.createClass
  render: ->
    <div>
      <ImageCollection images={exampleImages}/>
    </div>

App = React.createClass
  getInitialState: -> active: location.hash
  onHashChange: -> @setState active: location.hash
  componentDidMount: -> addEventListener 'hashchange', @onHashChange
  componentWillUnmount: -> removeEventListener 'hashchange', @onHashChange

  render: ->
    <div>
      <h1>Talk Frontend Components</h1>
      <nav>
        <a href="#/">components</a>
        <a href="#/object-view">object view</a>
        <a href="#/image-viewer">image viewer</a>
      </nav>

      {switch @state.active
         when '#/object-view'
           <ObjectView />
         when '#/image-viewer'
           <ImageViewerView />
         else
           <Components />}
    </div>

React.render <App />, document.getElementById('app')
