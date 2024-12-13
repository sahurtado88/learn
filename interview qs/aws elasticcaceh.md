

## Patterns for ElastiCache
• Lazy Loading: all the read data is
cached, data can become stale in
cache
• Write Through: Adds or update
data in the cache when written
to a DB (no stale data)
• Session Store: store temporary
session data in a cache (using
TTL features)