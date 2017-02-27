import ObjectFit from 'gi-feature-object-fit'
import Slider from '../src'

base.features.add('fit', ObjectFit)

base.features.add('slider', Slider, {
  contain: true,
  prevNextButtons: false
})

base.features.add('gallery-slider', Slider, {
  imagesLoaded: true,
  percentPosition: false,
  contain: true,
  cellAlign: 'left',
  pageDots: false,
  freeScroll: true
})

base.features.add('fs-gallery-slider', Slider, {
  imagesLoaded: true,
  contain: true
})

base.features.add('cover-gallery-slider', Slider, {
  contain: true,
  cellAlign: 'left',
  pageDots: false,
  freeScroll: true
})

base.features.add('fs-cover-gallery-slider', Slider, {
  contain: true
})

base.features.init()
