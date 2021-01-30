#!/bin/bash

RESET='\e[0m'
BOLD='\e[1m'
RED='\e[31m'
GREEN='\e[32m'

echo -e "\n${BOLD}Checkout ${GREEN}master${RESET}...\n"
git checkout master

branches=$(git branch --merged | grep -v '\*\|master\|release\|develop')

if [ -n "$branches" ]
	then
		echo -e "\n${BOLD}${RED}Locally merged branches to be removed: ${RESET}"
		
		for branch in $branches
		do
			echo "$branch"
		done
		
		echo -e "\n${BOLD}Remove (y/n)?${RESET}"
		read -e -i "y" answer
		
		case ${answer:0:1} in
			y|Y )
				echo -e "\n${BOLD}${GREEN}Removing...${RED}\n"
				git branch --merged | grep -v '\*\|master\|develop' | xargs -n 1 git branch -d
				echo -e "\n${RESET}${BOLD}${GREEN}Merged branches removed${RESET}\n"
			;;
			* )
				exit 1
			;;
		esac
		
	else
		echo -e "\n${BOLD}${GREEN}Nothing to remove${RESET}\n"
fi
