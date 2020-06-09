import numpy as np

f= open("TestCases.txt","a+")
cont =1
sfUp=2**7
sfDown=2**-7

while cont !=5:

 print ( "1- Add")
 print ( "2- Sub")
 print ( "3- Multiply")
 print ( "4- Divide")
 print ( "5- Exit")
 cont = int(input("Enter choice : "))
 
 if cont ==1 or cont ==2 :
    
    a = float(input("Enter 1st number: "))
    b = float(input("Enter 2nd number: "))
    if cont ==2:
        b=-b

    aa = np.uint16(a*sfUp)
       
    bb = np.uint16(b*sfUp)
       
    sum=a+b
    bina = '{0:016b}'.format(aa)
    binb = '{0:016b}'.format(bb)
    
    
    sumSigned= np.int16(sum*sfUp)
    summ= np.uint16(sum*sfUp)
    binSum = '{0:016b}'.format(summ)
    if sumSigned!=sum*sfUp:
        print("Overflow")
    print (str(bina) + " + " + str(binb) +  "  =  " +str(binSum)  )
    print (str(sum))
    f.write(str(bina) + " +  "+ str(binb) +"  = "+ str(binSum) + "\n")
    
    


    
 elif cont == 3:
    
    a = float(input("Enter 1st number: "))
    b = float(input("Enter 2nd number: "))
    if cont ==2:
        b=-b

    aa = np.uint16(a*sfUp)
       
    bb = np.uint16(b*sfUp)
       
    sum=a*b
    bina = '{0:016b}'.format(aa)
    binb = '{0:016b}'.format(bb)
    
    
    sumSigned= np.int16(sum*sfUp)
    summ= np.uint16(sum*sfUp)
    binSum = '{0:016b}'.format(summ)
    if sumSigned!=sum*sfUp:
        print("Overflow")
    print (str(bina) + " + " + str(binb) +  "  =  " +str(binSum)  )
    print (str(sum))
    f.write(str(bina) + " +  "+ str(binb) +"  = "+ str(binSum) + "\n")
    
    
    
 elif cont == 4: 

    a = float(input("Enter 1st number: "))
    b = float(input("Enter 2nd number: "))

    if b==0:
        print("Divid By ZERO")

    else:
      
        signAint =0
        signBint =0
   
        if a<0:
          signAint =1
        
        if b<0:
          signBint =1
        
    
        aa = np.uint16(a*sfUp)
        bb = np.uint16(b*sfUp)
           
        sum=int((a/b)*sfUp)
        bina = '{0:016b}'.format(aa)
        binb = '{0:016b}'.format(bb)
        
        sumSigned= np.int16(sum)
        summ= np.uint16(sum)
        binSum = '{0:016b}'.format(summ)
        if sumSigned!=sum:
            print("Overflow")

        sumsign = signAint + signBint 
    
        if sumsign == 1:
         binSum = binSum [1:16]
         print (str(bina) + " / "+  str(binb) +  "  =  " +"1"+str(binSum)  )
         print (str(sum*sfDown))
         f.write(str(bina) + " /  "+str(binb) +"  = "+ "1"+str(binSum) + "\n")
        else:
         binSum = binSum [1:16]
         print (str(bina) + " / " + str(binb) +  "  =  " +"0"+str(binSum)  )
         print (str(sum*sfDown))
         f.write(str(bina) + " /  "+str(binb) +"  = "+ "0"+str(binSum) + "\n")
       
    
      
 else:
    f.close()
    break





