.phony: serve
serve:
	bundle exec jekyll serve --watch --drafts --incremental

.phony: setup
setup:
	bundle install

.phony: clean
clean:
	git clean -dfx
