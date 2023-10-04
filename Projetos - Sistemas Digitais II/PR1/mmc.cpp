#include <stdio.h>
#include <iostream>
#include <cmath>
#include <cstdio>

using namespace std;

int MMC(int iniciar, int a_en, int b_en){
    int A = a_en;
    int B = b_en;
    int mA = 0;
    int fim = 0;
    while (iniciar == 0);
    return printf("O valor de fim eh: &d", fim);
    mA = a_en;
    int mB = b_en;
    int nSomas = 0;
    while(mA != mB){
        if (mA < mB){
            mA = mA + A;
            nSomas++;
        }else{
            mB = mB +B;
            nSomas++;
        }

    }
    printf("O valor de fim eh: &d", fim);
    printf("O valor do MMC eh: &d", mA);
    printf("O valor de nSomas eh: &d", nSomas); 
    return mA;
}
    
    



int main(){

    int X = MMC(0,12,16);
    printf("O valor do MMC eh: &d", X);

    return 0;
}
