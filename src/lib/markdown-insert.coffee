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
    cursorPos = input.selectionStart ? inputVal.length
    cursorEnd = input.selectionEnd ? inputVal.length

    input.value = (inputVal.substring(0, cursorPos) + text + inputVal.substring(cursorEnd, inputVal.length))
    input.focus()

    # search from cursor position forward for selection at beginning of method,
    # or maybe cursor position as fallback
    # re-focus and
    # add cursor back at that the index of the end of that spot
    # plus any characters that were appended before it by markdown (length)
