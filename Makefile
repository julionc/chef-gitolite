
all:
	BUNDLE_GEMFILE=test/support/Gemfile rake knife
	BUNDLE_GEMFILE=test/support/Gemfile rake foodcritic

clean:
	rm -rf tmp/

.PHONY: all clean
