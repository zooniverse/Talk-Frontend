module?.exports =
  hrefLink: (title) ->
    if title
      " [#{title}](http://www.example.com) "
    else
      " [Example Title](http://www.example.com) "

  imageLink: (title) ->
    if title
      " ![#{title}](http://www.example.com/image.png) "
    else
      " ![Example Image](http://www.example.com/image.png) "

  insertAtCursor: (text, input) ->
    inputVal = input.value
    cursorPos = input.selectionStart ? inputVal.length
    cursorEnd = input.selectionEnd ? inputVal.length

    input.value = (inputVal.substring(0, cursorPos) + text + inputVal.substring(cursorEnd, inputVal.length))
