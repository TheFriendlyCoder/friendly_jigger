#!/bin/bash -e

# Uncomment this line to install local build tools
# dotnet tool restore --add-source https://ci.appveyor.com/nuget/coveralls-net-t37a9a9unhwk

rm -rf coverage
rm -rf coveragereport

dotnet test --collect:"XPlat Code Coverage" -r ./coverage
./tests/check_coverage.sh 0.18

reportgenerator "-reports:./coverage/**/coverage.cobertura.xml" "-targetdir:coveragereport" -reporttypes:Html

# Sample for publishing coveralls data
# looks like the default coverage format produced by xunit isn't compatible
# with coveralls.io, so we first need to convert it to a format that it recognizes
# Using the reportgenerator tool, and looking for a format it supports that is
# also supported by coveralls, I found lcov was a working intersection
#reportgenerator "-reports:./coverage/**/coverage.cobertura.xml" "-targetdir:lcovreport" -reporttypes:lcov

# minimal working example - have to set the jobId to something unique that
# hasn't already been published to coveralls.io
#dotnet tool run csmacnz.Coveralls --lcov -i ./lcovreport/lcov.info --repoToken `cat coveralls.token` --jobId 1240

# more complete working example:
#dotnet tool run csmacnz.Coveralls --lcov -i ./lcovreport/lcov.info --useRelativePaths --basePath "$PWD/friendly_jigger" --repoToken `cat coveralls.token` --commitBranch ksp_test --commitAuthor "Kevin Phillips" --commitEmail "thefriendlycoder@gmail.com" --commitId ABCD1234 --commitMessage "From local laptop" --jobId 1238

# The line below is what should work according to the docs, using the original
# report data, but it does not work in practice
#dotnet tool run csmacnz.Coveralls --opencover -i ./coverage/**/coverage.cobertura.xml --useRelativePaths --basePath "$PWD/friendly_jigger" --repoToken `cat coveralls.token` --commitBranch ksp_test --commitAuthor "Kevin Phillips" --commitEmail "thefriendlycoder@gmail.com" --commitId ABCD1234 --commitMessage "From local laptop" --jobId 1237

