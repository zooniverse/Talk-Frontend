React = require 'react'
CommentPreview = require './comment-preview'
CommentHelp = require './comment-help'

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
    showingHelp: false

  onSubmitComment: (e) ->
    e.preventDefault()
    @refs.textarea.getDOMNode().value = ""
    @setState previewing: false

  onPreviewClick: (e) ->
    @setState previewing: !@state.previewing

  onHelpClick: (e) ->
    @setState showingHelp: !@state.showingHelp

  render: ->
    <div className="talk-comment-box">
      <h1>{@props.header}</h1>
      <img src={@props.focusImage}/>

      <form onSubmit={@onSubmitComment}>
        <textarea ref="textarea" rows={@props.rows} cols={@props.cols} />
        <button type="submit">{@props.submit}</button>
      </form>

      <button className='talk-comment-preview-button' onClick={@onPreviewClick}>Preview</button>
      <button className='talk-comment-help-button' onClick={@onHelpClick}>Help</button>

      {if @state.previewing
        <CommentPreview content={@previewContent()} />}

      {if @state.showingHelp
        <CommentHelp />}
    </div>

  previewContent: ->
    @refs.textarea.getDOMNode().value
