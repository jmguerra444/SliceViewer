# SliceViewer
MATLAB interface for slice visualization given a volume.

This UI receives as an input argument a 3-dim matrix and launches the slice viewer called DCMSHOW.
The syntax to call UI is:

``` matlab
A = rand(100,100,100) %creates 100x100x100 random matrix
dcmshow(A) %launches UI
```

The following functions are included:
* Basic image functionalities: navigate through slices, zoom and get pixel values.
* Mesure distances in image
* Noise quantifiction: mean and standard deviation computation inside patch.
* Change visualization window