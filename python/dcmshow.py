from __future__ import print_function

import numpy as np
import matplotlib.pyplot as plt
import pdb


class slice_view(object):
    def __init__(self, ax, X):
        self.ax = ax
        ax.set_title('use scroll wheel to navigate images')
        self.X = X  
#        pdb.set_trace()
        rows, cols, self.slices = X.shape
        self.ind = self.slices*7//10
        self.im = ax.imshow(self.X[:, :, self.ind], vmin = np.min(X), vmax = np.max(X))
        self.update()

    def onscroll(self, event):
        if event.button == 'up':
            self.ind = (self.ind + 1) % self.slices
        else:
            self.ind = (self.ind - 1) % self.slices
        self.update()

    def update(self):
        self.im.set_data(self.X[:, :, self.ind])
        self.ax.set_ylabel('slice %s' % self.ind)
        self.im.axes.figure.canvas.draw()
        
def dcmshow(X, my_title = ''):
    fig, ax = plt.subplots()
    tracker = slice_view(ax, X)
    fig.canvas.mpl_connect('scroll_event', tracker.onscroll)
    if (my_title != ''):
        plt.suptitle(my_title , fontsize=18, y=0.98)
        plt.title("Press [Q] to exit ", color="grey", style='italic')
        
    plt.show()
    while True:
        if plt.waitforbuttonpress():
            break
    plt.close(fig)

1
