from __future__ import print_function
import numpy as np

import cv2
import cv2 as cv
import argparse

max_value = 255
max_value_H = 360 // 2
low_H = 153
low_S = 82
low_V = 0
high_H = 172
high_S = 255
high_V = 255
window_capture_name = 'Video Capture'
window_detection_name = 'Object Detection'
low_H_name = 'Low H'
low_S_name = 'Low S'
low_V_name = 'Low V'
high_H_name = 'High H'
high_S_name = 'High S'
high_V_name = 'High V'


imgs = ["data/01.jpg","data/02.jpg","data/03.jpg","data/04.jpg","data/05.jpg","data/06.jpg","data/07.jpg","data/08.jpg","data/09.jpg","data/10.jpg"]

def on_low_H_thresh_trackbar(val):
    global low_H
    global high_H
    low_H = val
    low_H = min(high_H - 1, low_H)
    cv.setTrackbarPos(low_H_name, window_detection_name, low_H)


def empty(val):
    pass


def on_high_H_thresh_trackbar(val):
    global low_H
    global high_H
    high_H = val
    high_H = max(high_H, low_H + 1)
    cv.setTrackbarPos(high_H_name, window_detection_name, high_H)


def on_low_S_thresh_trackbar(val):
    global low_S
    global high_S
    low_S = val
    low_S = min(high_S - 1, low_S)
    cv.setTrackbarPos(low_S_name, window_detection_name, low_S)


def on_high_S_thresh_trackbar(val):
    global low_S
    global high_S
    high_S = val
    high_S = max(high_S, low_S + 1)
    cv.setTrackbarPos(high_S_name, window_detection_name, high_S)


def on_low_V_thresh_trackbar(val):
    global low_V
    global high_V
    low_V = val
    low_V = min(high_V - 1, low_V)
    cv.setTrackbarPos(low_V_name, window_detection_name, low_V)


def on_high_V_thresh_trackbar(val):
    global low_V
    global high_V
    high_V = val
    high_V = max(high_V, low_V + 1)
    cv.setTrackbarPos(high_V_name, window_detection_name, high_V)


img = cv.imread('data/10.jpg', cv.IMREAD_COLOR)
img1 = cv.imread('data/12.jpg', cv.IMREAD_COLOR)
img2 = cv.imread('data/13.jpg', cv.IMREAD_COLOR)
img3 = cv.imread('data/04.jpg', cv.IMREAD_COLOR)
img4 = cv.imread('data/05.jpg', cv.IMREAD_COLOR)

cap = cv2.resize(img,(0, 0), fx=0.25, fy=0.25, interpolation = cv2.INTER_AREA)
cap1 = cv2.resize(img1,(0, 0), fx=0.25, fy=0.25, interpolation = cv2.INTER_AREA)
cap2 = cv2.resize(img2, (0, 0), fx=0.25, fy=0.25, interpolation = cv2.INTER_AREA)
cap3 = cv2.resize(img3, (0, 0), fx=0.25, fy=0.25, interpolation = cv2.INTER_AREA)
cap4 = cv2.resize(img4,(0, 0), fx=0.25, fy=0.25, interpolation = cv2.INTER_AREA)

cv.namedWindow(window_capture_name)
cv.namedWindow(window_detection_name)
cv.createTrackbar(low_H_name, window_detection_name, low_H, max_value_H, on_low_H_thresh_trackbar)
cv.createTrackbar(high_H_name, window_detection_name, high_H, max_value_H, on_high_H_thresh_trackbar)
cv.createTrackbar(low_S_name, window_detection_name, low_S, max_value, on_low_S_thresh_trackbar)
cv.createTrackbar(high_S_name, window_detection_name, high_S, max_value, on_high_S_thresh_trackbar)
cv.createTrackbar(low_V_name, window_detection_name, low_V, max_value, on_low_V_thresh_trackbar)
cv.createTrackbar(high_V_name, window_detection_name, high_V, max_value, on_high_V_thresh_trackbar)

cv.createTrackbar('Dylacja', window_detection_name, 1, 8, empty)
cv.createTrackbar('Erozja', window_detection_name, 1, 8, empty)



licznik = 0
while True:

    dylacja = cv.getTrackbarPos('Dylacja',window_detection_name)
    erozja = cv.getTrackbarPos('Erozja',window_detection_name)

    kernel = np.ones((erozja, erozja), np.uint8)
    kernel2 = np.ones((dylacja, dylacja), np.uint8)

    if licznik == 0:
        frame = cv.blur(cap, (5,5), cv.BORDER_DEFAULT)
    if licznik == 1:
        frame = cv.blur(cap1, (3,3), cv.BORDER_DEFAULT)
    if licznik == 2:
        frame = cv.blur(cap2, (5,5), cv.BORDER_DEFAULT)
    if licznik == 3:
        frame = cv.blur(cap3, (5,5), cv.BORDER_DEFAULT)
    if licznik == 4:
        frame = cv.blur(cap4, (5,5), cv.BORDER_DEFAULT)

    if frame is None:
        break
    frame_HSV = cv.cvtColor(frame, cv.COLOR_BGR2HSV)
    frame_threshold = cv.inRange(frame_HSV, (low_H, low_S, low_V), (high_H, high_S, high_V))

    erosion = cv.erode(frame_threshold, kernel, iterations=1)
    dilation = cv.dilate(erosion,kernel2,iterations = 1)

    opening = cv.morphologyEx(frame_threshold, cv.MORPH_OPEN, kernel)
    opening = cv.morphologyEx(opening, cv.MORPH_OPEN, kernel)
    # dilation = cv.dilate(opening, kernel2, iterations=1)
    opening = dilation



    cv.imshow(window_capture_name, frame)
    cv.imshow(window_detection_name, frame_threshold)
    cv.imshow('testme', dilation)

    contours, _ = cv2.findContours(dilation, cv2.RETR_TREE, cv2.CHAIN_APPROX_NONE)
    contoursORG, _ = cv2.findContours(frame_threshold, cv2.RETR_TREE, cv2.CHAIN_APPROX_NONE)

    key = cv.waitKey(30)
    cv2.drawContours(frame, contours, -1, (0, 0, 0), 3)
    cv2.imshow('cont', frame)
    print(len(contours))


    if key == ord('a'):
        licznik -= 1
    if key == ord('d'):
        licznik += 1

    if key == ord('q') or key == 27 or licznik ==5:
      break