def main():
  x=1
  a=3
  a=x*3+5
  if x>a:
    print('Hi!!')
    a=x*3+100
    if x>a:
      print('Hi!!')
      a=x*3+100
    else:
      x=a*3+100
  else:
    x=a*3+100
  return 

if __name__=="__main__":
  main()
