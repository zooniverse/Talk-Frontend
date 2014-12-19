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
    feedback: null

  onChangeInput: (e) ->
    collections = @state.collections.map (coll, i) ->
      if +coll.id is +e.target.getAttribute('value')
        coll.member = !coll.member
      coll

    @setState collections: collections

  pluckAttribute: (nodeList, attrName) ->
    [].slice.call(nodeList).map (node) ->
      node.getAttribute(attrName)

  getSelectedInputValues: ->
    selectedInputNodes = @refs.collectionsList.getDOMNode().querySelectorAll("input:checked")

    @pluckAttribute(selectedInputNodes, 'value')

  onSubmit: (e) ->
    e.preventDefault()

    # save these collections on subject:
    @getSelectedInputValues()

    @setState feedback: "Subject collection list saved"

  collectionItem: (coll, i) ->
    <li key={i}>
      <label>
        <input type="checkbox" value={coll.id} checked={coll.member} onChange={@onChangeInput}/>{coll.name}
      </label>
    </li>

  render: ->
    <div className="talk-subject-collections">
      <h1>Add Subject To collection</h1>

      {if @state.feedback
        <p className="talk-feedback">{@state.feedback}</p>}

      <form onSubmit={@onSubmit} className="talk-subject-collections-form">
        <ul ref="collectionsList">
          {@state.collections.map(@collectionItem)}
        </ul>
        <button type="submit">Save</button>
      </form>
    </div>
