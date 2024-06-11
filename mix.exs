defmodule AM62DevKit.MixProject do
  use Mix.Project

  def project do
    [
      app: :am62_dev_kit,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs(),
      dialyzer: [
        ignore_warnings: "dialyzer.ignore.exs",
        list_unused_filters: true,
        plt_file: {:no_warn, plt_file_path()},
      ],
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    [
      "docs.show": ["docs", &open("doc/index.html", &1)],
    ]
  end

  defp deps do
    [
      {:circuits_i2c, "~> 2.0"},
      {:dialyxir, "~> 1.4", only: :dev, runtime: false},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
    ]
  end

  defp description do
    """
    Nerves tooling for the AM62 dev kits
    """
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "LICENSE.txt"]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/redwirelabs/am62_dev_kit"},
      maintainers: ["Alex McLain"],
      files: [
        "lib",
        "mix.exs",
        "LICENSE.txt",
        "README.md",
      ]
    ]
  end

  # Open a file with the default application for its type.
  defp open(file, _args) do
    open_command =
      System.find_executable("xdg-open") # Linux
      || System.find_executable("open")  # Mac
      || raise "Could not find executable 'open' or 'xdg-open'"

    System.cmd(open_command, [file])
  end

  # Path to the dialyzer .plt file.
  defp plt_file_path do
    [Mix.Project.build_path(), "plt", "dialyxir.plt"]
    |> Path.join()
    |> Path.expand()
  end
end
