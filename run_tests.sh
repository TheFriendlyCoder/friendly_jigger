#!/bin/bash -e

# Uncomment this line to install local build tools
# dotnet tool restore --add-source https://ci.appveyor.com/nuget/coveralls-net-t37a9a9unhwk
# dotnet tool install --add-source https://ci.appveyor.com/nuget/coveralls-net-t37a9a9unhwk coveralls.net

rm -rf tests/coverage
rm -rf tests/TestResults

#dotnet test --collect:"XPlat Code Coverage" -r ./coverage
dotnet test ./tests/tests.csproj /p:CollectCoverage=true /p:CoverletOutput=./coverage/ /p:CoverletOutputFormat=opencover /p:Threshold=90 /p:ThresholdType=line
dotnet test --logger "trx;LogFileName=loggerFile.trx" ./tests/tests.csproj /p:CollectCoverage=true /p:CoverletOutput=./coverage/ /p:CoverletOutputFormat=lcov /p:Threshold=90
dotnet tool run trx2junit tests/TestResults/*.trx

#find . -name "*.json" | grep coverage.json || (echo "Not found";exit -1;)
#echo "Completed successfully"
#./tests/check_coverage.sh 0.18

reportgenerator "-reports:./tests/coverage/coverage.info" "-targetdir:./tests/coverage/html" -reporttypes:Html
open ./tests/coverage/html/index.html

#reportgenerator "-reports:./coverage/coverage.opencover.xml" "-targetdir:coverage" -reporttypes:lcov

# Sample for publishing coveralls data

# To run these samples, you'll need to create a file called 'coveralls.token' with the token
# for this project. Log in to coveralls.io, locate this project, click on settings and load
# the deployment token for this library, then paste it into the file.

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
#dotnet tool run csmacnz.Coveralls --opencover -i ./opencoverage/coverage.opencover.xml --repoToken `cat coveralls.token` --useRelativePaths --basePath "$PWD/friendly_jigger" --jobId 100

