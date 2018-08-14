(defmacro each [expr & body]
  `#(doseq [~expr %] (closh.macros/sh ~@body)))
