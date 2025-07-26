# UUIDv7

Swift extension to generate and decode UUIDv7.

[![Swift Package Index](https://swiftpackageindex.com/leodabus/UUIDv7/badge.svg)](https://swiftpackageindex.com/leodabus/UUIDv7)

## Usage

```swift
import UUIDv7

let uuid = UUID.v7
print(uuid)  // ex: "01HZYH3JDTX6S3WQ8F45W9Y3Y8"
if let date = uuid.date {
  print(date)
}
```
