React = require 'react'
Validations = require './mixins/validations'
Feedback = require './mixins/feedback'

module?.exports = React.createClass
  displayName: 'TalkCollectionCreate'
  mixins: [Validations, Feedback]

  validations: [
    {
      check: (text) -> text.trim().length is 0
      error: "Collection Names must have content"
    }
  ]

  addCollection: (name) ->
    #post collection name to server here

  onSubmit: (e) ->
    e.preventDefault()
    collectionName = @refs.collectionName.getDOMNode().value
    return if @setValidationErrors(collectionName)

    @addCollection(collectionName)

    @refs.collectionName.getDOMNode().value = ""
    @setFeedback "#{collectionName} collection successfully added"

  render: ->
    validationErrors = @renderValidations()
    feedback = @renderFeedback()

    <div className="talk-collection-create">
      <h1>Create A New Collection</h1>

      {validationErrors}
      {feedback}

      <form className="talk-collection-create-form" onSubmit={@onSubmit}>
        <input placeholder="Collection Name" ref="collectionName" />
        <button type="submit">Submit</button>
      </form>
    </div>
