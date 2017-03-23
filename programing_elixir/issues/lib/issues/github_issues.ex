defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "exercises of Programing Elixir"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    IO.puts "Issues.GithubIssues.fetch"
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    IO.puts "handle_response, :ok"
    {:ok, Poison.Parser.parse!(body)}
  end

  def handle_response({_, %HTTPoison.Response{body: body}}) do
    {:error, Poison.Parser.parse!(body)}
  end
end
