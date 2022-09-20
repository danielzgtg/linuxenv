#!/usr/bin/env python3

from typing import List, Set

NUM_MACHINES = 2


def _header_iff_content(header: str, content: List[str]) -> None:
    if not content:
        return
    print(header)
    for x in content:
        print(x)


class Machine:
    def __init__(self, num: int, expected: Set[str], actual: Set[str]):
        self._num = num
        self._expected = expected
        self._actual = actual

    def check(self) -> None:
        expected = self._expected
        actual = self._actual
        print(f"# Machine {self._num}")
        if expected == actual:
            print("OK")
            return
        _header_iff_content("## Added:", sorted(actual - expected))
        _header_iff_content("## Removed:", sorted(expected - actual))


def _load_file(path: str) -> Set[str]:
    with open(path) as f:
        lines = f.read().splitlines()
    if lines and not lines[-1]:
        lines.pop()
    if "" in lines:
        raise ValueError
    sort = sorted(lines)
    if sort != lines:
        print(f"{path} needs to be sorted:")
        for x in sort:
            print(x)
        raise ValueError
    result = set(lines)
    if len(lines) != len(result):
        raise ValueError
    return result


def _load_machine(num: int, common: Set[str]) -> Machine:
    expected = _load_file(f"{num}.expected.txt")
    if not common.isdisjoint(expected):
        for x in common & expected:
            print(f"Error {num} overlap common: {x}")
        raise ValueError
    expected |= common
    actual = _load_file(f"{num}.actual.txt")
    return Machine(num, expected, actual)


def main() -> None:
    common = _load_file("common.txt")
    machines = [_load_machine(num, common) for num in range(NUM_MACHINES)]
    for machine in machines:
        machine.check()


if __name__ == '__main__':
    main()
