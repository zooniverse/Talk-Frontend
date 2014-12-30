module?.exports =
  # for funcs that return {text, cursor}
  # text is the formatted markdown string
  # cursor is the position in that string to put the cursor back
  # probably easiest to access them with {text, cursor} = func()

  hrefLink: (title, url) ->
    linkTitle = title or "Example Title"
    linkUrl = url or "http://www.example.com"

    text = " [#{linkTitle}](#{linkUrl}) "
    cursor = text.length
    {text, cursor}

  imageLink: (title, url) ->
    imageTitle = title or "Example Image"
    imageUrl = url or "http://www.example.com/image.png"

    text = " ![#{imageTitle}](#{imageUrl}) "
    cursor = text.length
    {text, cursor}

  bold: (string) ->
    text = " **#{string}** "
    cursor = string.length + 3 # 3 chars added in front
    {text, cursor}

  italic: (string) ->
    text = " *#{string}* "
    cursor = string.length + 2 # 2 chars added in front
    {text, cursor}

  getSelection: (input) ->
    input.value.substring(input.selectionStart, input.selectionEnd)

  insertAtCursor: (text, input, cursor) ->
    inputVal = input.value                              # input text value
    cursorPos = input.selectionStart or inputVal.length # current cursor position
    cursorEnd = input.selectionEnd or inputVal.length   # end of highlight, if so
    newCursorPos = cursorPos + cursor                   # index to place cursor after update

    # set input value to existing text with new text at current cursor position, or append
    input.value = (inputVal.substring(0, cursorPos) + text + inputVal.substring(cursorEnd, inputVal.length))

    # set cursor back to a meaningful location for continued typing
    input.focus()
    input.setSelectionRange?(newCursorPos, newCursorPos)
