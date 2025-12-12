---
title: AWS CDK Kotlin
date: 2023-05-19
---

[AWS CDK Kotlin](https://github.com/F43nd1r/aws-cdk-kt) is a generated Kotlin DSL for [AWS CDK](https://aws.amazon.com/cdk/). It provides a more idiomatic way to work with AWS CDK in Kotlin, enabling fluent, type-safe infrastructure as code.

## Overview

The AWS CDK Kotlin DSL auto-generates Kotlin extension functions for every AWS CDK construct, builder, and resource. This allows developers to define cloud infrastructure using a Kotlin-idiomatic syntax with full IDE support and type safety.  
Under the hood this DSL is a wrapper over the existing AWS CDK Java API, making it easier to use in Kotlin projects.
Wrappers are automatically generated and updated using Renovate auto merge and Github Actions.

## Example

```kotlin
app {
  stack("LambdaStack") {
    buildFunction("HelloHandler") {
      code(Code.fromInline("function handler() { console.log('Hello, CDK'); }"))
      handler("index.handler")
      runtime(Runtime.NODEJS_16_X)
    }
  }
}.synth()
```

## How It Works

The DSL generates functions for:

- **CDK Constructs** (e.g., `App`) - Creates instances with optional initialization blocks:
  ```kotlin
  public fun app(initializer: @AwsCdkDsl App.() -> Unit = {}): App = App().apply(initializer)
  public fun app(props: AppProps, initializer: @AwsCdkDsl App.() -> Unit = {}): App = App(props).apply(initializer)
  ```

- **CDK Construct Builders** (e.g., `App.Builder`) - Enables fluent builder patterns:
  ```kotlin
  public fun buildApp(initializer: @AwsCdkDsl App.Builder.() -> Unit = {}): App = 
    App.Builder.create().apply(initializer).build()
  ```

- **Scoped Constructs** (e.g., `Stack`) - Provides receiver functions for easy nesting within parent constructs:
  ```kotlin
  public fun stack(initializer: @AwsCdkDsl Stack.() -> Unit = {}): Stack = Stack().apply(initializer)
  
  public fun Construct.stack(initializer: @AwsCdkDsl Stack.() -> Unit = {}): Stack = Stack(this).apply(initializer)
  
  public fun Construct.stack(id: String, initializer: @AwsCdkDsl Stack.() -> Unit = {}): Stack = 
    Stack(this, id).apply(initializer)
  
  public fun Construct.stack(id: String, props: StackProps, initializer: @AwsCdkDsl Stack.() -> Unit = {}): Stack = 
    Stack(this, id, props).apply(initializer)
  ```
