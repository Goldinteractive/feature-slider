import Flickity from 'flickity'

/**
 * Slider feature class.
 */
class Slider extends base.features.Feature {

  init() {
    this.node.classList.add('-hidden')

    window.setTimeout(() => {
      // fade in for no FOUC
      this.node.classList.remove('-hidden')
      // trigger redraw for transition
      this.node.offsetHeight

      this.flickity = new Flickity(this.node, this.options)

      // execute initial resize/reposition to make slides fit
      this.flickity.resize()
      this.flickity.reposition()
    }, 0)
  }

  destroy() {
    super.destroy()
    this.flickity.destroy()
  }

}

/**
 * Default feature options (also used to initialize flickity library).
 *
 * @see http://flickity.metafizzy.co/
 */
Slider.defaultOptions = {
  cellSelector: '.slide'
}

export default Slider
