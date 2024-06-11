# AM62DevKit

Nerves tooling for the AM62 dev kits.

## Installation

This package can be installed by adding `am62_dev_kit` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:am62_dev_kit, "~> 0.1.0"}
  ]
end
```

Create an alias in the Nerves application at `/rootfs_overlay/etc/iex.exs` if
you would like to type a shorter name for the module in the IEx prompt.

```elixir
alias AM62DevKit, as: DK
```
