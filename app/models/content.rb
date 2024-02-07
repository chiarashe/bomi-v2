class Content < ApplicationRecord
  belongs_to :doctor

  CONTENT_TYPE = %w[Articulo Video Podcast Noticia Infografia Consejo]
  THEME_TYPE = %w[Salud Nutricion Ejercicio Mentalidad Otro]
end
