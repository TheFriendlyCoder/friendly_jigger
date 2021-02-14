* setup unit test for command line https://siderite.dev/blog/using-commandlineparser-in-way-friendly-to-depende/
* figure out how to sign binaries
* write some setup docs (ie: adding coverageio app token as an env var to the travis ci build to publish coveage data)
* see if we can use coveralls.io to manage the minimum coverage threshold
* document how to add new build tools using "dotnet tool install <xyz>"
* try to set up a runsettings.xml file
* * https://github.com/coverlet-coverage/coverlet/blob/master/Documentation/VSTestIntegration.md
* * https://docs.microsoft.com/en-us/visualstudio/test/configure-unit-tests-by-using-a-dot-runsettings-file?view=vs-2019
* * https://github.com/Microsoft/vstest-docs/blob/master/docs/configure.md
* set up project to auto run tests on code change: 
* * https://gavindraper.com/2020/05/27/VS-Code-Continious-Testing/
* * https://www.hanselman.com/blog/automatic-unit-testing-in-net-core-plus-code-coverage-in-visual-studio-code
* click watch at bottom of vscode so as changes to the coverage.info file automatically get reflected in the gutters
* custom settings for the .NET text explorer causes the coverage.info file to be regenerated automatically when you run all tests in the suite
* debugging a test from the test explorer pane doesn't work, but clicking the debug test link in the code
lens overlay on top of a test seems to work
* generate changes list for Github release based on query of PR or Github issues / Jira issues

Test Setup Notes:
=================
* plugins for vscode:
* * .NET Core Test Explorer
* * Coverage Gutters
* put common settings for vscode plugins in the ./.vscode/settings.json file
* gutters plugin is set up to look for any file named cover
Helpful Links
=============
* https://andrewlock.net/version-vs-versionsuffix-vs-packageversion-what-do-they-all-mean/
* https://andrewlock.net/version-vs-versionsuffix-vs-packageversion-what-do-they-all-mean/#how-to-set-the-version-number-when-you-build-your-app-library
* Tool for managing local tool manifest in ./.config folder: https://docs.microsoft.com/en-us/dotnet/core/tools/local-tools-how-to-use
* Docs on code coverage tool: https://github.com/coverlet-coverage/coverlet/blob/master/Documentation/GlobalTool.md