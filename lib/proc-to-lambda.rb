module ProcToLambda

  VERSION = '0.1.0'.freeze

  # Same as the class method +to_lambda+
  #
  # Use to +include+
  def to_lambda(source_proc)
    ::ProcToLambda.to_lambda(source_proc)
  end

  # Convert proc to lambda, retain the context.
  #
  # @param [Proc] source_proc
  # @example
  #   my_proc = proc { return self + 1 }
  #   my_lambda = ProcToLambda.to_lambda(my_proc)
  #
  #   1.instance_exec(&my_lambda) # => 2
  def self.to_lambda(source_proc)
    raise "Supplied argument must be a `Proc`" unless source_proc.is_a?(::Proc)

    return source_proc if source_proc.lambda?

    unbound_method = ::Module.new.module_eval do
      instance_method(define_method(:_, &source_proc))
    end

    lambda do |*args, &block|
      unbound_method.bind(self).call(*args, &block)
    end
  end

end