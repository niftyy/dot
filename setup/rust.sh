#!/usr/bin/env bash

. "$(dirname "$0")"/../helpers/setup.sh # Load helper script from dot/helpers.

set -ex

rust_crates=(
  # find_unicode                  # Find unicode.
  # oxipng                        # Compress png images.
  # svgcleaner                    # Remove unnecessary info from svgs.
  # tally                         # Nicer time (shows memory, page faults etc), I'm using hyperfine instead.
  cargo-edit                      # Gives `cargo {add,rm,upgrade}` commands.
  cobalt-bin                      # Static site generator (https://cobalt-org.github.io/).
  proximity-sort                  # Sort paths by proximity to a directory.
  clog-cli                        # Changelog generator.
)

# These are installed and updated through brew on Darwin.
if [[ $(uname) == Linux ]]; then
  rust_crates+=(
    # exa
    # watchexec                   # Like entr (evaluating which one is better).
    # xsv                         # csv manipulator.
    bat                         # Nicer cat with syntax highlighting etc.
    hyperfine                   # Benchmark commands (time but a benchmarking suite).
  )
fi

if [[ $USER == gib ]]; then
  if no rustup || no cargo; then # Install/set up rust.
    # Install rustup. Don't modify path as that's already in gibrc.
    RUSTUP_HOME="$XDG_DATA_HOME"/rustup CARGO_HOME="$XDG_DATA_HOME"/cargo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

    if [[ -d "$HOME/.rustup" ]]; then
      # Move to proper directories
      mv "$HOME/.rustup" "$XDG_DATA_HOME/rustup"
      mv "$HOME/.cargo" "$XDG_DATA_HOME/cargo"
    fi

    export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"

    # Install stable and nightly (stable should be a no-op).
    rustup install nightly
    rustup install stable

    # Make sure we have useful components:
    rustup component add --toolchain stable rust-analysis rust-src clippy rustfmt
    rustup component add --toolchain nightly rust-analysis rust-src clippy rustfmt
  else
    rustup update
    not cargo-install-update && cargo install cargo-update
    cargo install-update -ia "${rust_crates[@]}" # Update everything installed with cargo install.
  fi
fi
