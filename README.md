# UUIDv7

Swift extension to generate and decode UUIDv7.

## Uso

```swift
import UUIDv7

let uuid = UUID.v7
print(uuid)  // ex: "01HZYH3JDTX6S3WQ8F45W9Y3Y8"
if let date = uuid.date {
  print(date)
}
