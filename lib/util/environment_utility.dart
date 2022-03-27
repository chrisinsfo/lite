/*
 * Copyright © Chris Wardell, 2020.
 */

enum Environment { DEVELOPMENT, PRODUCTION }

/// Utility to declare the environment.
/// Important to change to PRODUCTION on release.
class EnvironmentUtility {
  static Environment environment() {
    return Environment.DEVELOPMENT;
  }
}
