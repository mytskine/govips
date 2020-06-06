# govips [![Build Status](https://travis-ci.org/davidbyttow/govips.svg)](https://travis-ci.org/davidbyttow/govips) [![GoDoc](https://godoc.org/github.com/davidbyttow/govips?status.svg)](https://godoc.org/github.com/davidbyttow/govips) [![Go Report Card](http://goreportcard.com/badge/davidbyttow/govips)](http://goreportcard.com/report/davidbyttow/govips) ![License](https://img.shields.io/badge/license-MIT-blue.svg)

# Why a fork?

Upstream has been unresponsive for 10 months (as of 2020-02, last commit was 2019-03-04).
Issues and Pull Requests are pending.

This forks adds:

- operators for a full install of Vips 8.9.0 (e.g. `Magickload()`, `Rotate()` and `Transpose3D()`)
- operators that use the type arraydouble (e.g. `DrawMask()` and `Getpoint()`)
- operator `HasAlpha()`
- README fixes and enhancements

See comments at top of [operators.go](pkg/vips/operators.go) for a list of still unsupported operators.


# A libvips library for Go
This package wraps the core functionality of [libvips](https://github.com/libvips/libvips) image processing library by exposing all image operations on first-class types in Go. Additionally, it exposes raw access to call operations directly, for forward compatibility.

The intent for this is to enable developers to build extremely fast image processors in Go, which is suited well for concurrent requests.
How fast is libvips? See this: [Speed and Memory Use](https://github.com/libvips/libvips/wiki/Speed-and-memory-use)
Libvips is generally 4-8x faster than other graphics processors such as GraphicsMagick and ImageMagick.

This library was inspired primarily based on the C++ wrapper in libvips.

# Supported image operations
This library supports most known operations available to libvips found here:
- [VIPS function list](http://libvips.github.io/libvips/API/current/VipsImage.html)
- [VipsImage](http://libvips.github.io/libvips/API/current/VipsImage.html)
- [VipsOperation](http://libvips.github.io/libvips/API/current/VipsOperation.html)

See comments at top of [operators.go](pkg/vips/operators.go) for a list of unsupported operators.

# Requirements
- [libvips](https://github.com/libvips/libvips) 8+ (8.5.8+ recommended for GIF, PDF, SVG support)
- C compatible compiler such as gcc 4.6+ or clang 3.0+
- Go 1.9+

# Installation
If your program uses modules:
```bash
# import the module in some go file, then
go mod tidy
```

If your program uses GOPATH:
```bash
go get -u github.com/davidbyttow/govips/pkg/vips
```

# Example usage
```go
// Resize an image with padding
return vips.NewTransform().
	LoadFile(inputFile).
	PadStrategy(vips.ExtendBlack).
	Resize(1200, 1200).
	OutputFile(outputFile)
```
See [transform.go](pkg/vips/transform.go) for the list of chainable operators.

When you need more control, or if the goal is not to convert an image into an image,
you need the lower level API which id ported from libvps.

A (contrived) example which replicates the C API:
```go
// ignoring errors for simplicity
image, _ := vips.NewImageFromFile(file)
defer image.Close()
lch, _ := vips.Colourspace(image, vips.InterpretationLCH)
pixel, _ := vips.Getpoint(lch, 0, 0)
return piwel[0], nil
```

Most operators can return their result *into a new value* or *in-place*:
```
// create a new Image (the histogram is an image)
hist, err := vips.HistFind(image)
// OR replace imageRef's content with its histogram image
err := imageRef.HistFind()
```

# Contributing
In short, feel free to file issues or send along pull requests. See this [guide on contributing](https://github.com/davidbyttow/govips/blob/master/CONTRIBUTING.md) for more information.

# Credits
Thank you to [John Cupitt](https://github.com/jcupitt) for maintaining libvips and providing feedback on vips.

# License
MIT - David Byttow
