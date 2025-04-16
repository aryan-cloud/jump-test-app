defmodule JumpTestApp.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JumpTestApp.Messages` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content",
        name: "some name"
      })
      |> JumpTestApp.Messages.create_message()

    message
  end
end
