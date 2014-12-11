React = require 'react'

module?.exports = React.createClass
  displayName: 'TalkNotifications'

  notification: (msg, i) ->
    <p key={i}>{msg}</p>

  render: ->
    <div className="talk-notifications">
      {@props.notifications.map(@notification)}
    </div>
