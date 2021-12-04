import fileinput
from enum import Enum


class Command(Enum):
    FORWARD = "forward"
    UP = "up"
    DOWN = "down"


class Submarine:
    __depth: int = 0
    __pos: int = 0

    def get_depth(self) -> int:
        return self.__depth

    def get_pos(self) -> int:
        return self.__pos

    def forward(self, amount: int) -> None:
        self.__pos += amount

    def up(self, amount: int) -> None:
        self.__depth -= amount

    def down(self, amount: int) -> None:
        self.__depth += amount


def main():
    submarine = Submarine()
    with fileinput.input() as f:
        for line in f:
            command, parameter = line.rstrip().split(" ")
            amount = int(parameter)

            if command == Command.FORWARD.value:
                submarine.forward(int(amount))
            elif command == Command.UP.value:
                submarine.up(amount)
            elif command == Command.DOWN.value:
                submarine.down(amount)

    print(submarine.get_depth() * submarine.get_pos())


if __name__ == "__main__":
    main()
