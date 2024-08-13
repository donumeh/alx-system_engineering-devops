#!/usr/bin/python3

"""
Request for the top 10 post of a subreddit
"""

import requests


def top_ten(subreddit) -> str:
    """
    Gets the top ten sub-reddit topics
    args:
        subreddit -> str

    return:
        None if error encountered, else print posts
    """
    # Define the base URL with the limit set to 10 posts
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"

    # Set custom User-Agent to avoid Too Many Requests error
    headers = {"User-Agent": "Mozilla/5.0"}

    try:
        # Make a GET request to the Reddit API
        response = requests.get(url, headers=headers, allow_redirects=False)

        # Check if the request was successful
        if response.status_code == 200:
            # Parse the JSON response
            data = response.json()
            # Iterate over the first 10 posts and print their titles
            for post in data.get("data", {}).get("children", []):
                print(post.get("data", {}).get("title"))
        else:
            # Print None if the subreddit is invalid or any other issue occurs
            print(None)
    except requests.RequestException:
        # Handle any request exceptions
        print(None)
