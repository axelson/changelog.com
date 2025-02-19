defmodule ChangelogWeb.Admin.PersonView do
  use ChangelogWeb, :admin_view

  alias Changelog.Person
  alias ChangelogWeb.PersonView
  alias ChangelogWeb.Admin.{EpisodeView, EpisodeRequestView, NewsItemView}

  def avatar_url(person), do: PersonView.avatar_url(person)
  def episode_count(person), do: Person.episode_count(person)

  def is_subscribed(person, thing), do: PersonView.is_subscribed(person, thing)

  def list_of_links(person) do
    [
      %{value: person.email, icon: "envelope", url: "mailto:#{person.email}"},
      %{
        value: person.twitter_handle,
        icon: "twitter",
        url: SharedHelpers.twitter_url(person.twitter_handle)
      },
      %{
        value: person.github_handle,
        icon: "github",
        url: SharedHelpers.github_url(person.github_handle)
      },
      %{
        value: person.linkedin_handle,
        icon: "linkedin",
        url: SharedHelpers.linkedin_url(person.linkedin_handle)
      },
      %{value: person.website, icon: "share", url: person.website}
    ]
    |> Enum.reject(fn x -> x.value == nil end)
    |> Enum.map(fn x ->
      ~s{<a href="#{x.url}" class="ui icon button" target="_blank"><i class="#{x.icon} icon"></i></a>}
    end)
    |> Enum.join("")
  end

  def post_count(person), do: Person.post_count(person)
end
