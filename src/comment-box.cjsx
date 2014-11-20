React = require 'react'

module?.exports = React.createClass
  displayName: 'Commentbox'

  getDefaultProps: ->
    focusImage: 'http://placehold.it/200X200'
    submit: "Submit"
    header: "Add to the discussion"
    rows: 8
    cols: 30

  onSubmitComment: (e) ->
    e.preventDefault()
    console.log "send talk comment"
    @refs.textarea.getDOMNode().value = ""

  render: ->
    <div className="talk-comment-box">
      <h1>{@props.header}</h1>
      <img src={@props.focusImage}/>

      <form onSubmit={@onSubmitComment}>
        <textarea ref="textarea" rows={@props.rows} cols={@props.cols} />
        <button type="submit">{@props.submit}</button>
      </form>
    </div>
