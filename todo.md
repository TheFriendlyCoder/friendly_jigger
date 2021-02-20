* read up on how to publish docs to github pages
* setup unit test for command line https://siderite.dev/blog/using-commandlineparser-in-way-friendly-to-depende/
* figure out how to sign binaries
* write some setup docs (ie: adding coverageio app token as an env var to the travis ci build to publish coveage data)
* try to set up a runsettings.xml file
  * https://github.com/coverlet-coverage/coverlet/blob/master/Documentation/VSTestIntegration.md
  * https://docs.microsoft.com/en-us/visualstudio/test/configure-unit-tests-by-using-a-dot-runsettings-file?view=vs-2019
  * https://github.com/Microsoft/vstest-docs/blob/master/docs/configure.md
* set up project to auto run tests on code change: 
  * https://gavindraper.com/2020/05/27/VS-Code-Continious-Testing/
  * https://www.hanselman.com/blog/automatic-unit-testing-in-net-core-plus-code-coverage-in-visual-studio-code
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

Docs Setup Notes
================
* create a new ssh key: ssh-keygen -t rsa -b 4096
  * make sure to leave password field empty
  * specify output folder as "." so as to not overwrite system keys
* log into circle CI and open project settings for your project
* click "SSH Keys" in left side bar
* at bottom under "Additional SSH Keys" click "Add key"
* in the "hostname" field enter "github.com"
  * NOTE: make sure the browser doesn't change the character casing on the host
    name. It has to match the host name used by Git on the command line exactly
    otherwise you'll get weird "token has read only access" errors when attempting
    to publish
* paste contents from id_rsa file (ie: the private key) into web form and save
* back under the SSH Keys page of the circle ci config, you'll see a "Fingerprints"
  field next to your newly added key. Copy this fingerprint
* edit the .circleci/config.yml file, adding the following code under the "steps" section
  of your publish job, replacing <FINGERPRINT> with the value you just copied
  - add_ssh_keys:
      fingerprints:
        "<FINGERPRINT>"
* log in to github
* under the "Settings" tab for your source project, click "Deploy Keys" in left side bar
* click "add deploy key"
* give deploy key some friendly name, like circle ci docs
* paste the contents of the id_rsa.pub file (ie: the public key) into the web form
* click the "allow write access" check box and save

Documentation Tips
==================
* use "gh-pages" tool to publish your docs from within this job
  * use the image: node:8.10.0 docker image for the build
* add an empty file named ".nojekyll" to the root folder to prevent GitHub from trying to generate
  a custom site for you and force it to just use your static site contents
* add the following snippet to the top of the docfx_project/docfx.json file to enable
  auto generated API docs:
    "metadata": [
    {
      "src": [
        {
          "src": "../",
          "files": [
            "friendly_jigger/**.cs"
          ]
        }
      ],
      "dest": "api",
      "disableGitFeatures": false,
      "disableDefaultFilter": false
    }
  ],
* edit the toc.yml file in the docfx_project root folder and uncomment the api section
  to add links in the index to the auto generated docs

Helpful Links
=============
* https://circleci.com/blog/deploying-documentation-to-github-pages-with-continuous-integration/
* https://www.npmjs.com/package/gh-pages
* https://pages.github.com