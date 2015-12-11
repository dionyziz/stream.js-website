REPO_FOLDER = stream
MINI_FILES = stream.min.js stream.min.js.map
ZIP_FILE = stream.js.zip 
#STREAM_MINI_FILES := $(REPO_FOLDER)/stream.min.js $(REPO_FOLDER)/stream.min.js.map
STREAM_MINI_FILES := $(MINI_FILES:%=$(REPO_FOLDER)/%) #6.3.1 Substitution References

$(ZIP_FILE): $(STREAM_MINI_FILES)
	@cd $(REPO_FOLDER); \
	npm run zip ../$@ $(MINI_FILES)

$(STREAM_MINI_FILES):
	@cd $(REPO_FOLDER); \
	test -d "node_modules" || npm install; \
	echo "Running minify..."; \
	npm run minify;

update:
	@git submodule update --remote

clean:
	@rm --verbose $(ZIP_FILE) $(STREAM_MINI_FILES)

all: update $(ZIP_FILE)

.PHONY: update clean all
