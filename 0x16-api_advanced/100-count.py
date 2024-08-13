#!/usr/bin/python3

"""
Query the reddit API, parse the titles of all hot articles
"""


import requests
from collections import defaultdict


def count_words(subreddit, word_list, hot_list=[], after=None) -> dict:
    """
    Function to query Reddit API, parse the titles of all hot articles
    and print a sorted count of given keywords

    args:
        subreddit: str
        word_list: list of keywords to count
        hot_list titles of all host post
        after: pagination token

    return:

    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {"User-Agent": "Mozilla/5.0"}
    params = {"after": after, "limit": 100}

    try:
        response = requests.get(
            url, headers=headers, params=params, allow_redirects=False
        )
        if response.status_code == 200:
            data = response.json().get("data", {})
            children = data.get("children", [])
            hot_list.extend(
                [child.get(
                    "data", {}
                    ).get(
                        "title", ""
                        ).lower() for child in children]
            )
            after = data.get("after")
            if after:
                return count_words(subreddit, word_list, hot_list, after)
            else:
                # Count occurrences of keywords in the titles
                word_count = defaultdict(int)
                for title in hot_list:
                    words_in_title = title.split()
                    for word in word_list:
                        word = word.lower()
                        word_count[word] += words_in_title.count(word)

                # Filter out words with 0 occurrences
                word_count = {
                    word: count for word,
                    count in word_count.items() if count > 0
                }

                # Sort by count descending, then alphabetically ascending
                sorted_word_count = sorted(
                    word_count.items(), key=lambda x: (-x[1], x[0])
                )

                # Print the sorted words
                for word, count in sorted_word_count:
                    print(f"{word}: {count}")
        else:
            return
    except requests.RequestException:
        return
