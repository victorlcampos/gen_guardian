defmodule <%= base %>.UserController do
  use <%= base %>.Web, :controller

  alias <%= base %>.User
  alias <%= base %>.SessionController

  plug Guardian.Plug.EnsureAuthenticated, [handler: SessionController] when not action in [:new, :create]
  plug :scrub_params, "user" when action in [:create, :update]

  def new(conn, _params) do
    changeset = User.save_changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.save_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> Guardian.Plug.sign_in(user, :token)
        |> redirect(to: user_path(conn, :show))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "show.html", user: user)
  end
end
