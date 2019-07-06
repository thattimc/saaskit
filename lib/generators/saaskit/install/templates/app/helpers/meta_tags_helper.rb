module MetaTagsHelper
  def default_meta_tags
    {
      site: "SaaSKit",
      reverse: true,
      charset: "utf-8",
      canonical: request.original_url,
      separator: "|",
      viewport: "width=device-width, initial-scale=1, shrink-to-fit=no",
      og: {
        site_name: "SaaSKit",
        type: "website",
        url: request.original_url,
      },
      twitter: {
        card: "summary",
        site: "@saaskitapp",
      },
    }
  end
end
