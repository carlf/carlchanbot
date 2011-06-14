require 'cinch'

class AsciiArt
  include Cinch::Plugin

  match(/aa list$/, method: :aa_list)
  match(/aa (.+)$/)

  def execute(m, file)
    if(file =~ /[^a-zA-Z0-9_]/)
      return
    else
      if(File::exists?("data/ascii_art/#{file}"))
        IO.foreach("data/ascii_art/#{file}") {|line| m.reply line}
      end
    end
  end

  def aa_list(m)
    Dir.chdir('data/ascii_art') do
      m.reply Dir.glob('*').sort.join(', ')
    end
  end
        
end
