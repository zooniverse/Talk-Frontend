React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkCollectionCreate'

  onSubmit: (e) ->
    e.preventDefault()

  render: ->
    <div className="talk-collection-create">
      <h1>Create A New Collection</h1>
      <form className="talk-collection-create-form" onSubmit={@onSubmit}>
        <input placeholder="Collection Name" />
        <button type="submit">Submit</button>
      </form>
    </div>
