defmodule WebUi do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use WebUi, :controller
      use WebUi, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: WebUi
      import Plug.Conn
      import WebUi.Router.Helpers
      import WebUi.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/web_ui/templates",
                        namespace: WebUi

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import WebUi.Router.Helpers
      import WebUi.ErrorHelpers
      import WebUi.Gettext
      import WebUi.Formatters.Date
      import WebUi.Formatters.Currency
      import WebUi.Formatters.Percentage

      def render_shared(template, assigns \\ %{}) do
        render WebUi.SharedView, template, assigns
      end

      def render_stock_price(price) do
        render_shared "stock_price.html", price: price
      end

      def render_stock_shares(shares) do
        render_shared "stock_shares.html", share: shares
      end

      def render_stock_roi(ratio) do
        render_shared "rate-of-return.html", roi: ratio
      end
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import WebUi.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
