jest
  .dontMock '../../src/lib/links'

links = require '../../src/lib/links'


describe 'links', ->
  root = 'http://www.zooniverse.org'

  describe 'zooniverse wide', ->
    it '#root', ->
      expect(links.root()).toEqual(root)

    it '#board', ->
      board = root + '/talk/testboard'
      expect(links.board('testboard')).toEqual(board)

    it '#thread', ->
      thread = root + '/talk/testboard/testthread'
      expect(links.thread('testboard', 'testthread')).toEqual(thread)

    it '#post', ->
      post = root + '/talk/testboard/testthread#testpost'
      expect(links.post('testboard', 'testthread', 'testpost')).toEqual(post)

  describe 'project specific', ->
    it '#projectTalk', ->
      projectTalk = root + '/testowner/testname'
      expect(links.projectTalk('testowner', 'testname')).toEqual(projectTalk)

    it '#projectBoard', ->
      projectBoard = root + '/testowner/testname/testboard'
      expect(links.projectBoard('testowner', 'testname', 'testboard')).toEqual(projectBoard)

    it '#projectThread', ->
      projectThread = root + '/testowner/testname/testboard/testthread'
      expect(links.projectThread('testowner', 'testname', 'testboard', 'testthread')).toEqual(projectThread)

    it '#projectPost', ->
      projectPost = root + '/testowner/testname/testboard/testthread#testpost'
      expect(links.projectPost('testowner', 'testname', 'testboard', 'testthread', 'testpost')).toEqual(projectPost)

  describe 'messages', ->
    it '#messages', ->
      messages = root + '/messages'
      expect(links.messages()).toEqual(messages)

    it '#message', ->
      message = root + '/messages/testmessage'
      expect(links.message('testmessage')).toEqual(message)

  describe 'collections', ->
    it '#collection', ->
      collection = root + '/testuser/testcollection'
      expect(links.collection('testuser', 'testcollection')).toEqual(collection)

    it '#collectionSubject', ->
      collectionSubject = root + '/testuser/testcollection/testsubject'
      expect(links.collectionSubject('testuser', 'testcollection', 'testsubject')).toEqual(collectionSubject)

    it '#hashtag', ->
      tagUrl = root + '/hashtag/tag'
      expect(links.hashtag('tag')).toEqual(tagUrl)

  describe 'user', ->
    it '#user', ->
      user = root + '/users/testuser'
      expect(links.user('testuser')).toEqual(user)
