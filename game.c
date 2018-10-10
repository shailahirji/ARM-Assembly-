//Shaila Hirji
//Computer Architecture Assignment 3, Convert C code to Assembly

#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int main(){

    srand(time(0));
    int number= rand() % 10;
    int guess;
    int count=0;

    printf("%s","Guess the number: ");

    do {
        fscanf(stdin, "%d", &guess); //get user input
        fflush(stdin);

        if (guess - number > 0) {
            printf("Too high. Guess again. ");
        }

        else if (guess - number < 0) {
            printf("Too low.Guess again. ");
        }
        count++;

    }while(guess != number);

    printf("You guessed correctly in %d tries",count);
    return 0;
}