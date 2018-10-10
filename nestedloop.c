//Shaila Hirji
//Computer Architecture Assignment 3, Convert C code to Assembly
#include <stdio.h>

int main() {


    int i,j,l=0;

    for(i=0; i < 9 ; i++){ //keeps track of what line we are on

        for(l=0; l <9-i; l++) {
            //print white space
            printf("%c",' ');
        }

        printf("%c",'*');//first star


        for (j = 1; j < i*2; j++) {
            // the number of spaces between stars are equal to i
            printf("%c",' ');
        }

        if(i>0) {
            printf("%c", '*');//second star
        }

        printf("%c", '\n');
    }

    printf("%s","*******************");





    return 0;
}