from __future__ import print_function
import numpy as np

import math
import cv2
import cv2 as cv
import argparse

arr_low_h = [31, 0, 153, 162]
arr_high_h = [56, 30, 172, 180]

arr_low_s = [85, 144, 82, 50]
arr_high_s = [255, 255, 255, 189]

arr_low_v = [17, 169, 0, 179]
arr_high_v = [175, 245, 255, 255]

arr_dilation = []
arr_erosion = []

kolor = ['zielony','zolty','fioletowy','czerwony']

# Parametry Zielony
low_H = 31
high_H = 56

low_S = 85
high_S = 255

low_V = 17
high_V = 175

# Parametry Zolty
# low_H = 0
# high_H = 30
#
# low_S = 144
# high_S = 255
#
# low_V = 169
# high_V = 245

# parametry fioletowy
# low_H = 153
# high_H = 172
#
# low_S = 82
# high_S = 255
#
# low_V = 0
# high_V = 255
# czerwony
# low_H = 162
# high_H = 180
#
# low_S = 50
# high_S = 189
#
# low_V = 179
# high_V = 255

kernelE = np.ones((6, 6), np.uint8)
kernelD = np.ones((5, 5), np.uint8)

imgs = ["data/01.jpg", "data/02.jpg", "data/03.jpg", "data/04.jpg", "data/05.jpg", "data/06.jpg", "data/07.jpg",
        "data/08.jpg", "data/09.jpg", "data/10.jpg",
        "data/11.jpg", "data/12.jpg", "data/13.jpg", "data/14.jpg", "data/15.jpg", "data/16.jpg", "data/17.jpg",
        "data/18.jpg", "data/19.jpg", "data/20.jpg",
        "data/21.jpg", "data/22.jpg", "data/23.jpg", "data/24.jpg", "data/25.jpg", "data/26.jpg", "data/27.jpg",
        "data/28.jpg", "data/29.jpg", "data/30.jpg",
        "data/31.jpg", "data/32.jpg", "data/33.jpg", "data/34.jpg", "data/35.jpg", "data/36.jpg", "data/37.jpg",
        "data/38.jpg", "data/39.jpg"]

wyniki = [0, 6, 5, 5, 5, 5, 6, 6, 6, 6,
          0, 0, 4, 4, 4, 4, 4, 0, 2, 0,
          0, 1, 1, 1, 1, 1, 3, 3, 3, 3,
          3, 3, 3, 4, 4, 4, 2, 2, 2]

wynikiZo = [10, 8, 4, 4, 4, 4, 5, 0, 0, 2,
            2, 2, 2, 2, 8, 8, 8, 2, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 2, 2,
            9, 9, 9, 9, 4, 4, 2, 2, 2]

wynikiPu = [5, 5, 3, 3, 3, 3, 0, 0, 0, 0,
            4, 4, 4, 4, 4, 4, 4, 0, 0, 0,
            3, 0, 2, 2, 2, 2, 2, 2, 2, 3,
            2, 2, 2, 4, 4, 4, 2, 2, 2]

wynikiCZ = [0, 0, 9, 6, 6, 6, 8, 8, 8, 4,
            4, 4, 4, 4, 4, 4, 4, 0, 0, 3,
            0, 0, 0, 0, 3, 3, 3, 3, 3, 3,
            3, 3, 3, 4, 4, 4, 2, 2, 2]

wynikiAll = [wyniki, wynikiZo, wynikiPu, wynikiCZ]

skutecznosc = 0
pomylki = 0

skutecznosckoloru = [0,0,0,0]

wartKolor = [0,0,0,0]

licznik = 0

Result = [];

while True:

    img = cv.imread(imgs[licznik], cv.IMREAD_COLOR)

    imgR = cv2.resize(img, (0, 0), fx=0.25, fy=0.25, interpolation=cv2.INTER_AREA)

    imgB = cv2.blur(imgR, (5, 5), cv.BORDER_DEFAULT)

    if imgB is None:
        break

    frame_HSV = cv.cvtColor(imgB, cv.COLOR_BGR2HSV)

    for i in range(4):

        frame_threshold = cv.inRange(frame_HSV, (arr_low_h[i], arr_low_s[i], arr_low_v[i]), (arr_high_h[i], arr_high_s[i], arr_high_v[i]))

        erosion = cv.erode(frame_threshold, kernelE, iterations=1)
        dilation = cv.dilate(erosion, kernelD, iterations=1)

        cv.imshow('Orginal', imgR)
        cv.imshow('thresh', frame_threshold)

        cv.imshow('open', dilation)

        contours, _ = cv2.findContours(dilation, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)

        cv2.drawContours(imgR, contours, -1, (0, 0, 0), 3)
        cv2.imshow('cont', imgR)
        wartKolor[i]+=len(contours)

        if wynikiAll[i][licznik] != len(contours):
            print(imgs[licznik])
            print(kolor[i])
            print('Wyszlo: ', len(contours), ", a powinno: ", wynikiAll[i][licznik])
            key = cv.waitKey(30)
            pomylki += 1
        else:
            key = cv.waitKey(30)
            skutecznosckoloru[i] += 1;
        if key == ord('q'):
            break

    licznik += 1
    

    if key == ord('q') or key == 27 or licznik == len(imgs):
        for i in  range(4):
            print(f'skuteczność kolor: {kolor[i]} wynosi {skutecznosckoloru[i]*100/len(imgs)}')
        print('pomylki:', pomylki)

        numerator = abs(sum(wynikiAll[0])-wartKolor[0]) + abs(sum(wynikiAll[1])-wartKolor[1]) +abs(sum(wynikiAll[2])-wartKolor[2]) + abs(sum(wynikiAll[3])-wartKolor[3])
        denumrator = sum(wynikiAll[0])+ sum(wynikiAll[1])+ sum(wynikiAll[2])+ sum(wynikiAll[3])
        wynika = 100/len(imgs) * (numerator/denumrator)
        print('wynik:',wynika)
        break