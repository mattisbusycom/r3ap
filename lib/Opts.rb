require "optparse"

class Opts

  # Takes a list of flags. If the flag is prefixed with a colon,
  # it's marked as optional.
  # 
  # Example `Opts.new("foo", "bar", ":lorem")`
  def initialize (*args)
    @options = {}
    OptionParser.new do |opt|
      args.each do |arg|
        arg = arg[/[^:]+/]
        opt.on("--" + arg + " " + arg.upcase) { |val| @options[arg.to_sym] = val }
      end
      opt.parse!
    end
    args.each do |arg|
      next if arg.match(/^:/)
      raise "Please define '--#{arg[/[^:]+/]}'." if @options[arg.to_sym].nil?
    end
  end

  # Getting an options value.
  # 
  # Params:
  # +option+:: The option's name
  def get (option)
    @options[option.to_sym] || false
  end

end