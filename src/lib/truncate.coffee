module?.exports = (string, charLength) ->
  if string.length < charLength
    string
  else
    string.trim().substring(0, (charLength ? 250)) + '...'
