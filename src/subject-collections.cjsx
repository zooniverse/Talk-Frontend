React = require 'react'
Feedback = require './mixins/feedback'

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

  mixins: [Feedback]

  getInitialState: ->
    collections: user.project.subject.collections

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

    @setFeedback "Subject collection list saved"

  collectionItem: (coll, i) ->
    <li key={i}>
      <label>
        <input type="checkbox" value={coll.id} checked={coll.member} onChange={@onChangeInput}/>{coll.name}
      </label>
    </li>

  render: ->
    feedback = @renderFeedback()

    <div className="talk-subject-collections">
      <h1>Add Subject To collection</h1>

      {feedback}

      <form onSubmit={@onSubmit} className="talk-subject-collections-form">
        <ul ref="collectionsList">
          {@state.collections.map(@collectionItem)}
        </ul>
        <button type="submit">Save</button>
      </form>
    </div>
