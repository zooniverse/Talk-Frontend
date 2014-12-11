React = require 'react'
SubjectDisplay = require './subject-display'
ToggleChildren = require './mixins/toggle-children'
links = require './lib/links'

module?.exports = React.createClass
  displayName: 'TalkCollectionPreview'
  mixins: [ToggleChildren]

  subjectDisplay: (data, i) ->
    <SubjectDisplay key={i} />

  onClickEdit: (e) ->
    @toggleComponent('edit-form')

  onSubmitEdit: (e) ->
    newName = @refs.editName.getDOMNode().value
    e.preventDefault()
    @hideChildren()

  onClickDelete: (e) ->
    if window.confirm("Are you sure that you want to delete this collection?")
      console.log "delete collection here"

  render: ->
    <div className="talk-collection-preview">
      <a href={links.collection('user-here', 'collection-here')}>
        <h1>Talk Collection Preview</h1>
      </a>

      <div className="talk-collection-preview-edit">
        <button className="talk-collection-preview-edit-button" onClick={@onClickEdit}>Edit Name</button>
        <button className="talk-collection-preview-delete-button" onClick={@onClickDelete}>Delete Collection</button>
      </div>

      {if @state.showing is 'edit-form'
        <div className="talk-collection-edit-form">
          <form onSubmit={@onSubmitEdit}>
            <input ref="editName" placeholder="Edit Name"/>
            <button type="submit">Edit</button>
          </form>
        </div>}

      {[1..3].map(@subjectDisplay)}
    </div>
