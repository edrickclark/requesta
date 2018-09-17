# http://blog.honeybadger.io/ruby-custom-exceptions/

class CustomError < StandardError

  attr_reader :foo

  def initialize(message="Default error message", foo='bar')
    @foo = foo
    super(message)
  end

  def report
    "\n\n" + 
    self.class.to_s + 
    ":\s" + 
    self.message + 
    "\n\n" + 
    self.backtrace.join("\n") + 
    "\n\n"
  end

end