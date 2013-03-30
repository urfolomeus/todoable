watch('lib/todoable/[^#].*\.rb') do |md|
  file_path = md[0]
  puts "Changed: #{file_path}"
  file_path.gsub!( 'lib/todoable', 'spec/' ).gsub!( '.rb', '_spec.rb' )
  run_spec file_path
end

watch( 'spec/[^#].*_spec\.rb' )  {|md| run_spec md[0] }

def run_spec( file_path )
  run_command("rspec -c -f documentation #{file_path}")
end

def run_command(command)
  start_time = Time.now
  system("clear")
  puts start_time
  puts "Running: `#{command}`"
  system(command)
  puts "Took: #{Time.now - start_time}"
end

