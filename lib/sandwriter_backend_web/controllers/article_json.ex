defmodule SandwriterBackendWeb.ArticleJSON do
  alias SandwriterBackend.{
    Users.User,
    Articles.Article,
    Comments.Comment,
    ArticleTextSections.ArticleTextSection,
    ImageArticles.ImageArticle
  }

  import MapMerge

  def render("list_of_article_without_text_and_comments.json", %{articles: articles}) do
    for(
      {article, likes, dislikes, is_liked_by_current_user, is_disliked_by_current_user, comment_count} <-
        articles,
      do:
        render(
          "article_without_text_and_comments.json",
          article,
          likes,
          dislikes,
          is_liked_by_current_user,
          is_disliked_by_current_user,
          comment_count
        )
    )
  end

  defp render(
         "article_without_text_and_comments.json",
         article,
         likes,
         dislikes,
         is_liked_by_current_user,
         is_disliked_by_current_user,
         comment_count
       ) do
    Map.take(article, Article.get_viewable_fields()) |||
      %{
        likes: likes,
        dislikes: dislikes,
        is_liked_by_current_user: is_liked_by_current_user,
        is_disliked_by_current_user: is_disliked_by_current_user,
        author: Map.take(article.author, User.get_viewable_fields()),
        comment_count: comment_count
      }
  end

  def render("article.json", %{
        article: article,
        comments: comments,
        likes: likes,
        dislikes: dislikes,
        is_liked_by_current_user: is_liked_by_current_user,
        is_disliked_by_current_user: is_disliked_by_current_user,
        text_sections: text_sections,
        image_sections: image_sections
      }) do

    sections = Enum.map(text_sections, fn text_section ->
            Map.take(text_section, ArticleTextSection.get_viewable_fields()) |||
              %{section_type: "TEXT"}
          end) ++
            Enum.map(image_sections, fn image_section ->
              %{section_type: "IMAGE", image_base_64: Base.encode64(image_section.data)} |||
                Map.take(image_section, ImageArticle.get_viewable_fields())
            end)
    render(
      "article_without_text_and_comments.json",
      article,      
      likes,
      dislikes,
      is_liked_by_current_user,
      is_disliked_by_current_user,
      Enum.count(comments)
    ) |||
      %{
        comments:
          Enum.map(comments, fn comment ->
            Map.take(comment, Comment.get_viewable_fields()) |||
              %{
                author: Map.take(comment.author, User.get_viewable_fields())
              }
          end),
        sections: sections |> Enum.sort(& (&1.section_index <= &2.section_index))
      }
  end
end
