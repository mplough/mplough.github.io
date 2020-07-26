.phony: serve
serve:
	bundle exec jekyll build --drafts --strict_front_matter
	bundle exec jekyll serve --watch --drafts --incremental

.phony: setup
setup:
	bundle install

.phony: clean
clean:
	bundle exec jekyll clean
