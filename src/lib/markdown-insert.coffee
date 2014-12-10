module?.exports =
  hrefLink: ->
    ' [http://www.example.com](Example Title) '

  imageLink: ->
    ' ![alt text](http://www.example.com/image.jpg "Title") '

  insertAtCursor: (text, input) ->
    inputVal = input.value
    cursorPos = input.selectionStart ? inputVal.length

    input.value = (inputVal.substring(0, cursorPos) + text + inputVal.substring(cursorPos, inputVal.length))
