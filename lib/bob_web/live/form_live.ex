defmodule BobWeb.FormLive do
  use Phoenix.HTML
  use Phoenix.LiveView

  import BobWeb.ErrorHelpers
  import Ecto.Changeset

  def mount(_params, _session, socket) do
    data = {%{}, %{email: :string, name: :string}}
    changeset = cast(data, %{}, [:email, :name])
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns) do
    ~L"""
    <p class="alert alert-info" role="alert"><%= live_flash(@flash, :info) %></p>
    <p class="alert alert-danger" role="alert"><%= live_flash(@flash, :error) %></p>
    <%= f = form_for @changeset, "#", [phx_change: :validate, phx_submit: :save, as: :form] %>
      <%= label f, :email %>
      <%= text_input f, :email %>
      <%= error_tag f, :email %>

      <%= label f, :name %>
      <%= text_input f, :name %>
      <%= error_tag f, :name %>

      <div style="display: flex; justify-content: flex-end;">
        <%= submit "Save" %>
      </div>
    </form>
    """
  end

  def handle_event("validate", %{"form" => params}, socket) do
    data = {%{}, %{email: :string, name: :string}}

    cast(data, params, [:email, :name])
    |> validate_unique(:email)
    |> Map.put(:action, :update)
    |> case do
      %Ecto.Changeset{valid?: true} ->
        {:noreply, socket}

      changeset ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("save", %{"form" => params}, socket) do
    data = {%{}, %{email: :string, name: :string}}

    cast(data, params, [:email, :name])
    |> validate_required([:name, :email], message: "cannot be blank")
    |> validate_length(:name, min: 5)
    |> validate_format(:email, ~r/[^@]+@[^\.]+\..+/)
    |> Map.put(:action, :update)
    |> case do
      %Ecto.Changeset{valid?: true} ->
        {:noreply,
         socket
         |> put_flash(:info, "User has been created!")
         |> redirect(to: "/")}

      changeset ->
        {:noreply,
         socket
         |> put_flash(:error, "Please fix the error below and try again!")
         |> assign(changeset: changeset)}
    end
  end

  defp validate_unique(changeset, field) do
    case get_change(changeset, field) do
      "cadebward@gmail.com" -> add_error(changeset, field, "email is in use")
      _ -> changeset
    end
  end
end
