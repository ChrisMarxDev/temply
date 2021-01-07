# Temply
Simple cli-app for generating screen directories and widget/ cubit files for a flutter app. This is not a full blown toolset but rather a guideline for people that want to create their own little class generator script to automate the worklfow and reduce having to write boilerplate code.

## Installation
After cloning and modifications run `pub global activate --source path <path to project>` or in the project dir `pub global activate --source path ./`

## Usage
After installation simply use with the prefix of your desired screen name like this `temply screen Home` from your projects root and select what you want to generate. Using all currently available flags leads to generating the following structure if the deafult path is used. The path can also be modified in the cli prompt.

```
root
|-lib
    |-screens
        |-home_screen
            |-home_screen.dart
            |-state
                |-home_cubit.dart
                |-home_state.dart
|-test
    |-screens
        |-home_screen
            |-home_screen_test.dart
            |-home_cubit_test.dart`
```

Omitting the cubit generation prevents generating `home_cubit.dart`, `home_state.dart` & `home_cubit_test.dart` and ommiting the tests prevents the generation of the test files `home_screen_test.dart` & `home_cubit_test.dart`.

## Ref
https://dart.dev/tutorials/server/cmdline
https://pub.dev/packages/args
https://medium.com/@m_knabe/create-a-command-line-app-with-dart-8633d3d4a437
https://itnext.io/building-cli-programs-in-dart-81aaa85caeee
https://pub.dev/packages/interact

A command-line application with an entrypoint in `bin/`, library code
in `lib/`.
Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
