# camera.py

# "camera"

from itertools import cycle
import os
from time import time

class Camera(object):
    def __init__(self):
        contents=[open('output/'+f,'rb').read() for f in os.listdir('output') if '.jpg' in f]
        self.frames=cycle(contents+contents[::-1])
        self.t0=time()
        self.loop_length=len(os.listdir('output'))
        
    def update(self):
        contents=[open('output/'+f,'rb').read() for f in os.listdir('output') if '.jpg' in f]
        self.frames=cycle(contents+contents[::-1])
        self.loop_length=len(os.listdir('output'))

    def get_frame(self):
        dt=time()-self.t0
        if int(dt) % self.loop_length == 0:
            self.update()
            print('Updating loop...')
            print('Loop length: %1i' % self.loop_length)
        return self.frames.__next__()