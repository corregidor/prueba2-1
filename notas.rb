#Lee archivo de notas, lo mete en un hash de arreglos y realiza las operaciones:
# - promedio y lo deja en un archivo
# - cantidad total de ausencias
# - alumnos aprobados


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

def average(hash)
  arr = []
  hash.each do |key, value|
    value.map! { |nota| nota == 0 ? 1 : nota}
    arr.push("#{key}" + ":" + "#{value.sum / value.size.to_f}")
  end
  return arr
end

def tofile(array)
  array.each do |alumno|
    file = File.open("#{alumno.split(':').first}.txt", 'w')
    file.puts "#{alumno}"
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

def approved(arr, nota)
  aprobados = []
  str = ''
  arr.each {|value| aprobados.push(value.split(':'))}
  aprobados.select! {|alumno| alumno.last.to_f >= nota}
  aprobados.each do |apro|
    str += apro.first + ':' + apro.last + ' '
  end
  return str
end

opt = 0
NOTA = 5
until opt == 4
  puts "\n\nIngresa una opcion [1-3], [4] para salir:"
  puts '[1] Generar archivos de promedios'
  puts '[2] Inasistencias totales'
  puts '[3] Alumnos aprobados'
  puts "[4] Salir\n\n"
  print ">"


  opt = gets.chomp.to_i
  hash = read_file()

  case opt
    when 1
      begin
        tofile(average(hash))
      rescue
        puts 'Algo salió mal'
      else
        puts 'Archivos generados'
      end

    when 2
      puts "El número de inasistencias fue: #{absence_report(hash)}"
    when 3
      puts "Los alumnos aprobados fueron: #{approved(average(hash), NOTA)}"
    when 4
      puts "designed in Labs"
      break
    else
      puts 'La opción que ingresaste no es válida'
    end
end
