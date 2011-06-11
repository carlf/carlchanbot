require 'cinch'

class AsciiArt
  include Cinch::Plugin

  match(/aa list$/, method: :aa_list)
  match(/aa (.+)$/)

  def execute(m, file)
    if(file =~ /[^a-zA-Z0-9_]/)
      return
    else
      if(File::exists?("asciiart/#{file}"))
        IO.foreach("asciiart/#{file}") {|line| m.reply line}
      end
    end
  end

  def aa_list(m)
    Dir.chdir('asciiart') do
      m.reply Dir.glob('*').sort.join(', ')
    end
  end
        
end
