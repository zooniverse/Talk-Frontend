makeMarkdownHelper = (prefix, string, suffix = '') ->
  # (string) -> {text, cursor}
  # text is the formatted markdown string
  # cursor is the position in that string to put the cursor back

  # wraps string in prefix & suffix
  # returns object with {text: output string, cursor: {start, end}}
  # * start and end are selection indexes
  # probably easiest to access data with {text, cursor} = func()

  text = prefix + string + suffix
  start = prefix.length
  end = start + string.length

  cursor = {start, end}
  {text, cursor}

onNewLine = (string, cursorIndex) ->
  charAtCursor = string.charAt(cursorIndex - 1)
  (charAtCursor is '\n') or (cursorIndex is 0)

module?.exports =
  hrefLink: (url, title) ->
    linkTitle = title or "Example Title"
    linkUrl = url or "http://www.example.com"
    makeMarkdownHelper(" [#{linkTitle}](", linkUrl, ") ")

  imageLink: (url, title) ->
    imageTitle = title or "Example Image"
    imageUrl = url or "http://www.example.com/image.png"
    makeMarkdownHelper(" ![#{imageTitle}](", imageUrl, ') ')

  bold: (string) ->
    makeMarkdownHelper(' **', string, '** ')

  italic: (string) ->
    makeMarkdownHelper(' *', string, '* ')

  quote: (string) ->
    makeMarkdownHelper('> ', string)

  bullet: (string) ->
    makeMarkdownHelper('- ', string)

  numberedList: (string) ->
    makeMarkdownHelper('1. ', string)

  heading: (string) ->
    makeMarkdownHelper(' ## ', string, ' ## ')

  horizontalRule: (string) ->
    makeMarkdownHelper('----------\n', string)

  strikethrough: (string) ->
    makeMarkdownHelper(' ~~', string, '~~ ') # github-flavored specific

  getSelection: (input) ->
    input.value.substring(input.selectionStart, input.selectionEnd)

  insertAtCursor: (text, input, cursor, opts = {}) ->
    inputVal = input.value                              # input text value
    cursorPos = input.selectionStart                    # current cursor position
    cursorEnd = input.selectionEnd or inputVal.length   # end of highlight, if so
    notOnNewLine = not onNewLine(inputVal, cursorPos)

    # optional char for newline switch
    newLineChar = if (opts.ensureNewLine and notOnNewLine) then '\n' else ''

    # values to update input.value with
    begInputValue = inputVal.substring(0, cursorPos) + newLineChar
    midInputValue = text
    endInputValue = inputVal.substring(cursorEnd, inputVal.length)
    # post update selection start
    newSelectionStart = cursorPos + cursor.start + newLineChar.length

    # post update selection end
    newSelectionEnd = cursorPos + cursor.end + newLineChar.length

    # set input value to existing text with new text at current cursor position, or append
    input.value = begInputValue + midInputValue + endInputValue

    # set cursor back to a meaningful location for continued typing
    input.focus()
    input.setSelectionRange?(newSelectionStart, newSelectionEnd)
