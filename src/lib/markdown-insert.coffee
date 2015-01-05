module?.exports =
  # for funcs that return {text, cursor}
  # text is the formatted markdown string
  # cursor is the position in that string to put the cursor back
  # probably easiest to access them with {text, cursor} = func()

  hrefLink: (url, title) ->
    linkTitle = title or "Example Title"
    linkUrl = url or "http://www.example.com"

    text = " [#{linkTitle}](#{linkUrl}) "

    start = " [#{linkTitle}](".length
    end = start + linkUrl.length

    cursor = {start, end}
    {text, cursor}

  imageLink: (url, title) ->
    imageTitle = title or "Example Image"
    imageUrl = url or "http://www.example.com/image.png"

    text = " ![#{imageTitle}](#{imageUrl}) "

    start = " ![#{imageTitle}](".length
    end = start + imageUrl.length

    cursor = {start, end}
    {text, cursor}

  bold: (string) ->
    text = " **#{string}** "
    start = ' **'.length
    end = start + string.length

    cursor = {start, end}
    {text, cursor}

  italic: (string) ->
    text = " *#{string}* "
    start = ' *'.length
    end = start + string.length

    cursor = {start, end}
    {text, cursor}

  quote: (string) ->
    text = "\n> #{string}"
    start = '\n> '.length
    end = start + string.length

    cursor = {start, end}
    {text, cursor}

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
