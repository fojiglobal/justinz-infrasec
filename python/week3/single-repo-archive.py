import requests
import os

'''
Github Personal Access token is in 1Password under Secops vault
To execute scripts;
 export github_api_token = "Token from 1Password"
 export github_username = "github username"
'''
# GitHub personal access token and username (Replace with your actual token)
GITHUB_TOKEN = os.getenv("github_api_token")
GITHUB_USERNAME = os.getenv("github_username") 

# List of repositories to archive (in the format 'owner/repo')
'''REPOSITORIES = [
    "fojiglobal/justinz-infrasec-test",
    #"owner2/repo2"
]
'''
repo = input("Please Enter The Name of the Repo to Archive: ")

def archive_repository(repo):
    """Archives a given GitHub repository."""
    url = f"https://api.github.com/repos/{repo}"
    headers = {
        "Authorization": f"token {GITHUB_TOKEN}",
        "Accept": "application/vnd.github.v3+json"
    }
    data = {"archived": True}

    response = requests.patch(url, headers=headers, json=data)
    
    if response.status_code == 200:
        print(f"Successfully archived {repo}.")
    else:
        print(f"Failed to archive {repo}: {response.status_code} - {response.text}")

def archive_repositories():
    # Archive each repository, by looping through the list
    #for repo in REPOSITORIES:
        archive_repository(repo)

if __name__ == "__main__":
    archive_repositories()