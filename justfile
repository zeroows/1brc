size := "1000000000"
file := "measurements_1000000000.txt"

# default:  Show help
default:
  @echo "\nOne Billion Row Challenge\nUsage: \n"
  @just --list

build:
  cargo build --release

# generate-input:  Generate input file
generate-input: build
  cargo run --release --bin generate_input -- {{size}}

# run-1brc:  Run 1brc's solution
run-1brc: build
  cargo run --release --bin 1brc -- {{file}}

# run-lucretiel:  Run Lucretiel's solution
run-lucretiel: build
  cargo run --release --bin lucretiel_1brc -- {{file}}

# run-hyperfine:  Run hyperfine
run-hyperfine: build
  hyperfine --warmup 1 --min-runs 3 --time-unit=second --export-json hyperfine.json "cargo run --release --bin 1brc {{file}}" "cargo run --release --bin lucretiel_1brc {{file}}"