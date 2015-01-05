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

  insertAtCursor: (text, input, cursor) ->
    inputVal = input.value                              # input text value
    cursorPos = input.selectionStart                    # current cursor position
    cursorEnd = input.selectionEnd or inputVal.length   # end of highlight, if so

    newSelectionStart = cursorPos + cursor.start        # post update selection start
    newSelectionEnd   = cursorPos + cursor.end          # post update selection end

    # set input value to existing text with new text at current cursor position, or append
    input.value = (inputVal.substring(0, cursorPos) + text + inputVal.substring(cursorEnd, inputVal.length))

    # set cursor back to a meaningful location for continued typing
    input.focus()
    input.setSelectionRange?(newSelectionStart, newSelectionEnd)
