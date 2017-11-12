#Prueba 2 Desafío Latam
#repo https://github.com/tono77/prueba2.git

def read_file()
  file = File.open('notas.csv', 'r')
  data = file.readlines.map(&:chomp)
  file.close
  hash = {}
  data.each do |linea|
     arr = linea.split(",")
     key = arr.shift
     notas =  arr.map { |e| e.to_i }

     hash[key] = notas
  end
  return hash
end

def average_tofile(hash)
  hash.each do |key, value|
    file = File.open("#{key}.txt", 'w')
    value.map! { |nota| nota == 0 ? 1 : nota}
    file.puts "#{key}:#{value.sum / value.size.to_f}"
    file.close
  end
end

def absence_report(hash)
  inasistencias = []
  hash.each do |key, value|
    inasistencias += value.select {|nota| nota == 0}
  end
  return inasistencias.length
end

def approved(hash, nota)
  aprobados = []
  hash.each do |key,value|
    value.map! { |nota| nota == 0 ? 1 : nota}
    promedio = value.sum / value.size.to_f
    aprobados.push(key) if promedio >= nota
  end
  return aprobados
end

opt = 0
NOTA = 5
until opt == 4
  puts "\n\nIngresa una opcion [1-3], [4] para salir:"
  puts '[1] Generar archivos de resultado'
  puts '[2] Inasistencias totales'
  puts '[3] Alumnos aprobados'
  puts "[4] Salir\n\n"
  print ">"


  opt = gets.chomp.to_i
  hash = read_file()

  case opt
    when 1
      begin
        average_tofile(hash)
      rescue
        puts 'Algo salió mal'
      else
        puts 'Archivos generados'
      end

    when 2
      puts "El número de inasistencias fue: #{absence_report(hash)}"
    when 3
      puts "Los alumnos aprobados fueron: #{approved(hash, NOTA)}"
    when 4
      puts "designed in Labs"
      break
    else
      puts 'La opción que ingresaste no es válida'
    end
end
