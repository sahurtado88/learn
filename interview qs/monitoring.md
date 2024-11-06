# Monitoring

Monitoring is collecting and visualizing data about systems regularly so the system's health can be viewed and tracked

3 questions of monitoring

1. Is the service on?
2. Is the service functioning as expected?
3. Is the service performing well

the data that is collected for monitoring is called Telemetry data

Telemetry data is used to find where the problem might be

# MTTD Mean time to Detection

MTTD is the amount of time, on average, between the start of an issue and when teams become aware of it

# MTTR mean time to resolve

MTTR is the average amount of time between when an issue is detected, and when systems are fixed and operating normally

# foundattion of Observability

## RED method (service layer)

1. Rate (throughput): Request per second
2. Errors: Failed request for example HTTP 500
3. Duration: Latency or transaction Response time

## USE method (infraestructure layer)

1. Utilization CPU usage, disk space
2. Saturation Network queue lenght.Zero= good
3. Errors Disk write error. Zero= good

## Four golden Signals (between infraestructure and service layer) (RED+S)
If you can only measure four metrics of user-facing system, focus on thes four metrics

1. Latency 
2. Traffic (throughput)
3. Errors
4. Saturation (resourde at 100 capacity)

## Core Web vital (UI layer and specific to web sites)

1. Largest Contentful paint (perceived page load)
2. First Input delay (Perceived responsiveness)
3. Cumulative Layaout Shift (perceived stability)

# Observability

Observability is gathering actionable data in a way that gives a holistic view of the entire system, and tells us where, when and why an issue occurs

# Types of telemetry Data

## Metric
Is an aggregated value representing events in a period of time
Metrics are great for comparing the performance of the system with a time in the past

## Event
An action happened at a give time
events validate that an expected action happened

## Log
A very detailed representation of an event

## Trace
Show the interaction of micorservices to fulfil a request