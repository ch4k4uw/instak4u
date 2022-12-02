# Instak4u, an "Instagram" feed prototype
- [Features](#features)
- [Architecture](#architecture)
- [Module arrangement](#module-arrangement)
- [Package pattern](#package-pattern)
- [Technologies](#technologies)
## Features
* User sign-in and sign-up
    * With safe password storing through SHA512 pass hashing implementation
* Feed of events
* Event check-in
* Event sharing
* Event location (google maps)

## Architecture
This app implements the `MVVM` design pattern for the presenter module (`app`) and its macro architecture is based on the `separation of concerns` (view, view-model, domain and infrastructure).
To implement it the view implements the user interactions and screen flows through Flutter view patterns mirroring the features implemented in the presenter module, which implements `use-cases` pattern to deal with the domain architecture, which is based on `query and command`. That `query and command` based architecture is implemented using the `repository`, `services`, and `anemic entities` patterns.</br>
To make all of this work as required, to manage and set up all of the dependency injection, all modules implement the `inversion of control` pattern.

## Module arrangement
1. app
    * `View` - Implements the user interactions and the screen flows.
2. presenter
    * `View-Model` - Implements every view-models and the features use cases.
3. domain
    * `Domain` - Implements the business logic required for each feature as well as the required infrastructure required to deal with each business logic requirement.
4. core
    * `Infrastructure` - High, middle, and low-level required features to implement the app business and presentation features.

## Package pattern
1. app
    * `Feature` - App feature
        * `extensions` - `Extensions methods patterns` implementations
        * `ioc` - Inversion of control. Required modules to manage the `dependency injection pattern`.
2. presenter
    * `Feature` - App feature
        * `interaction` - Required data structures to deal with `domain` queries and user interactions.
        * `uc` - Use cases implementations.
        * `ioc` - Same as the `app.feature.ioc`.

3. domain
    * `Domain feature` - Business requirement implementation. Its relation with the `app feature` *isn't* 1:1, but n:m since the `domain feature` works over a `query and command` architecture. Then for N `app features`, can exist 0 or M `domain features`.
        * `domain` - Domain implementation and domain infrastructure requirements. It implements required data structure, patterns and domain contracts to deal with the required business logic
            * `data` - DDD's `data` object.
            * `entity` - DDD's `entity` object (anemic).
            * `repository` - `Repository pattern` domain contracts.
        * `infra` - Domain requirements implementations. Implements every low level logic required to implement the domain business logic.
            * `ioc` - Same as the `app.feature.ioc`.
            * `repository` - Domain repository requirements implementations.
            *  `…` - Several packages, private to the infrastructure, to deal with the domain requirements.
4. core
    * `Feature` - General app required feature.

## Technologies
1. `Http` - Http requests (`core` module).
2. `Http interceptor` - Log of http transactions (`core` module).
3. `Injectable` - Dependency injection configuration (`core`, `domain` and `app` modules).
4. `GetIt` - Dependency injection management (`core`, `domain` and `app` modules).
5. `Flutter localizations` - Localization support (`core`, `domain` and `app` modules).
6. `Flutter localizations` - Localization configuration support (`core`, `domain` and `app` modules).
7. `Messagepack` - Binary data generation (`presenter` and `domain` modules).
8. `Cryptography` - Binary data encryption and comparison (`domain` module).
9. `Uuid` - Uuid generation (`domain` module).