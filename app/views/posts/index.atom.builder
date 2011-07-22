atom_feed do |feed|
  feed.title("Yannis Chatzimichos")
  feed.updated(@posts.first.created_at)

  for post in @posts
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.content, :type => 'html')

      entry.author do |author|
        author.name("Yannis Chatzimichos")
      end
    end
  end
end
