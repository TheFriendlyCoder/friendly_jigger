#!/bin/bash -e
# query Github API for list of releases: hub api -X GET /repos/TheFriendlyCoder/friendly_jigger/releases
# select nodes in json response for draft releases, and filter out everything except the release IDs: jq '.[] | select(.draft == true) | {id: .id}'
# isolate the release IDs as simple numeric values: grep id | sed "s/  \"id\": //"
# pass each line from the input stream to the 'hub' command, substituting {} for the release ID: xargs -I{} 
# perform a deletion on each draft release ID using the Github API: hub api -X DELETE /repos/TheFriendlyCoder/friendly_jigger/releases/{}

export draft_json=`hub api -X GET /repos/TheFriendlyCoder/friendly_jigger/releases | jq '.[] | select(.draft == true) | {id: .id, tag: .tag_name, draft: .draft, prerelease: .prerelease, branch: .target_commitish, url: .html_url}'`
if [ "$draft_json" == "" ]
then
    echo "No draft releases to purge"
    exit 0
else
    echo "Purging draft releases:"
    echo $draft_json | jq '.'
fi

echo $draft_json | jq '.' | grep id | sed "s/  \"id\": //" | xargs -I{} hub api -X DELETE /repos/TheFriendlyCoder/friendly_jigger/releases/{}
echo "Draft releases purged successfully"

# show list of IDs of draft releases
# hub api -X GET /repos/TheFriendlyCoder/friendly_jigger/releases | jq '.[] | select(.draft == true) | {id: .id}' | grep id | sed "s/  \"id\": //"

# show summary info for draft releases
# hub api -X GET /repos/TheFriendlyCoder/friendly_jigger/releases | jq '.[] | select(.draft == true) | {id: .id, tag: .tag_name, draft: .draft, prerelease: .prerelease, branch: .target_commitish, url: .html_url}'

# fancy output to show releases
# hub api -X GET /repos/TheFriendlyCoder/friendly_jigger/releases | jq '.[]'

# show just the id, draft and prerelease flags for all releases
# hub api -X GET /repos/TheFriendlyCoder/friendly_jigger/releases | jq '.[] | {id: .id, draft: .draft, pre: .prerelease}'