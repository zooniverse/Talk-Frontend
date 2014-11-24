React = require 'react'
CommentPreview = require './comment-preview'

module?.exports = React.createClass
  displayName: 'Commentbox'

  getDefaultProps: ->
    focusImage: 'http://placehold.it/200X200'
    submit: "Submit"
    header: "Add to the discussion"
    rows: 8
    cols: 30

  getInitialState: ->
    previewing: false

  onSubmitComment: (e) ->
    e.preventDefault()
    @refs.textarea.getDOMNode().value = ""

  onPreviewClick: (e) ->
    @setState previewing: !@state.previewing

  render: ->
    <div className="talk-comment-box">
      <h1>{@props.header}</h1>
      <img src={@props.focusImage}/>

      <form onSubmit={@onSubmitComment}>
        <textarea ref="textarea" rows={@props.rows} cols={@props.cols} />
        <button type="submit">{@props.submit}</button>
      </form>

      <button className='talk-comment-preview-button'onClick={@onPreviewClick}>Preview</button>

      {if @state.previewing
        <CommentPreview content={@previewContent()} />}
    </div>

  previewContent: ->
    @refs.textarea.getDOMNode().value
