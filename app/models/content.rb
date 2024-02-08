class Content < ApplicationRecord
  belongs_to :doctor
  has_many_attached :photos

  CONTENT_TYPE = %w[Articulo Video Podcast Noticia Infografia Consejo]
  THEME_TYPE = %w[Salud Nutricion Ejercicio Mentalidad Otro]
end
