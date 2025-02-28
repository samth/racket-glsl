#lang racket/base

(require glsl
         racket/sandbox
         scribble/examples
         scribble/manual)

(provide (all-defined-out))

(define (rtech . args)
  (apply tech #:doc '(lib "scribblings/reference/reference.scrbl") args))

(define (gtech . args)
  (apply tech #:doc '(lib "scribblings/guide/guide.scrbl") args))

(define glsl-evaluator
  (call-with-trusted-sandbox-configuration
   (λ ()
     (parameterize ([sandbox-output       'string]
                    [sandbox-error-output 'string])
       (make-base-eval #:lang 'racket/base '(void)))))) 

(define-syntax-rule (example expr ...)
  (examples #:eval glsl-evaluator #:label #f expr ...))
