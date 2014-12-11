React = require 'react'
Validations = require './mixins/validations'

module?.exports = React.createClass
  displayName: 'TalkCollectionCreate'
  mixins: [Validations]

  validations: [
    {
      check: (text) -> text.trim().length is 0
      error: "Collection Names must have content"
    }
  ]

  addCollection: (name) ->
    #post collection name to server here

  getInitialState: ->
    feedback: null

  onSubmit: (e) ->
    e.preventDefault()
    collectionName = @refs.collectionName.getDOMNode().value
    return if @setValidationErrors(collectionName)

    @addCollection(collectionName)

    @refs.collectionName.getDOMNode().value = ""
    @setState feedback: "#{collectionName} collection successfully added"

  render: ->
    validationErrors = @state.validationErrors?.map (message, i) =>
      <p key={i} className="talk-validation-error">{message}</p>

    <div className="talk-collection-create">
      <h1>Create A New Collection</h1>

      {validationErrors}

      {if @state.feedback
        <p className="talk-comment-feedback">{@state.feedback}</p>}

      <form className="talk-collection-create-form" onSubmit={@onSubmit}>
        <input placeholder="Collection Name" ref="collectionName" />
        <button type="submit">Submit</button>
      </form>
    </div>
