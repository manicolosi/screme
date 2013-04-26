# Screme

Screme is a really basic Scheme interpretor written in Ruby. This was built as
toy for learning and is not intended to be a serious language to write code in.

I don't intend to do anything with this, consider this public domain
abandonware.

I figure its better off on GitHub than getting lost on my hard drive. I've done
a minimal amount of work to add this README file and add bundler support.
Otherwise, this project hasn't been touched since around 2010.

## Usage

Screme provides a Read-Eval-Print-Loop where you can evaluate Screme code on the
fly:

```console
$ rake repl
Screme REPL
>
```

Here's a function that computes the n<sup>th</sup> number of the Fibonacci
sequence (note that Screme is not tail-recursive):

```scheme
(define fib
  (lambda (n)
    (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2))))))
```

## Running test suites

Scheme has three test suites:

1. Specs written in Ruby that tests most parts of the implementation of the
   interpretor. You can run them with just `rake spec`.
2. Native functional tests written in Screme. This tests the languages runtime
   among other thigns. You can run them with `cd test && ruby native_test.rb *.scm`.
