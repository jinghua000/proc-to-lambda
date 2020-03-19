# proc-to-lambda

[![Build Status](https://travis-ci.org/jinghua000/proc-to-lambda.svg?branch=master)](https://travis-ci.org/jinghua000/proc-to-lambda)
[![Gem Version](https://badge.fury.io/rb/proc-to-lambda.svg)](https://rubygems.org/gems/proc-to-lambda)
[![Coverage Status](https://coveralls.io/repos/github/jinghua000/proc-to-lambda/badge.svg?branch=master)](https://coveralls.io/github/jinghua000/proc-to-lambda?branch=master)

## Introduction

Convert proc to lambda, retain the context.

## Install

```bash 
gem install 'proc-to-lambda'
```

## Usage

You can use the method directly by invoke the method `to_lambda` of `ProcToLambda`.

```ruby
my_proc = proc { return self + 1 }
my_lambda = ProcToLambda.to_lambda(my_proc)

# `return` works here, and can retain `self`
1.instance_exec(&my_lambda) # => 2
```

Or, you can `include` or `extend` the `ProcToLambda` module.

```ruby
include ProcToLambda

def foo
  to_lambda(proc {})
end
```

```ruby
# beware, this is risky.
Proc.extend(ProcTolambda)

Proc.to_lambda(proc {})
```

## More 

You can see also test cases.