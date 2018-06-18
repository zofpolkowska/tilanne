import numpy as np
import cv2
import os
from erlport.erlang import cast
from erlport.erlterms import Atom

def test():
    return os.path.dirname(os.path.realpath(__file__))

def overexposed(path, pid, solution):
    try:
        img = cv2.imread(path)
        hist = cv2.calcHist([img],[0],None,[256],[0,256])
        regions =  np.array_split(hist,10)
        s = 0
        sums = [np.sum(x) for x in regions]
        for i in range(0,8):
            s = s + sums[i]
            if sums[9] > s:
                cast(pid,Atom('overexposed!'))
                cv2.imwrite(solution, img)
                return 1
            else:
                return 0
    except:
        return 0

def blurry(path, pid, solution):
    try:
        img = cv2.imread(path, 0)
        laplasjan_variance = cv2.Laplacian(img, cv2.CV_64F).var()
        if float(laplasjan_variance) < 250.0:
            cast(pid,Atom('blurry!'))
            cv2.imwrite(solution, img)
            return 1
        else:
            return 0
    except:
        return 0

def people(path, pid):
    cast(pid,Atom('not implemented'))
    return 0

def face(path, pid, model):
    cast(pid,Atom('not implemented'))
    return 0

def find(path, solution, model):
    try:
        img_rgb = cv2.imread(path)
        img_gray =  cv2.imread(path,0)
        w, h = img_gray.shape[::-1]
        threshold = 0.8
        t = cv2.imread(model,0)
        wi, hi = w/8, h/8
        l = []
        for i in range(1,8):
            m = cv2.resize(t, (wi*i, hi*i)) 
            w, h = m.shape[::-1]
            
            res = cv2.matchTemplate(img_gray,m,cv2.TM_CCOEFF_NORMED)
            
            min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(res)
            loc = np.where( res >= threshold)
            locs = zip(*loc[::-1])
            
            if len(locs) > 0:
                threshold = max_val
                l = locs
                #if len(locs) > 0:
                pt = 0
                for pt in l:
                    cv2.rectangle(img_rgb, pt, (pt[0] + w, pt[1] + h), (0,0,255), 2)
                    
                    cv2.imwrite(solution,img_rgb)
                    
                    #cast(pid,Atom('not implemented'))
                    return 1
    except:
        return 0



