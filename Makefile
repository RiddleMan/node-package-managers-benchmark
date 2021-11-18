.PHONY: run

mkfile_dir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

run:
	docker build -t node-version-managers-benchmark ./benchmark
	docker run --rm -v $(mkfile_dir)/benchmark/output:/benchmark/output -t node-version-managers-benchmark
