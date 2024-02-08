questions = [
  'Tipo de comida',
  '¿Te fue posible alimentarte?',
  'Si la respuesta es no, ¿por qué?',
  '¨Pudiste seguir las recomendaciones de tu médico?',
  '¿Si la respuesta es no, por qué?',
  '¿Cómo te sientes el día de hoy?',
  '¿Alguien te acompañó?',
  'Nivel de hambre',
  'Nivel de saciedad',
  '¿Tuviste un atracón?',
  '¿Tienes una duda o pensamiento?'
]

questions.each do |question_title|
  Question.create!(title: question_title)
end
