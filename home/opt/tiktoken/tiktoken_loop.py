#!/usr/bin/env python3
import tiktoken
enc = tiktoken.encoding_for_model("gpt-4o")
try:
    while True:
        print(enc.encode(input()))
except EOFError:
    pass
