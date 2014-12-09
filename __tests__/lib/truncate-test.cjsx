jest
  .dontMock '../../src/lib/truncate'

truncate = require '../../src/lib/truncate'

describe '#truncate', ->
  testString = [1..100].map(-> 'test').join('')

  it 'trims a string to the given length and adds elipses', ->
    expect(truncate(testString, 8)).toEqual('testtest...')

  it 'defaults to 250 chars', ->
    expect(truncate(testString).length).toEqual(250 + '...'.length)

  it 'trims trailing whitespace', ->
    wsString = 'whitespace        '
    expect(truncate(wsString)).toEqual('whitespace...')

  it 'does not modify strings shorter than the charLength', ->
    expect(truncate('shortstring', 30)).toEqual('shortstring')
    
    
