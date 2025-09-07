# POS - Flutter Self-Checkout App

Point of Sale - Flutter Self-Checkout Application with GetX and MVVM architecture.

## Features

- 8 screens: start, item scan, payment, processing, printing, error, alert, assistant
- gRPC communication for server integration (localhost:50051)
- MQTT connection for real-time alerts
- Professional square button design
- GetX state management with MVVM pattern
- Support for Windows and Android platforms

## Getting Started

This Flutter project implements a complete self-checkout system.

### Prerequisites

- Flutter SDK
- gRPC server running on localhost:50051
- MQTT broker for alert functionality

### Installation

```bash
flutter pub get
flutter run
```

## Architecture

- **GetX**: State management and dependency injection
- **MVVM**: Model-View-ViewModel pattern
- **gRPC**: Server communication
- **MQTT**: Real-time alert system

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
