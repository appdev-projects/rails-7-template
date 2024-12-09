module User::MetaTaggable
  extend ActiveSupport::Concern

  # Include helper modules to allow URL generation and asset management.
  # `Rails.application.routes.url_helpers` gives access to route helpers like `rails_blob_url`.
  include Rails.application.routes.url_helpers

  def to_meta_tags
    tags = {
      site: "Perfect Pals",
      title: user_name,
      description: bio.truncate_words(20),
      og: {
        title: user_name,
        description: bio.truncate_words(20),
        site_name: "Perfect Pals",
      }
    }

     if avatar.present?
        tags[:image] = avatar
        tags[:og][:image] = avatar
     end

    tags
  end

  def user_name
    "#{first_name} #{last_name}"
  end
end
