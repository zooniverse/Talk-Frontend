React = require 'react'
{timeStamp} = require './lib/time'
links = require './lib/links'

module?.exports = React.createClass
  displayName: 'TalkBoardDisplay'

  render: ->
    <div className="talk-board-preview">
      <a href={links.board('put-board-id-here')}>
        <h1>Example Board</h1>
      </a>

      <p>Latest Post: 
        <a href={links.post('board-name', 'thread-name', 'post-id')}>(Post.title)</a>
        <span> by </span>
        <a href={links.user('user-name-here')}>(Post.user)</a>
      </p>

      <p>{Math.round Math.random() * 1000} Users</p>
      <p>{Math.round Math.random() * 1000} Comments</p>
      <p>Board Description Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>

      <p>Last Updated: {timeStamp (new Date).toString()}</p>
    </div>
