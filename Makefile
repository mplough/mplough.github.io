.PHONY: serve
serve:
	bundle exec jekyll build --drafts --strict_front_matter
	bundle exec jekyll serve --watch --drafts --incremental

# Serve 0.0.0.0 so I can test the site on my phone
.PHONY: phone-serve
phone-serve:
	bundle exec jekyll build --drafts --strict_front_matter
	bundle exec jekyll serve --watch --drafts --incremental -H 0.0.0.0

.PHONY: setup
setup:
	rbenv install -s 3.3.6
	rbenv local 3.3.6
	bundle install

.PHONY: clean
clean:
	bundle exec jekyll clean
