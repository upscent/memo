defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "exercises of Programing Elixir"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{ status: _, body: body }}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  def handle_response({_, %{ status_code: _, body: body }}) do
    {:error, Poison.Parser.parse!(body)}
  end
end