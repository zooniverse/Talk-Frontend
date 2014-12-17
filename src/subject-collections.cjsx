React = require 'react'

user =
  project:
    subject:
      collections: [
        {
          id: 123
          name: "Sample Collection"
          member: false
        }
        {
          id: 456
          name: "Example Collection"
          member: true
        }
        {
          id: 9123
          name: "Dev Collection"
          member: true
        }
      ]


module?.exports = React.createClass
  displayName: 'TalkSubjectCollections'

  getInitialState: ->
    collections: user.project.subject.collections

  onChangeInput: (e) ->
    console.log "asd"
    collections = @state.collections
    collections = collections.map (coll, i) ->
      if coll.id is +e.target.getAttribute('value')
        coll.member = !coll.member
      coll

    @setState collections: collections

  getSelectedInputValues: ->
    selectedInputNodes = @refs.collectionsList.getDOMNode().querySelectorAll("input:checked")

    [].slice.call(selectedInputNodes).map (input) ->
      input.getAttribute('value')

  onSubmit: (e) ->
    e.preventDefault()

    console.log "save these collections on subject", @getSelectedInputValues()

  collectionItem: (coll, i) ->
    <li key={i}>
      <label>
        <input type="checkbox" value={coll.id} checked={coll.member} onChange={@onChangeInput}/>{coll.name}
      </label>
    </li>

  render: ->
    <div className="talk-subject-collections">
      <h1>Add Subject To collection</h1>
      <form onSubmit={@onSubmit} className="talk-subject-collections-form">
        <ul ref="collectionsList">
          {@state.collections.map(@collectionItem)}
        </ul>
        <button type="submit">Save</button>
      </form>
    </div>
