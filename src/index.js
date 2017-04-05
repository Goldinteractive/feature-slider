import Flickity from 'flickity'
import 'flickity-imagesloaded'

/**
 * Slider feature class.
 */
class Slider extends base.features.Feature {

  init() {
    this.node.classList.add('-hidden')

    this.slides = this.$$(this.options.cellSelector)

    if (this.options.hidePageDotsWhenJustOneSlide && this.slides.length <= 1) {
      this.options.pageDots = false
      this.options.draggable = false
    }

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
  cellSelector: '.slide',
  hidePageDotsWhenJustOneSlide: true
}

export default Slider
