## `slider` feature

Slider feature for carousel functionality using [flickity](http://flickity.metafizzy.co/).

### Global dependencies

* [`gi-js-base`](https://github.com/Goldinteractive/js-base)

### Dependencies

* [`flickity`](http://flickity.metafizzy.co/)

### Installation

Install this package with sackmesser:

    make feature-install-slider

or when sackmesser is not used:

    yarn install gi-feature-slider

After the installation has completed, you can import the module files:

#### JS:

```javascript
// import feature class
import Slider from 'gi-feature-slider'
// ...
base.features.add('slider', Slider)
```

Make sure you provide the global dependencies in your webpack config file:

```javascript
new webpack.ProvidePlugin({
  base: 'gi-js-base'
})
```

#### Styles:

```sass
@import 'gi-feature-slider/src/style';
```

### Browser compatibility

* Newest two browser versions of Chrome, Firefox, Safari and Edge
* IE 10 and above

### Development

* `make build` or `npm run build` - Build production version of the feature.
* `make dev` or `npm run dev` - Build demo of the feature, run a watcher and start browser-sync.
* `make test` or `npm run test` - Test the feature.
* `make jsdoc` - Update documentation inside the `docs` folder.
* `make publish` - Publish npm package.
