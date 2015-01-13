React = require 'react'

# for collection view?

module?.exports = React.createClass
  displayName: 'TalkViewableImages'

  # render pseudocode
  # display a bunch of images
  # display an image viewer with those images
  # when a user clicks on one


  render: ->
    imageViewer = <ImageViewer images={} />

    <div className="talk-viewable-images">
      onclick imageViewer.display(some-image)
      {imageViewer}
    </div>
    
