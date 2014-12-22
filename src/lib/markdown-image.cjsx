React = require 'react'

module?.exports = React.createClass
  displayName: 'MarkdownImage'

  propTypes: ->
    onCreateImage: React.PropTypes.func # gets passed (url, tutle)

  onSubmit: (e) ->
    e.preventDefault()
    url = @refs.url.getDOMNode().value?.trim()
    alt = @refs.alt.getDOMNode().value?.trim()

    @props.onCreateImage(e, alt, url)

    @resetForm()

  clearInputValue: (ref) ->
    @refs[ref].getDOMNode().value = ''

  resetForm: ->
    refsToClear = ['url', 'alt']
    refsToClear.forEach @clearInputValue

  render: ->
    <div className="talk-markdown-image">
      <form className="talk-markdown-image-form" onSubmit={@onSubmit}>
        <input ref="alt" placeholder="Alt text" />
        <input ref="url" placeholder="Image Url"/>
        <button type="submit">Add Image Link</button>
      </form>
    </div>
