# GenGuardian

Nice generators for Guardian

## Installation

  1. Add gen_guardian to your list of dependencies in `mix.exs`:
    ```elixir
      def deps do
        [{:gen_guardian, git: "https://github.com/victorlcampos/gen_guardian", only: :dev},
          {:comeonin, "~> 2.0"}]
      end
    ```

  2. You need conf Guardian first in `config/config.exs`
    ```elixir
      config :guardian, Guardian,
          issuer: "YourAppName",
          ttl: { 30, :days },
          secret_key: "Your Secret Key",
          serializer: YourAppName.GuardianSerializer
    ```

  3. run mix generator
    ```elixir
      mix guardian.gen.email_login YourAppName your_app_name
    ```

  4. run migrations
    ```elixir
      mix ecto.migrate
    ```
