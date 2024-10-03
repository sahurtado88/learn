

error con cold start se uso provisioned concurrency or snapstart

Using provisioned concurrency incurs additional charges to your account. If you're working with the Java 11 or Java 17 runtimes, you can also use Lambda SnapStart to mitigate cold start issues at no additional cost. SnapStart uses cached snapshots of your execution environment to significantly improve startup performance. You cannot use both SnapStart and provisioned concurrency on the same function version

# Managing Lambda dependencies with layers

A Lambda layer is a .zip file archive that contains supplementary code or data. Layers usually contain library dependencies, a custom runtime, or configuration files.

There are multiple reasons why you might consider using layers:

To reduce the size of your deployment packages. Instead of including all of your function dependencies along with your function code in your deployment package, put them in a layer. This keeps deployment packages small and organized.

To separate core function logic from dependencies. With layers, you can update your function dependencies independent of your function code, and vice versa. This promotes separation of concerns and helps you focus on your function logic.

To share dependencies across multiple functions. After you create a layer, you can apply it to any number of functions in your account. Without layers, you need to include the same dependencies in each individual deployment package.

To use the Lambda console code editor. The code editor is a useful tool for testing minor function code updates quickly. However, you can’t use the editor if your deployment package size is too large. Using layers reduces your package size and can unlock usage of the code editor.

# Reserved concurrency vs Provisioned concurrency

Topic	|Reserved concurrency	|Provisioned concurrency|
|-|-|-|
Definition|Maximum number of execution environment instances for your function.|Set number of pre-provisioned execution environment instances for your function.
Provisioning behavior|Lambda provisions new instances on an on-demand basis.|Lambda pre-provisions instances (that is, before your function starts receiving requests).
Cold start behavior|Cold start latency possible, since Lambda must create new instances on-demand.|Cold start latency not possible, since Lambda doesn't have to create instances on-demand.|
Throttling behavior|Function throttled when reserved concurrency limit reached.|- If reserved concurrency not set: function uses unreserved concurrency when provisioned concurrency limit reached. 
|||- If reserved concurrency set: function throttled when reserved concurrency limit reached.
Default behavior if not set|Function uses unreserved concurrency available in your account.|Lambda doesn't pre-provision any instances. Instead, if reserved concurrency not set: function uses unreserved concurrency available in your account. If reserved concurrency set: function uses reserved concurrency.
Pricing|No additional charge.|Incurs additional charges.

**Concurrency** is the number of in-flight requests that your AWS Lambda function is handling at the same time

throttling use sqs and let death queue
request unserved concurrency limit increase(no cost) to 5000 https://docs.aws.amazon.com/servicequotas/latest/userguide/request-quota-increase.html
-sepecify reserve concurrency per fucntion
- alar on throttling exception and DLQ (dead letter queue) only works for async invocations (SNS, SQS, HTTP CLient)
