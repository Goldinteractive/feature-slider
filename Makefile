# Import the environment variables
-include .env

LIBRARY_NAME=slider

NODE_MODULES=./node_modules
SCRIPTS_PATH=./.tasks
CONFIG_PATH=./.config

WEBPACK=$(NODE_MODULES)/.bin/webpack
POSTCSS=$(NODE_MODULES)/.bin/postcss
ESLINT=$(NODE_MODULES)/.bin/eslint
BROWSERSYNC=$(NODE_MODULES)/.bin/browser-sync

WEBPACK_CONFIG=$(CONFIG_PATH)/webpack.js
POSTCSS_CONFIG=$(CONFIG_PATH)/postcss.js
BROWSERSYNC_CONFIG=$(CONFIG_PATH)/browsersync.js
JSDOC_CONFIG=$(CONFIG_PATH)/jsdoc.json

SOURCE_PATH=./src
LIBRARY_PATH=./lib
ASSETS_PATH=./assets
DOCS_PATH=./jsdoc

DEV_PATH=./docs
DEV_CSS_PATH=$(DEV_PATH)/css
DEV_JS_PATH=$(DEV_PATH)/js


publish: jsdoc build
	@ npm publish

build: test js js-minified css

test:
	# check source with eslint
	@ $(ESLINT) $(SOURCE_PATH)

js:
	@ LIBRARY_NAME=$(LIBRARY_NAME) \
		LIBRARY_PATH=$(LIBRARY_PATH) \
		SOURCE_PATH=$(SOURCE_PATH) \
		$(WEBPACK) --config $(WEBPACK_CONFIG) \
		--progress --colors --display-error-details

js-minified:
	@ LIBRARY_NAME=$(LIBRARY_NAME) \
		LIBRARY_PATH=$(LIBRARY_PATH) \
		SOURCE_PATH=$(SOURCE_PATH) \
		$(WEBPACK) --config $(WEBPACK_CONFIG) \
		--progress --colors --display-error-details --env.mode=minified

jsdoc:
	# generate js documentation
	@ jsdoc -r \
		-R README.md \
		-c $(JSDOC_CONFIG) \
		-d $(DOCS_PATH) \
		$(SOURCE_PATH)

css: sass postcss

sass:
	# compile the sass files
	@ scss -I $(NODE_MODULES) \
		$(SOURCE_PATH)/style.scss:$(SOURCE_PATH)/style.scss.css \
		-r sass-json-vars

postcss:
	# modify the normal css with postcss
	@ ASSETS_PATH=$(ASSETS_PATH) \
		$(POSTCSS) --config $(POSTCSS_CONFIG) \
		$(SOURCE_PATH)/style.scss.css -o $(LIBRARY_PATH)/$(LIBRARY_NAME).css



dev:
	@ $(SCRIPTS_PATH)/utils/parallel \
		"make dev-sync" \
		"make dev-js" \
		"make dev-css"

dev-sync:
	# starting browser sync server for demo
	@ DEV_PATH=$(DEV_PATH) \
		DEV_JS_PATH=$(DEV_JS_PATH) \
		DEV_CSS_PATH=$(DEV_CSS_PATH) \
		BROWSER=$(BROWSERSYNC_BROWSER) \
		PORT=$(BROWSERSYNC_PORT) \
		$(BROWSERSYNC) start \
		--config $(BROWSERSYNC_CONFIG)

dev-js:
	# watch demo js
	@ LIBRARY_NAME=$(LIBRARY_NAME) \
		LIBRARY_PATH=$(LIBRARY_PATH) \
		SOURCE_PATH=$(SOURCE_PATH) \
		DEV_PATH=$(DEV_PATH) \
		DEV_JS_PATH=$(DEV_JS_PATH) \
		$(WEBPACK) --config $(WEBPACK_CONFIG) \
		--progress --colors --watch --display-error-details --env.mode=dev

dev-css:
	# watch demo sass
	@ $(SCRIPTS_PATH)/utils/parallel \
		"make dev-sass" \
		"make dev-postcss"

dev-sass:
	# watch the sass files
	@ scss -I $(NODE_MODULES) \
		$(DEV_PATH)/demo.scss:$(DEV_CSS_PATH)/demo.scss.css \
		-r sass-json-vars \
		--watch

dev-postcss:
	# watch generated css file with postcss
	@ ASSETS_PATH=$(ASSETS_PATH) \
	  $(POSTCSS) --config $(POSTCSS_CONFIG) \
		$(DEV_CSS_PATH)/demo.scss.css -o $(DEV_CSS_PATH)/demo.css \
		--watch
