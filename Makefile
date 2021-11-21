.DEFAULT_GOAL := run
.PHONY: run clean combine_output

mkfile_dir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
out_dir := "./benchmark/output"
combined := $(out_dir)/combined.md

benchmark/output/*_*.md:

benchmark/output/combined.md: benchmark/output/*_*.md
	cat $(out_dir)/1_startup_without_node.md >> $(combined)
	echo "\n" >> $(combined)
	cat $(out_dir)/2_startup_with_node.md >> $(combined)
	echo "\n" >> $(combined)
	cat $(out_dir)/3_installation_of_node.md >> $(combined)
	echo "\n" >> $(combined)
	cat $(out_dir)/4_switching_node_versions.md >> $(combined)

combine_output: benchmark/output/combined.md

clean:
	rm -Rf benchmark/output

run_bechmark:
	docker build -t node-version-managers-benchmark ./benchmark
	docker run --rm -v $(mkfile_dir)/benchmark/output:/benchmark/output -t node-version-managers-benchmark

run: clean run_bechmark combine_output
