# Decisions Log

- 2025-08-09: Adopt MVVM + Riverpod for app state. Provider only for widget-local trivial state or 3rd-party interop. Navigation from Views based on VM signals.
- 2025-08-09: Repositories are the only IO boundary (Firestore/HTTP). Services contain orchestration/validation only, no direct SDK calls.
- 2025-08-09: Use Firestore `Timestamp` for dates; mapping via converters/mappers.
