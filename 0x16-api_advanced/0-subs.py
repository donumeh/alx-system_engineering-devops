#!/usr/bin/python3
"""
Request for an info from Reddit api
"""


import requests


def number_of_subscribers(subreddit) -> int:
    """
    Function that request for number of subscribers in a reddit channel
    args:
        subreddit: string

    return: 0 if not a valud subreddit, else number of follower
    """
    # Define the base URL
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)

    # Set custom User-Agent to avoid Too Many Requests error
    headers = {"User-Agent": "Mozilla/5.0"}

    try:
        # Make a GET request to the Reddit API
        response = requests.get(url, headers=headers, allow_redirects=False)

        # Check if the request was successful
        if response.status_code == 200:
            # Parse the JSON response
            data = response.json()
            # Return the number of subscribers
            return data.get("data", {}).get("subscribers", 0)
        else:
            # Return 0 if the subreddit is invalid or any other issue occurs
            return 0
    except requests.RequestException:
        # Handle any request exceptions
        return 0
