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

base.features.add('fw-gallery-slider', Slider, {
  imagesLoaded: true,
  contain: true
})

base.features.add('cover-slider', Slider, {
  contain: true,
  cellAlign: 'left',
  pageDots: false,
  freeScroll: true
})

base.features.add('fw-cover-slider', Slider, {
  contain: true
})

base.features.add('event-slider', Slider, {
  contain: true,
  listeners: [
    {
      event: 'select',
      handler: (flickity) => {
        console.log('selected', flickity)
      }
    },
    {
      event: 'settle',
      handler: (flickity) => {
        console.log('settled', flickity)
      }
    }
  ]
})

base.features.init()
