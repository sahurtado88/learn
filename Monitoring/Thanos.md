# Thanos

Thanos calls itself an "open-source, highly available Prometheus setup with long-term storage capabilities."

## Key Takeaways

- In the realm of data monitoring, it refers to an open-source extension to Prometheus, a platform for real-time systems and event monitoring. Thanos enhances Prometheus by providing long-term data storage capabilities and high availability.
- Thanos was created by Improbable, a British gaming technology company, with the goal of unifying Prometheus deployments worldwide into a single monitoring system with unlimited historical data storage.
- Thanos consists of various components, including Thanos Sidecar, Thanos Store, Thanos Query, Thanos Compact, and Thanos Ruler. Each component has a specific role in enhancing Prometheus's capabilities.

## What is Thanos?

Thanos is an open-source extension to Prometheus created by Improbable, a British gaming technology company. In their blog post announcing the release of Thanos, Improbable revealed the project's goal: "to seamlessly transform existing Prometheus deployments in clusters around the world into a unified monitoring system with unbounded historical data storage."

By adding Thanos to Prometheus, users can build highly available metric systems with practically unlimited storage. When deployed, Thanos provides features such as a global query view, high accessibility (HA), and affordable access to historical data in a single binary.

## Thanos Components

The various components of the Thanos project are as follows:

- Thanos Sidecar: The main component of Thanos that runs alongside Prometheus, reading and archiving data on the object store. Sidecar can also execute PromQL queries.
- Thanos Store: An API gateway that sits on top of historical Prometheus data in an object storage bucket. 
- Thanos Query: An aggregator for query results from multiple sources, i.e. multiple Sidecar instances.
- Thanos Compact: A component that applies Prometheus 2.0's compaction procedure to block data in object store.
- Thanos Ruler: A component that evaluates the Prometheus recording and alerting rules against your choice of query API.

Let's now break down the Thanos features that we mentioned above a little further:

- Global query view: By default, Prometheus uses a functional sharding approach, thanks to the platform's scalability. However, it can sometimes be useful to access all of your data in the same API or user interface. Thanos allows you to achieve this global query view. For example, you can query and aggregate data from multiple Prometheus servers, and then display them within Grafana.
- High availability: Thanos Sidecar and Thanos Query enable high availability (HA) for your Prometheus deployment. For example, if you have multiple Prometheus instances, Thanos Query can deduplicate the metrics and merge them together.
- Historical data storage: Thanos Sidecar watches Prometheus for new blocks of persisted data and uploads them into an object storage bucket. You can store historical Prometheus data with the cloud partner of your choice, including Google Cloud Platform, Amazon S3, and Microsoft Azure.

Thanos is one of several projects that seek to add high availability and long-term historical data storage to Prometheus. Other options include Cortex by Weaveworks (also a CNCF incubating project) and VictoriaMetrics.

## What are the Use Cases of Thanos?

Thanos can help any organization using Prometheus that needs to enable high availability and virtually unlimited historical data storage. Using Thanos makes it easier to scale Prometheus horizontally and obtain a global view of data from multiple Prometheus servers.

The Thanos project website collects various Thanos use cases that can serve as useful examples for would-be users. For example, you can combine Thanos, Prometheus, and the Kvass auto-scaling Prometheus solution in order to build a Prometheus deployment for large Kubernetes cluster monitoring.

