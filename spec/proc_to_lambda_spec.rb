require_relative '../lib/proc-to-lambda'

class TryIt

  include ProcToLambda

  def demo
    to_lambda(proc {})
  end

  def foo
    'instance foo'
  end

  def self.foo
    'class foo'
  end

end

RSpec.describe ProcToLambda do

  it 'argument must be Proc, else should raise an error' do

    expect { ProcToLambda.to_lambda(nil) }.to raise_error(RuntimeError)
    expect { ProcToLambda.to_lambda('') }.to raise_error(RuntimeError)
    expect { ProcToLambda.to_lambda({}) }.to raise_error(RuntimeError)

  end

  it 'proc should convert to lambda' do

    my_proc = proc {}
    expect(ProcToLambda.to_lambda(my_proc).lambda?).to eq(true)

  end

  it 'supply lambda should return it self' do

    my_lambda = lambda {}
    expect(ProcToLambda.to_lambda(my_lambda)).to eq(my_lambda)

  end

  it 'should work with return' do

    my_proc = proc { return 1 }

    expect { my_proc.call }.to raise_error(LocalJumpError)
    expect(ProcToLambda.to_lambda(my_proc).call).to eq(1)

  end

  it 'should work with instance_eval / instance_exec' do

    # lambda should work with correct number of arguments.
    my_proc1  = proc { return self + 1 }
    my_proc2 = proc { |_| return self + 1 }
    foo_proc1 = proc { foo }
    foo_proc2 = proc { |_| foo }

    my_lambda1 = ProcToLambda.to_lambda(my_proc1)
    my_lambda2 = ProcToLambda.to_lambda(my_proc2)
    foo_lambda1 = ProcToLambda.to_lambda(foo_proc1)
    foo_lambda2 = ProcToLambda.to_lambda(foo_proc2)

    expect(1.instance_exec(&my_lambda1)).to eq(2)
    expect(1.instance_eval(&my_lambda2)).to eq(2)
    expect(TryIt.new.instance_exec(&foo_lambda1)).to eq(TryIt.new.foo)
    expect(TryIt.new.instance_eval(&foo_lambda2)).to eq(TryIt.new.foo)

  end

  it 'should work with class_exec / class_eval / module_exec / module_eval' do

    foo_proc1 = proc { foo }
    foo_proc2 = proc { |_| foo }

    foo_lambda1 = ProcToLambda.to_lambda(foo_proc1)
    foo_lambda2 = ProcToLambda.to_lambda(foo_proc2)

    expect(TryIt.class_exec(&foo_lambda1)).to eq(TryIt.foo)
    expect(TryIt.class_eval(&foo_lambda2)).to eq(TryIt.foo)
    expect(TryIt.module_exec(&foo_lambda1)).to eq(TryIt.foo)
    expect(TryIt.module_eval(&foo_lambda2)).to eq(TryIt.foo)

  end

  it 'module can be included, should work with instance method' do

    expect(TryIt.new.demo.lambda?).to eq(true)

  end

end