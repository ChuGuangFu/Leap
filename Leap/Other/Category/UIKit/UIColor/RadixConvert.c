//
//  RadixConvert.c
//  Leap
//
//  Created by 梁羽 on 2017/6/7.
//  Copyright © 2017年 梁羽. All rights reserved.
//

#include <stdio.h>

int radixConvert(char str[]) {
    int result = 0;
    sscanf(str, "%X", &result);
    return result;
}
