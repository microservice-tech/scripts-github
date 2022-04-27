#!/bin/bash

WORKDIR=/root/tmp

GITHUB_ORG=microservice-tech
GITHUB_USER=xxxxxx
GITHUB_PASS_SOURCE=github.token
GITHUB_DESC="Something"
GITHUB_PRIVATE=true
GITHUB_HAS_ISSUES=false
GITHUB_HAS_PROJECTS=false
GITHUB_HAS_WIKI=false

# Autoconfig
LOCALREPODIR="${1}"
GITHUB_TOKEN=$(cat ${GITHUB_PASS_SOURCE})
echo "TOKEN: ${GITHUB_TOKEN}"

# clone repo and push
function cloneRepo(){

	CLONE_FROM="${LOCALREPODIR}${1}"
	CLONE_TO="git@github.com:${GITHUB_ORG}/${2}"
	printf "clone from: %-50s %s to: " "${CLONE_FROM}"
	printf "%-50s %s\n" "${CLONE_TO}"
	cd "$WORKDIR"
	git clone --bare "${CLONE_FROM}"
	cd "$1"
	pwd

	git remote set-url origin "${CLONE_TO}"
	git push --mirror origin
	cd ..
}



# create repo GITHUB
function createRepo(){
	ORG_NAME="${LOCALREPODIR}${1}.git"
	createName "${1}"
echo "org name: ${ORG_NAME}"
echo "createName: ${1}"
#	curl \
#	  -X POST \
#	  -u ${GITHUB_USER}:${token} \
#	  -H "Accept: application/vnd.github.v3+json" \
#	  https://api.github.com/orgs/${GITHUB_ORG}/repos \
#	  -d "$(createRepoData)"

#	cloneRepo "${ORG_NAME}" "${NAME}"
createRepoData
}

function createRepoData(){

	cat <<EOF
	{
		"name":"${NAME}","description":"${GITHUB_DESC}","homepage":"https://github.com","private":${GITHUB_PRIVATE},"has_issues":${GITHUB_HAS_ISSUES},"has_projects":${GITHUB_HAS_PROJECTS},"has_wiki":${GITHUB_HAS_WIKI}
	}
EOF
}

# Create repo name
function createName(){

	IFS='.'
	read -ra NAME_ARR <<<"${1}"
	NAME="x-legacy-${NAME_ARR[0]}"
}

# Clear tmp folder
function clearTmp(){

	rm -r ${WORKDIR}
	mkdir ${WORKDIR}
}



# Clear tmp directory
clearTmp

# Loop directories
cd ${LOCALREPODIR}
for d in */ ; do
	if [[ $d == *.git/ ]]; then
		createRepo $d
	fi
done

