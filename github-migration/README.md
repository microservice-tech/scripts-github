# scripts-github
Github administration scripts

## git_migration.sh
Quick and dirty script for migrating local raw repositories

### Usage
#### Create a ssh key
See github documentation: 

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

#### Create an api token
See github documentation: 

https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

paste the token in the github.token file. This will prevent it from showing up in your bash history

#### Edit the settings ```github.settings```
Edit the settings to fit your organisation and needs

#### Run the script
Add the path of the folder containing the git repositories

```./git_migration.sh <path>```

#### Check the output!!
