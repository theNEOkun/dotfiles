import re

class Mapping:
    modkeys: str
    key: str
    function: str

    def __init__(self, modkeys: str, key: str, function: str):
        self.modkeys = modkeys.strip()
        self.key = key.strip() if key.strip() != "0" else "None"
        self.function = function.strip()

    def __str__(self):
        return f"{self.modkeys}, {self.key}, {self.function}"


class mouseMapping(Mapping):
    extra: str
    def __init__(self, modkeys: str, key: str, function: str, extra: str):
        super().__init__(modkeys, key, function)
        self.extra = extra.strip()

    def __str__(self):
        return f"{self.modkeys}, {self.key}, {self.function}, {self.extra}"


def main():
    mapping = Mapping("Shift", "Enter", "Run")
    keyMapList = []
    mouseMapList = []
    with open("./dwm/config.h", "r") as file:
        searchKeyMap = False
        searchMouseMap = False
        for each in file.readlines():
            if not searchKeyMap and re.search("static Key", each):
                searchKeyMap = True
            if searchKeyMap and re.search("^\s*{", each):
                keyMapList.append(each.strip())
            if searchKeyMap and re.search("^\s*};", each):
                searchKeyMap = False
            if not searchMouseMap and re.search("static Button", each):
                searchMouseMap = True
            if searchMouseMap and re.search("^\s*{", each):
                mouseMapList.append(each)
            if searchMouseMap and re.search("^\s*};", each):
                searchMouseMap = False
    mapList = []
    for each in keyMapList:
        init_list = [x for x in each.split(",") if x != ""]
        init_map = Mapping(init_list[0][2:], init_list[1], init_list[2])
        mapList.append(init_map)
    mouseList = []
    for each in mouseMapList:
        init_list = [x for x in each.split(",") if x != ""]
        init_map = mouseMapping(init_list[0][2:], init_list[1], init_list[2],
                                init_list[3])
        mouseList.append(init_map)


    with open("./dwm_bindings", "w") as file:
        for each in mapList:
            file.write(each.__str__() + "\n")
        file.write("---\n")
        for each in mouseList:
            file.write(each.__str__() + "\n")


if __name__ == '__main__':
    main()
