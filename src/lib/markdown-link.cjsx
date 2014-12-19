React = require 'react'

module?.exports = React.createClass
  displayName: 'MarkdownLink'

  propTypes: ->
    onCreateLink: React.PropTypes.func # gets passed (url, tutle)

  onSubmit: (e) ->
    e.preventDefault()
    url = @refs.url.getDOMNode().value?.trim()
    title = @refs.title.getDOMNode().value?.trim()

    @props.onCreateLink(e, url, title)

  render: ->
    <div className="talk-markdown-link">
      <form className="talk-markdown-link-form" onSubmit={@onSubmit}>
        <input ref="title" placeholder="Title" />
        <input ref="url" placeholder="Url"/>
        <button type="submit">Add Link</button>
      </form>
    </div>
