React = require 'react'
ActiveButton = require './lib/active-button'

module?.exports = React.createClass
  displayName: 'TalkSubjectDisplay'

  # @props.subject will be where subject name, favorite, stats etc comes from
  getInitialState: ->
    favorite: @props.subject?.favorite ? false

  toggleSubjectFavorite: ->
    @setState favorite: !@state.favorite

  render: ->
    <div className="talk-subject-display">
      <h1>Subject EX123123</h1>
      <p>metadata</p>
      <p>stats, favorite count, etc</p>
      <img src="http://placehold.it/200X200&text=GZ12384" />

      <ActiveButton
        className="talk-subject-display-favorite-button"
        onClick={@toggleSubjectFavorite}
        active={@state.favorite}>
        {if @state.favorite then "Remove from Favorites" else "Add to Favorites"}
      </ActiveButton>
    </div>
