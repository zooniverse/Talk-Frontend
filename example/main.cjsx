React = require 'react'
{ExampleComponent, CommentBox} = require '../src/index'

React.render <CommentBox />, document.getElementById('app')

console.log 'main'
