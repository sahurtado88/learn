if __name__ == '__main__':
    N = int(input())
    l = []
    for i in range(N):
        line = input().split(" ")
        oper = line[0]
        if oper == "print":
            print(l)
        else:
            args = line[1:]
            args = [(int)(n) for n in args]
            getattr(l, oper)(*args)