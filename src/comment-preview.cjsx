React = require 'react'
marked = require 'marked'

module?.exports = React.createClass
  displayName: 'TalkCommentPreview'

  replaceSymbols: (string) ->
    string
      .replace(/@(\w+)/g, "<a href='http://www.zooniverse.org/user/$1'>$1</a>") # user mentions
      .replace(/\^([A-Za-z]+[0-9]+)/g, "<a href='http://www.zooniverse.org/subjects/$1'>$1</a>") # subject mentions
      .replace(/\#(\w+)/g, "<a href='http://www.zooniverse.org/tags/$1'>#$1</a>") # hashtags


  markdownify: (input) ->
    marked input, {sanitize: true}, (err, content) =>
      throw err if err
      return @replaceSymbols(content)

  render: ->
    html = @markdownify(@props.content)

    <div className='talk-comment-preview'>
      <h1>Preview</h1>
      <div className='talk-comment-preview-content' dangerouslySetInnerHTML={__html: html}></div>
    </div>
