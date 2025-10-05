# Holo Task

## Overview
Holo Task is a Flutter application designed to manage a shopping experience. It utilizes the BLoC pattern for state management and follows a clean architecture approach to ensure maintainability and scalability.

## Features
- **Product Listing**: Users can view a list of products.
- **Product Details**: Users can tap on a product to view detailed information.
- **Shopping Cart**: Users can add products to their cart and view the cart contents.
- **Dependency Injection**: Utilizes `get_it` for managing dependencies throughout the application.
- **State Management**: Implements the BLoC pattern to manage application state effectively.

## Architecture
The architecture of Holo Task is based on the principles of clean architecture, which separates the application into distinct layers:

1. **Presentation Layer**: Contains UI components and manages user interactions. This layer uses Flutter widgets and BLoC for state management.
2. **Domain Layer**: Contains business logic and use cases. This layer defines the application's core functionalities and interacts with the data layer.
3. **Data Layer**: Responsible for data management, including local and remote data sources. This layer handles API calls and data persistence.

## Project Structure
```
lib/
├── core/
│   ├── design_system/
│   ├── errors/
│   └── usecases/
├── di/
│   └── injection_container.dart
├── features/
│   ├── cart/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── pdp/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── plp/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── main/
│       └── presentation/
└── routes/
```

## Approach
The project follows a modular approach, where each feature is encapsulated within its own directory. This promotes separation of concerns and makes it easier to manage and scale the application. The use of BLoC for state management allows for reactive programming, making the UI responsive to state changes.



## Caching
Caching in Holo Task is implemented using the Hive package, which provides a lightweight and fast key-value database. Hive allows the application to store data locally, enabling quick access to frequently used information without the need for repeated API calls. This enhances the user experience by reducing loading times and improving performance.

## Routing
Routing in the application is managed using the `go_router` package. This package simplifies navigation between different screens and supports deep linking, making it easier to handle complex routing scenarios. With `go_router`, developers can define routes in a declarative manner, allowing for better organization and maintainability of the navigation structure.
## Other Packages Used
- **flutter_bloc**: Implements the BLoC pattern for state management, allowing for reactive programming and separation of business logic from UI components.
- **equatable**: Provides a way to compare objects for equality, which is particularly useful in state management to determine when to rebuild UI components.
- **get_it**: A service locator for dependency injection, enabling easy management of dependencies throughout the application.
- **dio**: A powerful HTTP client for making API calls, offering features like interceptors, global configuration, and file downloading.
- **hive**: A lightweight and fast key-value database for local storage, used for caching data and improving performance.
- **hive_flutter**: Provides Flutter-specific extensions for Hive, making it easier to work with Hive in Flutter applications.
- **freezed**: A code generator for immutable classes, simplifying the creation of data models and ensuring immutability.
- **json_annotation**: Facilitates JSON serialization and deserialization, allowing for easy conversion between JSON and Dart objects.
- **shimmer**: A package for adding loading effects to the UI, enhancing the user experience during data fetching.
