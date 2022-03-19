.phony: serve
serve:
	bundle exec jekyll build --drafts --strict_front_matter
	bundle exec jekyll serve --watch --drafts --incremental

# Serve 0.0.0.0 so I can test the site on my phone
.phony: phone-serve
phone-serve:
	bundle exec jekyll build --drafts --strict_front_matter
	bundle exec jekyll serve --watch --drafts --incremental -H 0.0.0.0

.phony: setup
setup:
	bundle install

.phony: clean
clean:
	bundle exec jekyll clean
