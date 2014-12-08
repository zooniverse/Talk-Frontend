React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkActiveButton'

  getInitialState: ->
    active: @props.active ? false

  onClick: (e) ->
    @setState active: !@state.active
    @props.onClick?(e)

  render: ->
    <button onClick={@onClick} className="talk-active-button #{@props.className} #{if @state.active then 'active' else ''}" >
      {@props.children}
    </button>
