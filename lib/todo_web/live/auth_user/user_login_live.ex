defmodule TodoWeb.UserLoginLive do
  use TodoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="bg-red-200 px-5 py-5 rounded-3 shadow-full">
      <div class="mx-auto max-w-sm">
        <.header class="text-center">
          Sign in to account
          <:subtitle>
            Don't have an account?
            <.link navigate={~p"/users/register"} class="font-semibold text-brand hover:underline">
              Sign up
            </.link>
            for an account now.
          </:subtitle>
        </.header>

        <.simple_form
          :let={f}
          id="login_form"
          for={:user}
          action={~p"/users/log_in"}
          as={:user}
          phx-update="ignore"
        >
          <.input field={{f, :email}} type="email" label="Email" required />
          <.input field={{f, :password}} type="password" label="Password" required />

          <:actions :let={f}>
            <.input field={{f, :remember_me}} type="checkbox" label="Keep me logged in" />
            <.link href={~p"/users/reset_password"} class="text-sm font-semibold">
              Forgot your password?
            </.link>
          </:actions>
          <:actions>
            <.button phx-disable-with="Sigining in..." class="w-full">
              Sign in <span aria-hidden="true">→</span>
            </.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = live_flash(socket.assigns.flash, :email)
    {:ok, assign(socket, email: email), temporary_assigns: [email: nil]}
  end
end
