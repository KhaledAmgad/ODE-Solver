import json
import numpy as np
#notes
#RLE needs 3 fixed bits
#ex:  01 -> 001 0  001 1
#also  000 -> 1 , 001 -> 2 , .. , 111->8
def RLE(data):
    output = ''
    prev_char = ''
    count = 1

    if not data: return ''

    for char in data:

        if char != prev_char:

            if prev_char:
                
                output += f'{count-1:03b}' + prev_char
            count = 1
            prev_char = char
        else:

            count += 1
    else:
        output +=f'{count-1:03b}' + prev_char
        return output


sfUp=2**7

arr = []
binarr=[]
with open('data.json','r') as fid_json:
    # get json as type dict
    json_dict = json.load(fid_json)
    #print(json_dict)
    arr.append(json_dict['N']) #0
    arr.append(json_dict['M']) #1
    arr.append(json_dict['Mode']) #2
    arr.append(json_dict['H'])
    arr.append(json_dict['Err'])
    arr.append(json_dict['Fixedpoint'])
    arr.append(json_dict['Count'])
    arr.append(json_dict['A']) #7
    arr.append(json_dict['B'])
    arr.append(json_dict['X0'])
    arr.append(json_dict['T'])
    arr.append(json_dict['U0'])
    arr.append(json_dict['Us'])
    
    file = open("Binary.txt","w") 
    #print(arr)
    for i in range (7):
        a=float(arr[i])
        aa = np.uint16(a*sfUp)
        bina = '{0:016b}'.format(aa)
        binarr.append(bina)
      
    n=arr[0]
    m= arr[1]    
    Asize= n *n
    #print(Asize)
    A=arr[7]
    #print(A)
    for nn in range (n):
        for nnn in range (n):
            a=float(A[nn][nnn])
            #print(a)
            aa = np.uint16(a*sfUp)
            bina = '{0:016b}'.format(aa)
            binarr.append(bina)
            
            
    B=arr[8]  
    #print(B)         
    for nn in range (n):
        for mm in range (m):
            a=float(B[nn][mm])
            #print(a)
            aa = np.uint16(a*sfUp)
            bina = '{0:016b}'.format(aa)
            binarr.append(bina)
    
        
    X = arr[9]
    #print(X)
    for x in range (n):
        a=float(X[x])
        #print(a)
        aa = np.uint16(a*sfUp)
        bina = '{0:016b}'.format(aa)
        binarr.append(bina)
        
        
    T = arr[10]
    #print(T)
    for t in range (m):
        a=float(T[t])
        #print(a)
        aa = np.uint16(a*sfUp)
        bina = '{0:016b}'.format(aa)
        binarr.append(bina)
        
        
    Un = arr[11]
    #print(Un)
    for un in range (m):
        a=float(Un[un])
        #print(a)
        aa = np.uint16(a*sfUp)
        bina = '{0:016b}'.format(aa)
        binarr.append(bina)        
        
        
    Us = arr[12]
    
    rows = len(Us)
    columns = len(Us[0])
    for r in range (rows):
        for c in range (columns):
            a=float(Us[r][c])
            #print(a)
            aa = np.uint16(a*sfUp)
            bina = '{0:016b}'.format(aa)
            binarr.append(bina)

#print (arr) 
#s = "000000011111111"
#ss='0000000110000000'
#print(ss)
#print(RLE(s))
#print(RLE(ss))


n = len(binarr)
print(binarr)
print(n)
rle = []      
for i in range (n):
    rle.append(RLE(binarr[i]))
   
print (rle) 
print(len(rle))  
for i in range (0 , 7 ):
    file.write(rle[i])
file.write("\n")    
#then each row of A (n*n)    
SizeA = arr[0]    
#print(SizeA)
for i in range (8 , 8+SizeA):
    for j in range (0 , SizeA):
        file.write(rle[i+j])
    file.write("\n")    


#then each row of A (n*m)    
SizeBn = arr[0] 
SizeBm = arr[1] 
index=   8+(SizeA*SizeA)+1
#print(index) #18
for k in range (index , index+SizeBn):
    for l in range (0 , SizeBm):
        file.write(rle[k+l])
    file.write("\n")    

xoindex= index+(SizeBn*SizeBm)
#print(xoindex)
file.write(rle[xoindex])   
file.write("\n")
for b in range(xoindex+1 , len(rle)):
    file.write(rle[b])
file.close()
