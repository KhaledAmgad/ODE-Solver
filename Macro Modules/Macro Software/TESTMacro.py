import numpy as np

f= open("TestCasesMacro.txt","a+")
cont =1
sfUp=2**7

while cont !=4:

 print ( "1- ODE")
 print ( "2- Interpolate")
 print ( "3- Step")
 print ( "4- Exit")
 cont = int(input("Enter choice : "))
 
 if cont ==1  :
    N = int(input("Enter N: "))
    M = int(input("Enter M: "))
    h = float(input("Enter h : "))
    index= int(input("Enter index of Xnext: "))
  
    Xo = []
    A=[]
    B=[]
    U=[]
    print("Enter Xprev ")
    for i in range(N): 
       ele = float(input()) 
       Xo.append(ele)
    print("Enter Arow ")
    for i in range(N): 
       ele = float(input()) 
       A.append(ele) 
    print("Enter Brow ")
    for i in range(M): 
       ele = float(input()) 
       B.append(ele) 
    print("Enter U ")
    for i in range(M): 
       ele = float(input()) 
       U.append(ele)  
    
    
 

    AmulX = 0
    for i in range(N):
        AmulX = AmulX + (A[i]*Xo[i])
    
    BmulU = 0
    for i in range(M):
        BmulU = BmulU + (B[i]*U[i])
    
    Xnext = Xo[index-1] + AmulX*h + BmulU*h

    XNEXT= np.uint16(Xnext*sfUp)
    binXnext = '{0:016b}'.format(XNEXT)
    
    print ("X"+ " "+ str(index) +  "    =   " +str(binXnext)  )
    print (str(Xnext))
    f.write("X" + " "+ str(index) +  "    =   " +str(binXnext) + "\n")
    
    


    
 elif cont == 2:
    M = int(input("Enter M: "))


  
    Uk=  np.zeros(M) 
    Un=  np.zeros(M)
    Uz=  np.zeros(M)
    Tk= int(input("Enter Tk: "))
    Tn= int(input("Enter Tn: "))
    Tz= int(input("Enter Tz: "))
    
    if Tz-Tn==0 or (Tz-Tn)>=256 or (Tz-Tn)<-256 :
        print("Error")
        
    else:
        
    
        print("Enter Un ")
        for i in range(M): 
           Un[i] = float(input("Enter Un["+str(i) +"] ")) 
    
        
        print("Enter Uz ")
        for i in range(M): 
           Uz[i] = float(input("Enter Uz["+str(i) +"] ")) 
           
           
           
        if  np.any((Uz-Un)>=256) or np.any((Uz-Un)<-256) or np.any(((Uz-Un)/(Tz-Tn))>=256) or np.any(((Uz-Un)/(Tz-Tn))<-256) or np.any(((Tk-Tn)*((Uz-Un)/(Tz-Tn)))>=256) or np.any(((Tk-Tn)*((Uz-Un)/(Tz-Tn)))<-256) or np.any((Un+(Tk-Tn)*((Uz-Un)/(Tz-Tn))) >=256) or np.any((Un+(Tk-Tn)*((Uz-Un)/(Tz-Tn)))<-256):
        
            print("Error")
        else:         
    
            Uk=Un+(Tk-Tn)*((Uz-Un)/(Tz-Tn))
            print("Uk")
            for i in range(M): 
                print("Uk["+str(i) +"] "+str(Uk[i]))
            
            
            
            print("M= "+str('{0:016b}'.format(np.uint16(M*sfUp))))
            f.write("M= "+str('{0:016b}'.format(np.uint16(M*sfUp))))
            
            print("TK= "+str('{0:016b}'.format(np.uint16(Tk*sfUp))))
            print("Tn= "+str('{0:016b}'.format(np.uint16(Tn*sfUp))))
            print("Tz= "+str('{0:016b}'.format(np.uint16(Tz*sfUp))))
            print("Un[i]                 Uz[i]             Uk[i] ")
            
            
            
            f.write("TK= "+str('{0:016b}'.format(np.uint16(Tk*sfUp))))
            f.write("Tn= "+str('{0:016b}'.format(np.uint16(Tn*sfUp))))
            f.write("Tz= "+str('{0:016b}'.format(np.uint16(Tz*sfUp))))
            f.write("Un[i]                 Uz[i]             Uk[i] ")
            for i in range(M): 
                print(str('{0:016b}'.format(np.uint16(Un[i]*sfUp)))+" "+str('{0:016b}'.format(np.uint16(Uz[i]*sfUp)))+" "+str('{0:016b}'.format(np.uint16(Uk[i]*sfUp))))
                f.write(str('{0:016b}'.format(np.uint16(Un[i]*sfUp)))+" "+str('{0:016b}'.format(np.uint16(Uz[i]*sfUp)))+" "+str('{0:016b}'.format(np.uint16(Uk[i]*sfUp))))       



 elif cont == 3: 
    #X vector size N
    N = int(input("Enter N: "))
    NBin = str('{0:016b}'.format(np.uint16(N*sfUp)))
    
    L = float(input("Enter L: "))
    #L = L * N
    L = L * N
    LBin = str('{0:016b}'.format(np.uint16(L*sfUp)))
    
    #step time h
    h = float(input("Enter h : "))
    
    #accumlating buffers for Xn+1(0) , Xn+1(1) respectively
    AccBf1 = 0
    AccBf2 = 0
    
    print("Enter Xn+1(0) ")
    for i in range(N): 
        ele = float(input()) 
        AccBf1 = AccBf1 + ele

    print("Enter Xn+1(1) ")
    for i in range(N): 
        ele = float(input()) 
        AccBf2 = AccBf2 + ele
    
    AccBf1Bin = str('{0:016b}'.format(np.uint16(AccBf1*sfUp)))
    AccBf2Bin = str('{0:016b}'.format(np.uint16(AccBf2*sfUp)))
    
    #calculating the error
    error = abs(AccBf1 - AccBf2)
    errorBin = str('{0:016b}'.format(np.uint16(error*sfUp)))
    
    #inform the coordinator that L >= e so it should increment the current time
    incTime = 1
    #errorException sent to the coordinator in case of overflow,divbyzero
    errorException = 0
    if(error > L):
        #check on the divbyzero
        if(error == 0):
            errorException = 1
        else:
            #modify the h
            h = 0.9*h*h*L/error
            incTime = 0
    
    #check on the overflow
    if(AccBf1 >= 256 or AccBf1 < -256 or AccBf2 >= 256 or AccBf2 < -256 or h >= 256 or h < -256 or error >= 256 or error < -256):
        errorException = 1

    hBin = str('{0:016b}'.format(np.uint16(h*sfUp)))
    
    f.write("N = " + NBin + "\n")
    f.write("L = " + LBin + "\n")
    f.write("AccBuf1 = " + AccBf1Bin + "\n")
    f.write("AccBuf2 = " + AccBf2Bin + "\n")
    f.write("error = " + errorBin + "\n")
    f.write("h = " + hBin + "\n")
    f.write("incTime = " + str(incTime) + "\n")
    f.write("errorException = " + str(errorException) + "\n")

 else:
    f.close()
    break


