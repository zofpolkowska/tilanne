import numpy as np
import cv2
from erlport.erlang import cast
from erlport.erlterms import Atom

def overexposed(path, pid):
    img = cv2.imread(path)
    hist = cv2.calcHist([img],[0],None,[256],[0,256])
    regions =  np.array_split(hist,8)
    s = 0
    sums = [np.sum(x) for x in regions]
    for i in range(0,6):
        s = s + sums[i]
    if sums[7] > s:
        cast(pid,Atom('overexposed!'))
        return 1
    else:
        return 0

def blurry(path, pid):
    img = cv2.imread(path, 0)
    laplasjan_variance = cv2.Laplacian(img, cv2.CV_64F).var()
    if float(laplasjan_variance) < 250.0:
        cast(pid,Atom('blurry!'))
        return 1
    else:
        return 0

def people(path, pid):
    cast(pid,Atom('not implemented'))
    return 0

def face(path, pid, model):
    cast(pid,Atom('not implemented'))
    return 0

def find(path, pid, model):
    cast(pid,Atom('not implemented'))
    return 0


