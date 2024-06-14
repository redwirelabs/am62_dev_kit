defmodule AM62DevKit do
  @moduledoc """
  Nerves tooling for the AM62 dev kits.
  """

  @doc """
  Turn on/off the expansion header power rails.
  """
  @spec expansion_power(:on | :off) :: :ok
  def expansion_power(state) do
    value = if state == :on, do: 1, else: 0

    Circuits.GPIO.write_one("EXP_PS_3V3_En", value)
    Circuits.GPIO.write_one("EXP_PS_5V0_En", value)
  end

  Get the temperature of the CPU.
  """
  @spec cpu_temp(opts :: list) :: float
  def cpu_temp(opts \\ []) do
    i2c_ref = opts[:i2c_ref] || i2c_open!("i2c-1")
    temperature = tmp_get_temp(i2c_ref, 0x48)

    unless opts[:i2c_ref],
      do: Circuits.I2C.close(i2c_ref)

    temperature
  end

  @doc """
  Get the temperature of the memory.
  """
  @spec memory_temp(opts :: list) :: float
  def memory_temp(opts \\ []) do
    i2c_ref = opts[:i2c_ref] || i2c_open!("i2c-1")
    temperature = tmp_get_temp(i2c_ref, 0x49)

    unless opts[:i2c_ref],
      do: Circuits.I2C.close(i2c_ref)

    temperature
  end

  defp i2c_open!(name) do
    {:ok, ref} = Circuits.I2C.open(name)
    ref
  end

  # Texas Instruments TMPxxx temperature sensor
  defp tmp_get_temp(i2c_ref, address) do
    {:ok, data} = Circuits.I2C.read(i2c_ref, address, 2)

    <<temperature::signed-big-integer-size(12), _rest::size(4)>> = data
    temperature * 0.0625
  end
end
