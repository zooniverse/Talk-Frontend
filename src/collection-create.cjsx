React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkCollectionCreate'

  addCollection: (name) ->
    #post collection name to server here

  onSubmit: (e) ->
    e.preventDefault()
    @addCollection(@refs.collectionName.getDOMNode().value)

    @refs.collectionName.getDOMNode().value = ""

  render: ->
    <div className="talk-collection-create">
      <h1>Create A New Collection</h1>
      <form className="talk-collection-create-form" onSubmit={@onSubmit}>
        <input placeholder="Collection Name" ref="collectionName" />
        <button type="submit">Submit</button>
      </form>
    </div>
