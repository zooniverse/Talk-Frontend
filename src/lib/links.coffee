module?.exports =
  root: -> "http://www.zooniverse.org"

  # Zooniverse-Wide Talk

  talk: ->
    @root() + '/talk'

  board: (boardName) ->
    @talk() + '/' + boardName

  thread: (boardName, threadId) ->
    @board(boardName) + '/' + threadId

  post: (boardName, threadId, postId) ->
    @thread(boardName, threadId) + '#' + postId

  # Project-Specific Talk

  projectTalk: (ownerName, projectName) ->
    @root() + '/' + ownerName + '/' + projectName

  projectBoard: (ownerName, projectName, boardName) ->
    @projectTalk(ownerName, projectName) + '/' + boardName

  projectThread: (ownerName, projectName, boardName, threadId) ->
    @projectBoard(ownerName, projectName, boardName) + '/' + threadId

  projectPost: (ownerName, projectName, boardName, threadId, postId) ->
    @projectThread(ownerName, projectName, boardName, threadId) + '#' + postId

  # Messages

  messages: ->
    @root() + '/messages'

  message: (messageId) ->
    @messages() + '/' + messageId

  # Collections

  collection: (userLogin, collectionName) ->
    @root() + '/' + userLogin + '/' + collectionName

  collectionSubject: (userLogin, collectionName, subjectId) ->
    @collection(userLogin, collectionName) + '/' + subjectId

  hashtag: (tagName) ->
    @root() + '/hashtag/' + tagName

  # User

  user: (userLogin) ->
    @root() + '/users/' + userLogin
