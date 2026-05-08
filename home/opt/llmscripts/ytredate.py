#!/usr/bin/env python3
from datetime import datetime, UTC
import json
from os import listdir, utime

INFO_SUFFIX: str = "info.json"
INFO_SUFFIX_LEN: int = len(INFO_SUFFIX)

def main():
    for x in listdir():
        if not x.endswith(INFO_SUFFIX):
            continue
        with open(x) as f:
            data = json.load(f)
        if False and "timestamp" in data:
            date_ts = int(data["timestamp"])
        else:
            date_str = data["upload_date"]
            assert len(date_str) == 8
            assert date_str.isnumeric()
            date = datetime(int(date_str[:4]), int(date_str[4:6]), int(date_str[6:8]), 0, 0, 0, 0, UTC)
            date_ts = int(date.timestamp())
        try:
            utime(x[:-INFO_SUFFIX_LEN] + "webm", (date_ts, date_ts))
        except FileNotFoundError:
            utime(x[:-INFO_SUFFIX_LEN] + "mkv", (date_ts, date_ts))

if __name__ == "__main__":
    main()
