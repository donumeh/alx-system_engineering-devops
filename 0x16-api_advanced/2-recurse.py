#!/usr/bin/python3

"""
Recursively query the reddit API and return
a list containing the titles of all hot 
articles for a given subreddit
"""


import requests


def recurse(subreddit, hot_list=[], after=None):
    """Function to recursively call subreddit and thier titles
    args:
        subreddit -> str
        hot-list -> list

    return: list of titles or None if nothing or error found
    """
    # Define the base URL with pagination support
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {"User-Agent": "Mozilla/5.0"}
    params = {
        "after": after,
        "limit": 100,
    }  # Limit is set to 100 for more efficient recursion

    try:
        # Make a GET request to the Reddit API
        response = requests.get(
            url, headers=headers, params=params, allow_redirects=False
        )

        # Check if the request was successful
        if response.status_code == 200:
            data = response.json().get("data", {})
            children = data.get("children", [])

            # Extend the hot_list with the titles of the current batch of posts
            hot_list.extend([child.get("data", {}).get("title") for child in children])

            # Check if there is a next page
            after = data.get("after")
            if after:
                # Recursively call the function with the new "after" parameter
                return recurse(subreddit, hot_list, after)
            else:
                # Base case: no more pages, return the accumulated hot_list
                return hot_list
        else:
            # Return None if the subreddit is invalid or any other issue occurs
            return None
    except requests.RequestException:
        # Handle any request exceptions
        return None
