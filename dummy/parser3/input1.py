def main():
    a=0
    x, y, z=1, 2, 3
    x, y, z=3, 10, 5

    if x>5:
        for i in range(10):
            y=x+3
            print('greetings!')
    else:
        idx=1

    for i in range(10):
        print('welcome to python!')
        x=int(input('enter x : '))
        if x>5:
            print('hello there!')
        for j in range(z):
            a=1
    
    return 1

if __name__=="__main__":
    main()