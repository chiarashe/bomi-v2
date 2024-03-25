questions = [
  '¿Cómo te sientes el día de hoy?',
  '¿Que te hizo sentir asi?',
  '¿Te fue posible alimentarte?',
  'Si la respuesta es no, ¿por qué?',
  'Tipo de comida',
  '¿Qué alimentos y liquidos consumiste?',
  '¿Sentiste que comiste descontroladamente?',
  '¿Sentiste que comiste de forma balanceada?',
  '¿Cúal era tu nivel de hambre antes de comer?',
  '¿Cúal fue tu nivel de saciedad después de comer?',
  '¿Alguien te acompañó?',
  '¿Hay algo que quieras comentar o reflexionar sobre tu comida?',
]

questions.each do |question_title|
  Question.create!(title: question_title)
end
