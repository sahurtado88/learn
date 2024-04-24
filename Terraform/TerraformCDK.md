CDKTF offers many benefits, but it is not the right choice for every project. You should consider using CDKTF when:

You have a strong preference or need to use a procedural language to define infrastructure.
You need to create abstractions to help manage complexity. For example, you want to create constructs to model a reusable infrastructure pattern composed of multiple resources and convenience methods.
You are comfortable living on the cutting edge; CDKTF may still have breaking changes before our 1.0 release.

# Choosing a Language for your Project
Consider which of the supported languages you are most familiar with and which language best fits your organization's current tooling. We work towards providing feature parity and a good user experience across all supported languages, but there may be instances when new experimental features will not be available for all languages.

If you plan to create and package your own constructs, we recommend choosing TypeScript. Using TypeScript allows you to use the cdktf constructs package generator to build and publish your constructs in multiple languages.

https://developer.hashicorp.com/terraform/cdktf/concepts/resources

