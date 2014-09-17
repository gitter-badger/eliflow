.PHONY: release compile get-deps clean deep-clean

release: compile
	mix release

offline:
	mix compile
	mix release

compile: get-deps
	mix compile

get-deps:
	mix deps.get

clean:
	mix clean

deep-clean: clean
	mix deps.clean
