# DHQueryString

[![Version](https://img.shields.io/cocoapods/v/DHQueryString.svg?style=flat)](http://cocoapods.org/pods/DHQueryString)
[![License](https://img.shields.io/cocoapods/l/DHQueryString.svg?style=flat)](http://cocoapods.org/pods/DHQueryString)
[![Platform](https://img.shields.io/cocoapods/p/DHQueryString.svg?style=flat)](http://cocoapods.org/pods/DHQueryString)

QueryString Encoder/Decoder For Swift

## Usage

You use the `DHQueryString` class to convert dicionary or query string.

## Requirements

## Installation

DHQueryString is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DHQueryString"
```

### Example

~~~swift
let queryString = "name=Hottin&age=24"
let dictionary = DHQueryString.toDictionary(queryString)
// dictionary == ["name":"Hottin", "age":"24"]

let dictionary: ["name":"Tatsuya Hotta", "age":"24"]
let queryString = DHQueryString.toString(dictionary)

// queryString == "name=Tatsuya%20Hotta&age=24"
~~~

## Author

Tatsuya Hotta

## License

DHQueryString is available under the MIT license. See the LICENSE file for more info.
