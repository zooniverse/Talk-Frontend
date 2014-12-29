module?.exports =
  hrefLink: (title, url) ->
    linkTitle = title or "Example Title"
    linkUrl = url or "http://www.example.com"

    " [#{linkTitle}](#{linkUrl}) "

  imageLink: (title, url) ->
    imageTitle = title or "Example Image"
    imageUrl = url or "http://www.example.com/image.png"

    " ![#{imageTitle}](#{imageUrl}) "

  bold: (text) ->
    " **#{text}** "

  italic: (text) ->
    " *#{text}* "

  getSelection: (input) ->
    input.value.substring(input.selectionStart, input.selectionEnd)

  insertAtCursor: (text, input) ->
    inputVal = input.value
    cursorPos = input.selectionStart or inputVal.length
    cursorEnd = input.selectionEnd or inputVal.length

    input.value = (inputVal.substring(0, cursorPos) + text + inputVal.substring(cursorEnd, inputVal.length))
    input.focus()

