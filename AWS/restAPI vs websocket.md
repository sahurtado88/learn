# WebSocket vs REST

## rest What is REST?
Representational State Transfer (REST), is a set of principles that define one way to build APIs over HTTP. It’s easy to overlook, but REST isn’t a protocol, which means you have a great deal of flexibility to mold it to your needs. Its popularity is largely due to its simplicity and the fact that it reuses the methods and technologies already used for the web. And that largely defines the use cases where it does well and those where you’ll need to find an alternative.

## REST’s key characteristics
Stateless: Each request made to a REST API is independent and self-contained. That makes scaling much more straightforward. When traffic increases, you can add more servers behind a load balancer as there’s no need for a particular client to connect to the same server each time. Even though HTTP and REST are stateless, you can maintain long-running sessions by using client-side cookies to track session and log-in status.

CRUD: Each REST request uses the standard HTTP verbs (GET, POST, PUT, PATCH, and DELETE), which lines-up with Create, Read, Update, Delete operations.

Payload format: REST typically uses standardized message formats like JSON or XML for data exchange. But you can use whatever format of data you like, so long as you set the correct Content-Type header. 

Cacheable: You can choose to allow clients, and intermediate infrastructure, to cache responses. That helps scaling and response times.

Synchronous: The HTTP request-response cycle that REST relies on is best suited to short-lived, straightforward transactions where a client waits for response before moving on to the next task.

## What is WebSocket?
While REST works with short-lived, stateless communication, WebSocket provides an ongoing, low latency, two-way communication channel. That means the way you interact with WebSocket is different. So, rather than building a 'WebSocket API' as such, with specific endpoints, you open a connection and both sides can exchange messages as and when they need. This makes it ideal for realtime applications, such as chat, the live streaming of sports or financial data, and interactive, realtime collaborative environments like Figma, Miro, and Google Docs.

## WebSocket key characteristics
Persistent connection: Each REST request requires a fresh HTTP connection, which increases latency due to the overhead of the HTTP handshake. WebSocket opens a connection once and then keeps it open for as long as you need it, reducing the time it takes to send a message.

Stateful: WebSocket’s persistent connection means that the client and server can keep track of what’s happened previously, rather than having to use cookies to track state, as with REST.

Full duplex communication: Both the client and the server can send data whenever they need and at the same time. In REST, only the client can initiate a new connection.

Payload format: WebSocket works with discrete messages, such as a JSON object or a Protobuf message. That’s in contrast with streaming media formats that send a constant flow of bytes. Importantly, WebSocket lets you send text or binary data and it’s up to you to handle serializing and deserializing that data.

Realtime: WebSocket minimizes latency wherever possible. A persistent connection helps, as do small headers (as low as two bytes). 

 WebSocket vs REST

||REST|WebSocket|
|-|-|-|
Communication model|Request-response|Event-based
Statefulness       |Stateless       |Stateful
Scalability        |Easy to scale   |More complex to scale
Data formats       |Binary or text  |Binary or text
Overhead           |Higher, as each interaction requires a new connection | Lower, after initial handshake
Use cases          |CRUD APIs, stateless transfer of discrete units of data | Realtime collaboration, chat, data broadcast, ongoing transfer of data

https://ably.com/topic/websocket-vs-rest