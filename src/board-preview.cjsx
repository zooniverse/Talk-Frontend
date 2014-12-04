React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkBoardDisplay'

  render: ->
    <div className="talk-board-preview">
      <a href="http://www.zooniverse.org/link-to-board">
        <h1>Example Board</h1>
      </a>

      <p>Latest Post: 
        <a href="http://www.zooniverse.org/link-to-post">(Post.title)</a>
        <span> by </span>
        <a href="http://www.zooniverse.org/link-to-user">(Post.user)</a>
      </p>

      <p>{Math.round Math.random() * 1000} Users</p>
      <p>{Math.round Math.random() * 1000} Comments</p>
      <p>Board Description Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>

      <p>Last Updated: {(new Date).toString()}</p>
    </div>
