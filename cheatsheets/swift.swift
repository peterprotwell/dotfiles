// This is a comment
/* This is a
   multi-line comment */

// start a repl with `xcrun swift`
// run a cmd line program with xcrun swift filename.swift
// shebang with #!/usr/bin/xcrun swift -i

println("Hello world!")

// Types are inferred
var i = 123
var f = 4.2
var s = "pants"

// You can also specify them explicitly
var d: Double = 123.456

// Constant
let pi = "3.14159"

// String interpolation
println("I have no \(s)")

var a = 3, b = 2
"\(a) plus \(b) is \(a + b)"

// Arrays are declared with square brackets
var arr = [1, 2, 3, 4, 5]
var emptyArr = [String]()
// You can skip the type if type can be inferred
arr = []

// So are hashes
var hash = ["foo": "bar"]
var emptyHash = [String: String]()
// If type can be inferred
hash = [:]
