# Project Name

### Project Description:
#### Summary - This project combines edge detection, DCT based compression analysis and histogram comparison to detect image tampering effectively. Canny Edge detection highlights discrepanciesm while 8x8 DCT blocks identify suble compression inconsistencies. Histogram analysis complements these methods by detecting pixel intensity anomalies. The approach is light weight, accurate and suitable for real-time use, performing realiable across various tampering scenarios.

#### Course concepts used - 
1. - Canny Edge Detection.
2. - Discrete Cosine Transform.
3. - Histogram Analysis. 
   
#### Additional concepts used -
1. - Correlation Map
   
#### Dataset - 
Columbia Uncompressed Image Splicing Detection Evaluation Dataset:https://www.ee.columbia.edu/ln/dvmm/downloads/authsplcuncmp/

#### Novelty - 
1. - Combined Approach - Uses edge detaction and DCT-based compression analysis to spot tampered areas.
2. - Gradient Analyses - Identifies irregular gradients in specific regions to highlight tampering.
3. - No nueral network - Faster and Easier to interpret.
   
### Contributors:
1. Aashna Ali (PES1UG22EC002)
2. Ankitha M (PES1UG22EC038)
3. Archana V M (PES1UG22EC044)

### Steps:
1. Clone Repository
```git clone https://github.com/Digital-Image-Processing-PES-ECE/project-name.git ```

2. Install Dependencies
```pip install -r requirements.txt```

3. Run the Code
```python main.py (for eg.)```

### Outputs:


### References:
1. - Gonzalez, R.C., & Woods, R.E.
     Digital Image Processing, 4th Edition, Pearson, 2018
2. - Columbia Uncompressed Image Splicing Detection Evaluation Dataset: https://www.ee.columbia.edu/ln/dvmm/downloads/authsplcuncmp/
3. - Image forgery detection using MATLAB: https://www.pantechsolutions.net/image-forgery-detection-using-           matlab#:~:text=PROPOSED%20METHOD&text=First%2C%20an%20adaptive%20over%2Dsegmentation,as%20Block%20Features%20(BF)
4. - MATLAB Documentation

   
### Limitations and Future Work: 
1. - When both the input images are tampered, the output shows that the images are not tampered.
2. - This works with two images at a time. 
