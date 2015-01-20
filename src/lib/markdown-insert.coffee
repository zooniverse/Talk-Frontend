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

incrementedListItems = (previousText, text) -> # TODO: limit prev lines length
  numberedLi = /^[^\d]*(\d+)/ # matches something line "3."
  splitPrevLines = previousText.split("\n")
  prevLine = splitPrevLines[splitPrevLines.length - 2]
  splitSelection = text.split("\n")

  if splitSelection.length > 1 # user has multiple lines highlighted
    splitSelection
      .map (text, i) ->
        text.replace numberedLi, (fullMatch, n) -> i + 1
      .join("\n")
  else
    text.replace numberedLi, (fullMatch, n) ->
      if prevLine then (+prevLine.split(".")[0] + 1) else 1

module?.exports =
  hrefLink: (title, url) ->
    linkTitle = title or "Example Text"
    linkUrl = url or "http://www.example.com"
    makeMarkdownHelper("[#{linkTitle}](", linkUrl, ")")

  imageLink: (url, title) ->
    imageTitle = title or "Example Alt Text"
    imageUrl = url or "http://www.example.com/image.png"
    makeMarkdownHelper("![#{imageTitle}](", imageUrl, ')')

  bold: (string) ->
    text = string or "Bold Text"
    makeMarkdownHelper('**', text, '**')

  italic: (string) ->
    text = string or "Italic Text"
    makeMarkdownHelper('*', text, '*')

  quote: (string) ->
    text = string or "Quoted Text"
    makeMarkdownHelper('> ', text)

  bullet: (string) ->
    makeMarkdownHelper('- ', string)

  numberedList: (string) ->
    makeMarkdownHelper('1. ', string)

  heading: (string) ->
    makeMarkdownHelper('## ', string, ' ##')

  horizontalRule: (string) ->
    makeMarkdownHelper('----------\n', string)

  strikethrough: (string) ->
    makeMarkdownHelper('~~', string, '~~') # github-flavored specific

  getSelection: (input) ->
    input.value.substring(input.selectionStart, input.selectionEnd)

  insertAtCursor: (text, input, cursor, opts = {}) ->
    inputVal = input.value                                 # input text value
    cursorPos = input.selectionStart                       # current cursor position
    cursorEnd = input.selectionEnd                         # end of highlight, if so
    notOnNewLine = not onNewLine(inputVal, cursorPos)

    # optional char for newline switch
    newLineChar = if (opts.ensureNewLine and notOnNewLine) then '\n' else ''
    numberedList = opts.incrementLines and opts.ensureNewLine

    # values to update input.value with
    begInputValue = inputVal.substring(0, cursorPos) + newLineChar
    midInputValue = if numberedList then incrementedListItems(begInputValue, text) else text
    endInputValue = inputVal.substring(cursorEnd, inputVal.length)

    newSelectionStart = cursorPos + cursor.start + newLineChar.length
    newSelectionEnd = cursorPos + cursor.end + newLineChar.length

    # update input value with new values
    input.value = begInputValue + midInputValue + endInputValue

    # set cursor back to a meaningful location for continued typing
    input.focus()
    input.setSelectionRange?(newSelectionStart, newSelectionEnd)
