React = require 'react'
marked = require 'marked'
emojify = require 'emojify.js'

renderer = new marked.Renderer()

renderer.image = (href, title, text) ->
  [width, height] = title.split(/[x]/i) if title

  widthAttr = if width then "width=#{width}" else ''
  heightAttr = if height then "height=#{height}" else ''

  "<img src=#{href} alt=#{text} #{widthAttr} #{heightAttr} />"

EMOJI_ROOT = 'http://www.tortue.me/emoji'

module?.exports = React.createClass
  displayName: 'TalkCommentPreview'

  propTypes:
    content: React.PropTypes.string
    header: React.PropTypes.string

  markdownOptions:
    sanitize: true
    gfm: true
    tables: true
    breaks: true
    renderer: renderer

  getDefaultProps: ->
    header: "Preview"

  replaceSymbols: (string) ->
    string
      .replace(/@(\w+)/g, "<a href='http://www.zooniverse.org/user/$1'>$1</a>") # user mentions
      .replace(/\^([A-Za-z]+[0-9]+)/g, "<a href='http://www.zooniverse.org/subjects/$1'>$1</a>") # subject mentions
      .replace(/\#(\w+)/g, "<a href='http://www.zooniverse.org/tags/$1'>#$1</a>") # hashtags

  markdownify: (input) ->
    marked input, @markdownOptions, (err, content) =>
      throw err if err
      return @replaceSymbols(content)

  emojify: (input) ->
    emojify.replace input, (match, icon) ->
      "<img class='talk-emoji' src='#{EMOJI_ROOT}/#{icon}.png' alt='#{match}' title='#{match}' />"

  render: ->
    html = @emojify(@markdownify(@props.content ? ''))

    <div className='talk-comment-preview'>
      <h1>{@props.header}</h1>
      <div className='talk-comment-preview-content' dangerouslySetInnerHTML={__html: html}></div>
    </div>
