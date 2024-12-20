module User::MetaTaggable
  extend ActiveSupport::Concern #Good Concern use

  # Include helper modules to allow URL generation and asset management.
  # `Rails.application.routes.url_helpers` gives access to route helpers like `rails_blob_url`.
  include Rails.application.routes.url_helpers

  def to_meta_tags
    tags = {
      site: "Perfect Pals",
      title: full_name,
      description: bio.present? ? bio.truncate_words(20) : "Default description", # Add nil check
      og: {
        title: full_name,
        description: bio.present? ? bio.truncate_words(20) : "Default description", # Add nil check
        site_name: "Perfect Pals"
      }
    }

    if photo.attached?
      tags[:image] =  rails_blob_url(photo)
      tags[:og][:image] = rails_blob_url(photo)
    end

    tags
  end
end
