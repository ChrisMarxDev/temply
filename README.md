# Temply
Simple cli-app for generating screen directories and widget/ cubit files for a flutter app. This is not a full blown toolset but rather a guideline for people that want to create their own little class generator script to automate the worklfow and reduce having to write boilerplate code.

## Usage
After installation simply use with the prefix of your desired screen name like this `temply Home -c -t` from your projects root to generate the following.

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

Omitting the `-c` or `--cubit` flag prevents generating `home_cubit.dart` & `home_state.dart` and ommiting the `-t` or `--test` flag prevents the generation of the test files `home_screen_test.dart` & `home_cubit_test.dart`.


A command-line application with an entrypoint in `bin/`, library code
in `lib/`.
Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
