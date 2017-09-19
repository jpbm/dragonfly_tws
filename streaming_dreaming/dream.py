import os
import sys

# heartbeat
pid=str(os.getpid())
pidfile='/home/ubuntu/tmp/dreaming.pid'
file(pidfile,'w').write(pid)

# run program
import deepdream as dd
import numpy as np
import PIL.Image as Image
from time import sleep, time

processed=set([])
i=0
total=0
print 'Entering processing loop...'
while True:
    for path in os.listdir('input/'):
        if '.jpg' in path and path not in processed:
            try:
                t0=time()
                i=i+1
                img=np.float32(Image.open('input/'+path))
                dream_img=dd.deepdream(dd.net,img)
                out_image=Image.fromarray(np.uint8(dream_img))
                out_image.save('output/'+path)
                processed.add(path)
                os.remove('input/'+path)
                dt=time()-t0
                total=total+dt
                avtime=total/i
                print path, ' processed.'
                print 'time per frame: ', avtime
            except:
                print path, ' processing error'
                sleep(2)
