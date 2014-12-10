moment = require 'moment'

module?.exports =
  timeStamp: (ts) ->
    moment(ts).format('MMMM Do YYYY, h:mm a')





