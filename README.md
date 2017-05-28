# Swift-AMF-Remoter

[![Swift][swift-badge]][swift-url]
[![License][mit-badge]][mit-url]
[![Slack][slack-badge]][slack-url]
[![Travis][travis-badge]][travis-url]
[![Codecov][codecov-badge]][codecov-url]
[![Codebeat][codebeat-badge]][codebeat-url]

**Swift-AMF-Remoter** provides an API for advanced reflection at runtime including dynamic construction of types.

## Usage

```swift
import Reflection

struct Person {
  var firstName: String
  var lastName: String
  var age: Int
}
