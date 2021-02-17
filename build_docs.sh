#!/bin/bash

# reference links:
# docfx walkthrough: https://dotnet.github.io/docfx/tutorial/walkthrough/walkthrough_overview.html
# dotnet xml docstrings: https://docs.microsoft.com/en-us/dotnet/csharp/codedoc#param
# example for publishing docs to Github pages: https://github.com/docascode/docfx-seed/blob/master/appveyor.yml

# Prerequisities for this script are installed as shown below:
# brew install docfx

# To create a new doc configuration:
# docfx init

# build the docs and launch a local web server so they can be browsed
# at localhost:8080
#docfx docfx_project/docfx.json --serve
docfx docfx_project/docfx.json --serve